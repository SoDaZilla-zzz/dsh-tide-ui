@echo off
rem Switch the aurora-nebula DSH skin on/off.
rem Usage: switch-aurora-skin.cmd on | off | status
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\switch-skin.ps1" %*
