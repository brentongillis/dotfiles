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

For the rest of the plugin usage, check out the .vimrc. I'm slowly moving away from
Sublime Text 3 to using Vim exclusively everywhere, so it is a work in progress.
