# DSH Tide Liquid-Glass Skin · 潮汐

> A polished aurora-tide liquid-glass UI skin for the **DeepSeek Harness (DSH)** web client.
> Floating workspace, deep-sea caustics, animated SVG waves, and a draggable Q-version **DeepSeek whale-girl** companion that opens a glass tuning panel.

DSH 潮汐液态玻璃皮肤 —— 为 **DeepSeek Harness (DSH)** 桌面 / Web 客户端打造：极光星云 + 海浪潮汐背景、悬浮工作窗口、可拖动 Q 版鲸鱼娘挂件，点击她即弹出液态玻璃调节面板。

---

## ✨ Screenshots · 效果展示

### ☀️ Light Theme · 浅色主题
![light](./preview/light.png)

### 🌙 Dark Theme · 深色主题
![dark](./preview/dark.png)

---

## 🌊 Features · 特性

| | EN | 中文 |
|---|---|---|
| 🌌 **Aurora-tide backdrop** | Rolling aurora nebula, deep-sea caustics, animated SVG waves with foam, drifting bubbles, sparks, sprays, meteors, and a slow-rotating conic gradient band. | 极光星云与海浪潮汐交织，深海焦散、SVG 波浪带泡沫、漂浮气泡、闪烁星点、海浪飞沫、流星、缓慢旋转的 conic 渐变带。 |
| 🪟 **Liquid-glass everywhere** | Every panel (chat, sidebar, settings dialog, message bubbles, input card) is glass-tinted with tunable alpha / blur / brightness / saturate / highlight. | 全面板液态玻璃化（对话 / 侧栏 / 设置弹窗 / 消息气泡 / 输入卡），透明度 / 模糊 / 亮度 / 饱和 / 反光均可调。 |
| 🪂 **Floating workspace** | The left sidebar is a draggable, collapsible 56 px rail that floats above the page; position is remembered across sessions. | 左侧工作区变成可拖动、可折叠（56 px rail）的悬浮窗口，位置跨会话记忆。 |
| 🐳 **Whale-girl companion** | A Q-version DeepSeek whale-girl sits in the corner — drag her anywhere, click her to open the glass tuning panel. | 右下角陪伴一只 Q 版 DeepSeek 鲸鱼娘，可拖动到任意位置，点击展开玻璃调节面板。 |
| 🎛️ **Per-region tuning** | Tune glass parameters **globally** or per region (sidebar / settings / main); each region falls back to global when unset. | **全局**与**各区域**（悬浮窗 / 设置页 / 主界面）独立调节；未设置时自动跟随全局。 |
| 🌓 **Light & dark** | Light uses **#cbddeb** glass, dark uses **#000000** glass; theme follows DSH's appearance setting (light / dark / system). | 浅色默认 **#cbddeb** 玻璃，深色默认 **#000000** 玻璃，跟随 DSH 主题（浅 / 深 / 跟随系统）。 |
| 💾 **Persistent state** | Drag position, collapse state, glass parameters all persist in `localStorage`; theme override also persists to `settings.yaml`. | 拖动位置、收起状态、玻璃参数全部跨会话记忆；主题偏好同时持久化到 `settings.yaml`。 |
| ♻️ **Clean uninstall** | Unloading the skin fully restores the official UI — no leftover overlays, hooks, or DOM. | 卸载后完整还原官方界面，无残留遮罩、监听或 DOM。 |
| ⚡ **GPU-friendly** | Heavy `filter: blur` removed from animated layers; `will-change` and `prefers-reduced-motion` honored; large areas use static gradients over live blur. | 已移除动画层的高成本 `filter: blur`；尊重 `will-change` 与 `prefers-reduced-motion`；大面积使用静态渐变代替实时模糊。 |
| 🌐 **i18n ready** | README, `README.zh.md`, and `README.i18n.yaml` cover English and Chinese out of the box. | 自带英文 README、中文 README (`README.zh.md`)、`README.i18n.yaml` i18n 元数据。 |

---

## 📦 Installation · 安装

### Via `dsh` CLI (recommended) · 通过 dsh CLI（推荐）

```bash
# Clone the repo
git clone https://github.com/SoDaZilla-zzz/dsh-tide-ui.git
cd dsh-tide-ui

# Install into the default web profile
dsh plugin --profile web add .

# Activate (select "潮汐" in the dsh home manager)
# Windows:
switch-tide-skin.cmd
# Or just pick the skin inside the dsh home manager UI.
```

### From npm (if published) · 从 npm（如果已发布）

```bash
dsh plugin --profile web add dsh-tide-ui
```

### Manual install · 手动安装

1. Copy the `dsh-tide-ui/` folder into `~/.dsh/profiles/web/node_modules/dsh-tide-ui/`
2. Run `dsh plugin --profile web add dsh-tide-ui`
3. Open DSH Web → home manager → pick **潮汐 / Tide**

---

## 🎮 Usage · 使用

### 1. Drag the workspace · 拖动工作窗口
- **Grab handle**: the small `◐` knob on the **right edge** of the floating sidebar (outside the panel, so it never overlaps the DeepSeek logo).
- **抓握把手**：悬浮窗 **右侧外侧**的小旋钮（放在框外，永远不和 DeepSeek 标志重合）。

### 2. Collapse / expand · 收起 / 展开
- Click the **original DSH collapse toggle** (the icon inside the sidebar) to shrink the panel into a 56 px rail.
- Use the same toggle to expand again.
- 点击侧栏里 **DSH 自带的折叠按钮** 即可收起为 56 px rail，再次点击展开。

### 3. Tune the glass · 调节液态玻璃
- **Click the whale-girl** in the bottom-right corner → glass panel slides out beside her.
- 4 tabs: **全局** (global), **悬浮窗** (sidebar), **设置页** (settings), **主界面** (main).
- 5 sliders per tab: **透明度 · 模糊 · 亮度 · 饱和 · 反光**.
- Settings persist in `localStorage` and apply live to all glass surfaces.
- **点击右下角鲸鱼娘** → 玻璃调节面板弹出在她旁边。4 个 tab（全局 / 悬浮窗 / 设置页 / 主界面），每 tab 5 个滑块（透明度 / 模糊 / 亮度 / 饱和 / 反光）。设置实时生效并自动持久化。

### 4. Drag the whale · 拖动鲸鱼娘
- Press and hold on the whale-girl, drag her anywhere on screen. Release to remember the position.
- 按住鲸鱼娘拖到任意位置，松手即记忆。

### 5. Switch theme · 切换主题
- Theme is driven by the **official DSH appearance picker** (light / dark / system).
- The skin automatically refreshes glass color and animated background when you switch.
- 主题跟随 **DSH 官方外观选择**（浅 / 深 / 跟随系统）。切换时皮肤自动刷新玻璃色和背景图。

---

## 🛠️ Tuning reference · 调节参数对照

| Param | Default (light) | Default (dark) | Effect |
|---|---|---|---|
| `alpha` (透明度) | 0.85 | 0.85 | Glass opacity |
| `blur` (模糊) | 18 px | 20 px | Backdrop blur radius |
| `brightness` (亮度) | 1.05 | 1.08 | Lifts / dims backdrop |
| `saturate` (饱和) | 160 % | 165 % | Color punch |
| `highlight` (反光) | 0.45 | 0.18 | Inner top-reflection strength |

Glass color follows the theme: **light = #cbddeb** (203, 221, 235), **dark = #000000** (0, 0, 0).

玻璃颜色跟随主题：**浅色 = #cbddeb**（203, 221, 235），**深色 = #000000**（0, 0, 0）。

---

## 🔧 Files · 文件结构

```
dsh-tide-ui/
├── README.md           # English (this file)
├── README.zh.md        # 中文
├── README.i18n.yaml    # i18n metadata for the dsh market
├── package.json        # npm manifest
├── skin.json           # skin metadata (id, bodyAttr, tags, preview paths)
├── cordis.patch.yml    # cordis bundle patch (registers the plugin)
├── switch-tide-skin.cmd  # Windows one-shot skin switcher
├── lib/
│   ├── client.js       # the entire skin runtime (~1.3k lines, self-contained)
│   └── index.js        # host-side no-op entry
├── scripts/
│   └── switch-skin.ps1
└── preview/
    ├── light.png
    └── dark.png
```

---

## 🧪 Compatibility · 兼容性

- **DSH web client** (any recent version that exposes `body[data-ds-dark-theme]` and the `[class*='pI_x6G_*']` / `[class*='VOzbGW_*']` / `[class*='uV2eYG_*']` / `[class*='wSkVaW_*']` / `[class*='hHd-Xa_*']` selectors)
- Chromium / Edge / Brave / any Blink browser with `backdrop-filter` support
- Reduced-motion users get still-but-tinted variants automatically
- GPU usage is tuned to stay low: animated layers use static gradients + transform-only motion, no per-frame `filter: blur` on moving elements

- **DSH Web 客户端**（任意暴露 `body[data-ds-dark-theme]` 与上述 class 的版本）
- Chromium / Edge / Brave / 任何支持 `backdrop-filter` 的 Blink 内核浏览器
- 启用 reduced-motion 的用户自动获得静止但仍带玻璃质感的变体
- GPU 占用经过调优：动画层使用静态渐变 + 纯 transform 运动，不在运动元素上做每帧 `filter: blur`

---

## 🗑️ Uninstall · 卸载

```bash
# Pick another skin in the dsh home manager UI
# or:
dsh plugin --profile web remove dsh-tide-ui
```

All body attributes, class names, and DOM nodes are cleaned up in the runtime's `effect` cleanup hook, so the official UI returns instantly.

卸载后所有 body 属性、class、DOM 节点都通过 runtime 的 `effect` 清理钩子移除，官方 UI 立即恢复。

---

## 📜 License · 许可

MIT — see [LICENSE](./LICENSE).

The bundled whale-girl illustration is a derivative of `MAID_ATELIER_CHIBI` from the open-source `dsh-deep-whale / maid-atelier` art set; redistribution rights follow the original license.

内置鲸鱼娘形象基于开源 `dsh-deep-whale / maid-atelier` 美术集中的 `MAID_ATELIER_CHIBI` 衍生制作，传播权利遵循原作许可。

---

## 🙏 Credits · 致谢

- Built on the [DSH (DeepSeek Harness)](https://github.com/DeepSeekLab/dsh) plugin / cordis framework.
- Q-version whale-girl: `dsh-deep-whale / maid-atelier` (open-source).
- Deep-tide caustics & SVG waves: hand-rolled CSS + SVG.
- Liquid-glass math: classic `backdrop-filter: blur + brightness + saturate`.

---

<p align="center"><sub>· DSH Tide · 潮汐 · v0.1.0 · MIT ·</sub></p>
