param(
  [Parameter(Position = 0)]
  [ValidateSet('on', 'off', 'status', 'enable', 'disable', 'uninstall')]
  [string]$Action = 'status'
)

$ErrorActionPreference = 'Stop'

$dshHome = if ($env:DSH_HOME) { $env:DSH_HOME } else { Join-Path $env:USERPROFILE '.dsh' }
$patchPath = Join-Path $dshHome 'cordis.patch.yml'
$skinId = 'ui-skin-aurora-nebula'
$managedStart = '# --- dsh-skin managed (auto-generated; do not edit) ---'
$managedEnd = '# --- end dsh-skin managed ---'

if ($Action -eq 'enable') { $Action = 'on' }
if ($Action -eq 'disable') { $Action = 'off' }

function Read-PatchFile {
  if (Test-Path $patchPath) {
    return Get-Content -LiteralPath $patchPath -Raw -Encoding UTF8
  }
  return ''
}

function Write-PatchFile([string]$content) {
  $dir = Split-Path -Parent $patchPath
  if (!(Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($patchPath, $content, $utf8NoBom)
}

function Split-ManagedSection {
  param([string]$Text, [ref]$Before, [ref]$Inside, [ref]$After)
  $startIdx = $Text.IndexOf($managedStart)
  if ($startIdx -lt 0) {
    $Before.Value = $Text
    $Inside.Value = ''
    $After.Value = ''
    return
  }
  $endIdx = $Text.IndexOf($managedEnd, $startIdx + $managedStart.Length)
  if ($endIdx -lt 0) {
    throw "Unterminated managed skin section in $patchPath"
  }
  $endIdx += $managedEnd.Length
  $Before.Value = $Text.Substring(0, $startIdx)
  $Inside.Value = $Text.Substring(
    $startIdx + $managedStart.Length,
    $endIdx - $startIdx - $managedStart.Length - $managedEnd.Length
  )
  $After.Value = $Text.Substring($endIdx)
}

function Remove-SkinRow {
  param([string]$InsideText)
  $lines = $InsideText -split "`r?`n"
  $out = New-Object System.Collections.Generic.List[string]
  for ($i = 0; $i -lt $lines.Count; $i++) {
    $trim = $lines[$i].Trim()
    if ($trim -eq "- id: $skinId") {
      if (($i + 1) -lt $lines.Count -and $lines[$i + 1].Trim() -match '^disabled:') {
        $i++
      }
      continue
    }
    $out.Add($lines[$i])
  }
  return ($out -join "`n").Trim()
}

function Has-SkinRow {
  param([string]$InsideText)
  return ($InsideText -split "`r?`n" | Where-Object { $_.Trim() -eq "- id: $skinId" }).Count -gt 0
}

$text = Read-PatchFile
$before = ''
$inside = ''
$after = ''
Split-ManagedSection -Text $text -Before ([ref]$before) -Inside ([ref]$inside) -After ([ref]$after)

if ($Action -eq 'uninstall') {
  # Remove the manual profile-patch insert row for this skin.
  $profilePatchPath = Join-Path $dshHome 'profiles\web\cordis.patch.yml'
  if (Test-Path $profilePatchPath) {
    $profilePatch = Get-Content -LiteralPath $profilePatchPath -Raw -Encoding UTF8
    $profilePatch = [regex]::Replace($profilePatch, '(?m)^[ \t]*# aurora-nebula skin[^\r\n]*\r?\n?', '')
    $profilePatch = [regex]::Replace(
      $profilePatch,
      '(?m)^- insert:[ \t]*\r?\n[ \t]+- id: ui-skin-aurora-nebula[^\r\n]*\r?\n[ \t]+name: ''@linxin666/dsh-client-ui-skin-aurora-nebula''[^\r\n]*\r?\n?',
      ''
    )
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($profilePatchPath, $profilePatch, $utf8NoBom)
  }
  # Remove the whole home managed section, leaving a valid patch file.
  $newHome = ($before.Trim() + "`n" + $after.Trim()).Trim()
  if ($newHome -eq '') { $newHome = '[]' }
  Write-PatchFile -content $newHome
  Write-Host 'aurora-nebula skin uninstalled from the patch layers. Next run:'
  Write-Host '  dsh plugin --profile web remove @linxin666/dsh-client-ui-skin-aurora-nebula'
  exit 0
}

$inside = $inside.Trim()
$changed = $false

if ($Action -eq 'on') {
  $newInside = Remove-SkinRow -InsideText $inside
  if ($newInside -ne $inside) { $changed = $true }
  $inside = $newInside
} elseif ($Action -eq 'off') {
  if (-not (Has-SkinRow -InsideText $inside)) {
    $inside = if ($inside -eq '') {
      "- id: $skinId`n  disabled: true"
    } else {
      "$inside`n- id: $skinId`n  disabled: true"
    }
    $changed = $true
  }
}

if ($Action -ne 'status') {
  $core = $before.TrimEnd()
  $suffix = $after.TrimStart()
  # A patch file with only comments is not a valid top-level YAML array; when
  # enabling leaves no loader rows, keep an explicit empty array so DSH can
  # still parse the file.
  if ($core -eq '' -and $inside -eq '' -and $suffix -eq '') {
    $core = '[]'
  }
  # Conversely, once there are real block-sequence rows, a leftover `[]`
  # flow sequence makes the document invalid.
  if ($core.Trim() -eq '[]' -and ($inside -ne '' -or $suffix -ne '')) {
    $core = ''
  }
  $newText = $core
  if ($newText -ne '') { $newText += "`n" }
  $newText += "`n$managedStart`n$inside`n$managedEnd"
  if ($suffix -ne '') { $newText += "`n$suffix" }
  Write-PatchFile -content $newText
}

$enabled = -not (Has-SkinRow -InsideText $inside)
if ($Action -eq 'status') {
  if ($enabled) {
    Write-Host 'aurora-nebula skin: ON (official default is switched off)'
  } else {
    Write-Host 'aurora-nebula skin: OFF (official DSH UI is active)'
  }
} elseif ($Action -eq 'on') {
  Write-Host "aurora-nebula skin enabled. Refresh the DSH web page; the config watcher should apply it within seconds."
} elseif ($Action -eq 'off') {
  Write-Host "aurora-nebula skin disabled. The official DSH UI is restored after refresh."
}
