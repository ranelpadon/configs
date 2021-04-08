### ABOUT

This is my unified Vim, Neovim, and MacVim settings. Entry point is `init.vim` and located in
`~/.config/nvim/init.vim`, which is being called in `~/.vimrc` as

```shell
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source $HOME/.config/nvim/init.vim
```

MacVim loads the `.vimrc` file also. And I've created a `~/.vim` folder that just points to `~/.config/nvim` folder, that's why we have `runtimepath^=~/.vim` in `.vimrc` above.
So, all files/settings in Vim, MacVim, and Neovim are shared for better maintainability.

In the `general/settings.vim`, you could see these boolean variables:
```
g:is_nvim
g:is_vim
g:is_mvim
```
which are used in loading specific/targeted settings only inside an `IF` block. Likewise, if you use Neovim only, the settings are fine and no need to delete the custom ones for Vim/MacVim.

### STRUCTURE
- `init.vim`: autoloads all settings/files below. Will not require changes most of the time.
- `general/settings.vim`: native Vim, MacVim, and Neovim settings.
- `keys/mappings.vim`: keymaps for native Vim, MacVim, and Neovim settings.
- `themes/*`: color schemes
- `vim-plug/plugins.vim`: the list of installed plugins. New plugins should be added here.
    - This assumes the [vim-plug](https://github.com/junegunn/vim-plug) plugin manager which is lightweight.
    - Most of my installed plugins are really ligthweight.
- `plug-config/*`: configs/keymaps for a new plugin should be added here as a new file.
    - Not all plugin will require custom config/keymaps.
    - Some plugins like `coc` require extra file, that is, the `coc-settings.json` config file in the root folder.
- `after`: for special plugins' overrides.


### COMMON WORKFLOW
- Adding new plugin `XXX`:
    - add an entry for it in `vim-plug/plugins.vim`
    - if needed, add a new `plug-config/XXX.vim` file for its custom config/keymaps 
- Removing a plugin `XXX`:
    - remove its entry in `vim-plug/plugins.vim`
    - remove its custom config/keymaps (`plug-config/XXX.vim`) if there's any