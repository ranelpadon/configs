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

In the `settings.vim`, you could see these boolean variables:
```
g:is_nvim
g:is_vim
g:is_mvim
```
which are used in loading specific/targeted settings only inside an `IF` block. Likewise, if you use Neovim only, the settings are fine and no need to delete the custom ones for Vim/MacVim.

The unification of settings here is just secondary, the main important idea is how these folders/files are organized for better separation of concerns and to avoid the chaotic nature of having a single/lengthy `.vimrc` or `init.vim` file.

### STRUCTURE
- `init.vim`: autoloads all settings/files below. Will not require changes most of the time.
- `settings.vim`: native Vim, MacVim, and Neovim settings.
- `plugins.vim`: the list of installed plugins. New plugins should be added here.
    - This assumes the [vim-plug](https://github.com/junegunn/vim-plug) plugin manager which is lightweight.
    - Most of my installed plugins are really ligthweight.
- `mappings.vim`: keymaps for native Vim, MacVim, and Neovim settings.
- `plugins-config/*`: configs/keymaps for a new plugin should be added here as a new file.
    - Some plugins will not require custom config/keymaps.
    - Some plugins like `coc` require extra file, that is, the `coc-settings.json` config file in the root folder.
- `themes/*`: color schemes
- `after`: for special plugin's overrides.


### COMMON WORKFLOW
- Adding new plugin `XXX`:
    - add an entry for it in `plugins.vim`
    - if needed, add a new `plugins-config/XXX.vim` file for its custom config/keymaps 
- Removing a plugin `XXX`:
    - remove its entry in `plugins.vim`
    - remove its custom config/keymaps (`plugins-config/XXX.vim`) if there's any