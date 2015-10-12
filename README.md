## dotfiles

My current dotfiles.

###### Base16 Colors
Need base16-{Shell,Vim,XFCE4 Terminal} from [here](https://github.com/chriskempson/base16).

I made a base16-ocean lightline theme, stored in `.tmux/`. Use :
`ln -s ~/.tmux/base16_ocean.vim ~/.vim/bundle/lightline.vim/autoload/lightline/colorscheme/`
to symlink it.

###### Autoformatter
For the autoformatter to work, the system needs to have the following:
* astyle - `# sudo pacman -S astyle`
* js-beautify - `# sudo npm install -g js-beautify`

###### XFCE4 Terminal color palatte
```
ColorCursor=#d3d0c8
ColorForeground=#d3d0c8
ColorBackground=#2d2d2d
ColorPalette=#2d2d2d;#f2777a;#99cc99;#ffcc66;#6699cc;#cc99cc;#66cccc;#d3d0c8;#747369;#f2777a;#99cc99;#ffcc66;#6699cc;#cc99cc;#66cccc;#f2f0ec
```

For the rest of the plugin usage, check out the .vimrc. I'm slowly moving away from
Sublime Text 3 to using Vim exclusively everywhere, so it is a work in progress.
