-- Pin LazyVim to the CGA colorscheme so Omarchy's generated green neovim.lua
-- does not follow the desktop theme into the editor.
return {
  { "LazyVim/LazyVim", opts = { colorscheme = "cga1982" } },
}
