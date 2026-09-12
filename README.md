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
| Neovim / Helix buffer — the code itself | CGA | 16 colors, light-green body text |
| Zed buffer | MDA | green on black, roles spaced on the L\* ladder |

## Palette

A monochrome tube has no hue to spend, so every ANSI slot is one green at a
different luminance — things stay distinguishable by brightness, the way they
did on a real P39 phosphor. `red` is the *brightest* green rather than the
dimmest, because Omarchy spends it on alerts, and on a monochrome tube an alert
reads as phosphor bloom.

The rungs are spaced in L\* rather than by eye. Two greens less than about
3 L\* apart read as the same green, so the ten working rungs sit 4.0–4.8
apart and every ANSI slot clears 4.5:1 on black — `blue`, which is what `ls`
paints every directory with, used to sit at 3.36:1. `bright_X` is half a step
above `X`, because the bright bit on real hardware was an intensity bit rather
than a thirteenth colour.

The four slots above `green` — `red`, `bright_green`, `bright_red` and
`bright_foreground` — are the exception, spaced 1.7–2.6 and so confusable with
each other. `green` is `foreground`, which on a green tube is right rather than
merely convenient, and that pins it near the top of the range. All four are
"loudest thing on screen" tokens used in contexts that don't overlap, so the
collision costs nothing.

Foreground-to-background contrast is 15.5:1.

## Install

```bash
omarchy theme install https://github.com/taavisaft/omarchy-1982-theme.git
```

### Editors

Helix needs nothing — `helix.toml` ships with the theme and is applied for you.
It carries the same CGA role map as the two below.

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

Zed is the exception to the exception: it is MDA all the way down. The chrome —
tabs, panels, status bar, borders, icons — is green, and so is the buffer, where
syntax roles sit on the same L\* ladder as everything else and are told apart by
brightness rather than hue. Neovim and Helix keep the CGA map, so if you want a
coloured buffer, use one of those.

Zed has no Omarchy template — `default/themed/` ships one for Helix, Neovim and
VS Code but not for Zed — so this is a manual copy no matter what, and it works
by overriding One Dark through `theme_overrides` rather than by registering a
theme of its own.

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

### Font

The theme is drawn for **BigBlueTerm437 Nerd Font Mono** — IBM's code page 437
ROM font, the one the 5151 actually displayed, patched with Nerd Font glyphs so
the bar's icons survive.

```bash
sudo pacman -S ttf-bigblueterminal-nerd
omarchy font set "BigBlueTerm437 Nerd Font Mono"
```

The family cannot ship inside the theme. Omarchy resolves the shell's font
through the fontconfig `monospace` alias `omarchy font set` writes and keeps
that system-wide deliberately, so a theme can pin sizes but never a family.
`shell.font.toml` ships the size — 16px, which is BigBlueTerm437's native 8x16
cell, so it renders pixel-perfect rather than interpolated. 32px is the other
exact size if you want the same crispness larger.

For everything to actually match, the size has to be set in pixels rather than
points. A terminal usually asks for points, and foot is DPI-aware, so `size=11`
in `foot.ini` lands wherever your display's DPI puts it — about 16px at 104 DPI
— and will not line up with a bar measured in pixels. Ask for pixels instead:

```ini
font=BigBlueTerm437 Nerd Font Mono:pixelsize=16
```

GTK applications take neither from the theme nor from `omarchy font set`:

```bash
gsettings set org.gnome.desktop.interface monospace-font-name "BigBlueTerm437 Nerd Font Mono 16px"
```

Setting `font-name` as well puts button and dialog labels on the same font —
consistent, though further than most people want to go.

foot reads its configuration only at startup — it has no reload signal, and its
`SIGUSR1`/`SIGUSR2` switch colour themes rather than reload — so a font change
reaches a window only when that window is reopened. `omarchy restart terminal`
covers alacritty, kitty and ghostty, not foot.

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

A font family, either. `omarchy font set` writes a fontconfig alias that is
deliberately system-wide, which is why the font above is an install step rather
than a file in this repo; only its size ships, in `shell.font.toml`.

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
