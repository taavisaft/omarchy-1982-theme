# 1982

A green-phosphor [Omarchy](https://omarchy.org/) theme — the IBM 5151
monochrome display: green on black, and nothing else.

![1982](preview.png)

Everything is MDA green except the code buffer in Neovim and Helix, which uses
the CGA 16-color palette so syntax highlighting still carries information.

## Install

```bash
omarchy theme install https://github.com/taavisaft/omarchy-1982-theme.git
~/.config/omarchy/themes/1982/setup
```

Then reopen your terminal windows — foot reads its config only at startup and
has no reload signal, so a font change reaches a window only when that window
is reopened. `omarchy restart terminal` covers alacritty, kitty and ghostty,
not foot.

## What `setup` does

Omarchy stages only the files a repo-installed theme is allowed to contribute —
no `.lua`, no font family, and nothing at all for apps it does not template.
The script is the rest of the install:

- Installs `ttf-terminus-nerd` and sets **Terminess Nerd Font Mono** as the
  system monospace font, at 16px in foot and in GTK apps.
- Copies the CGA colorscheme into `~/.config/nvim`.
- Installs the Midnight Commander skin and selects it.
- Installs the Zed overrides, or writes `settings.json.1982` beside your own.
- Appends the CRT look — rounding, phosphor glow, window opacity — to
  `~/.config/hypr/looknfeel.lua`.

Re-run it any time: every step checks the current state first and says what it
did, and anything it edits in place is backed up next to itself. It is plain
bash, so read it if you would rather do the steps by hand.

## Notes

**The font has to be a Nerd Font.** Omarchy resolves the bar's icons through
the same `monospace` alias as its text, so an unpatched retro face turns every
one of them into a tofu box. The family cannot ship inside the theme either —
`omarchy font set` writes a system-wide fontconfig alias — so only the size
does, in `shell.font.toml`. 16px is Terminess's native 8x16 cell, which renders
pixel-perfect rather than interpolated.

If you want something heavier and closer to the ROM, `ttf-bigblueterminal-nerd`
gives you **BigBlueTerm437 Nerd Font Mono**, IBM's code page 437 face on an
8x16 cell with 2px stems.

**Helix** needs nothing — `helix.toml` ships with the theme.

**Zed** is MDA all the way down, buffer included; Neovim and Helix are where the
CGA exception lives. If you already have Zed settings, merge the
`theme_overrides` block out of `settings.json.1982` by hand.

**mcedit's syntax highlighting stays monochrome.** mc maps syntax categories
onto the terminal's ANSI palette, which this theme paints green.

## Backgrounds

- `1-phosphor.png` — scanlines and a phosphor pool
- `2-post.png` — a power-on self-test

Both generated, 4K.

## License

[MIT](LICENSE)
