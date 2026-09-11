# 1982

A green-phosphor [Omarchy](https://omarchy.org/) theme. The desktop is the IBM
5151 monochrome display: green on black, and nothing else.

Source: [taavisaft/omarchy-1982-theme](https://github.com/taavisaft/omarchy-1982-theme)

## The one exception: code

IBM shipped two display adapters in 1982. The **MDA** was green phosphor, text
only. The **CGA** had sixteen colors. This theme runs both — the desktop, bar,
menus, and terminal are MDA; a text editor is CGA.

That split is deliberate. Monochrome is a pleasure to live in until you are
reading code, at which point losing syntax color costs you real information.
A 1982 machine had an answer for that, so this theme uses it.

| Surface | Adapter | Palette |
|---|---|---|
| Bar, menus, notifications, lock | MDA | green on black |
| Terminal, TUI apps | MDA | green on black |
| Editor chrome (tabs, panels, gutter) | MDA | green on black |
| Editor's built-in terminal | MDA | green on black |
| Editor buffer — the code itself | CGA | 16 colors, light-green body text |

## Palette

A monochrome tube has no hue to spend, so every ANSI slot is one green at a
different luminance — things stay distinguishable by brightness, the way they
did on a real P39 phosphor. `red` is the *brightest* green rather than the
dimmest, because Omarchy spends it on alerts, and on a monochrome tube an alert
reads as phosphor bloom.

Foreground-to-background contrast is 15.5:1.

## Install

```bash
omarchy theme install https://github.com/taavisaft/omarchy-1982-theme.git
```

### Editors

Helix needs nothing — `helix.toml` ships with the theme and is applied for you.

Neovim needs one manual step, and it cannot be automated from inside a theme:
Omarchy drops every `.lua` and `vscode.json` from a theme installed out of a git
repo, so the CGA colorscheme cannot ride along in the theme itself.

**Neovim** (LazyVim):

```bash
cp extras/neovim/colors/cga1982.lua   ~/.config/nvim/colors/
cp extras/neovim/lua/plugins/1982.lua ~/.config/nvim/lua/plugins/
```

Without this, Neovim follows the desktop and goes green — which is a legitimate
way to run the theme if you want the machine to be monochrome all the way down.

**Zed**:

```bash
cp extras/zed/settings.json ~/.config/zed/settings.json   # merge, if you have your own
```

Zed is split the same way the desktop is: the chrome — tabs, panels, status
bar, borders, icons — is MDA green, while everything inside a buffer is CGA and
uses the same role-to-color mapping as the Neovim colorscheme, so the two
editors read alike.

Zed's built-in terminal is a terminal rather than a code buffer, so it is MDA
green too, carrying the exact ANSI palette Omarchy generates into the theme's
`foot.ini` — a shell looks the same whichever window it is in.

**Midnight Commander** is not themed by Omarchy at all, so it needs its skin
installed and selected by hand:

```bash
install -Dm644 mc/1982.ini ~/.local/share/mc/skins/1982.ini
sed -i 's/^skin=.*/skin=1982/' ~/.config/mc/ini   # or set it in Options > Appearance
```

The skin covers panels, dialogs, the viewer, the diff viewer and mcedit's
chrome. Note that mcedit's *syntax* highlighting is not CGA — mc maps syntax
categories onto the terminal's ANSI palette, which this theme paints green, so
mcedit stays monochrome. Neovim is where the CGA exception lives.

## Backgrounds

- `1-phosphor.png` — scanlines and a phosphor pool, for working on
- `2-post.png` — a power-on self-test, for the era

Both are generated, contain no third-party branding, and are 4K.

## What this theme deliberately does not ship

No `hyprland.lua`. Omarchy drops a repo-installed theme's Lua and regenerates
the file from `colors.toml`, so shipping one would mean the published theme
never matched the one its author runs. The border gradient is defined in
`colors.toml` as `hyprland_active_border` / `hyprland_inactive_border`, which
survives installation.

Window geometry — gaps, rounding, border width — is not a theme's business
either. If you want the sharp-cornered look the screenshots show, that belongs
in `~/.config/hypr/looknfeel.lua`:

```lua
hl.config({
  general = { border_size = 2, gaps_in = 4, gaps_out = 10 },
  decoration = {
    -- A tube was blown glass, not a rectangle: the picture met the bezel on a
    -- curve. Slight, so a window still reads as a character cell.
    rounding = 6,
    rounding_power = 3,
    -- Phosphor glow. A CRT bled light into the glass around whatever it drew,
    -- so the focused window carries a green halo and the rest a fainter one.
    shadow = {
      enabled = true,
      range = 18,
      render_power = 3,
      color = "rgba(33ff3338)",
      color_inactive = "rgba(1a8f1a14)",
    },
  },
})
```

The glow cannot ship inside the theme for the same reason `hyprland.lua`
cannot: Hyprland shadows are configured in Lua, and Lua is dropped from a
repo-installed theme.

## License

[MIT](LICENSE)
