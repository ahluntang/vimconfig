vimconfig
=========

##Installation

**Requirements**

* vim 7.3 (older versions don't support undofiles)
* git : to clone this repository
* hg (mercurial) : for the vim-addon-manager to retrieve some of the vim plugins
* curl or wget: to fetch the installation script.
* If you compiled vim manually, it should be configured with at least the following options *
  * --enable-pythoninterp (for the powerline to work)
  * --with-features=big (for multibyte/utf-8 support)


**Make sure you have backed up your current .vim folder and .vimrc config file!**

### Install using curl:

```bash
curl -LsS https://raw.github.com/ahluntang/vimconfig/master/install.sh | bash
```

### Install using wget

```bash
wget --no-check-certificate https://raw.github.com/ahluntang/vimconfig/master/install.sh -O - | bash
```

Now run vi/vim to install the vim-addon-manager and to retrieve the plugins using the vim-addon-manager.
This requires hg for some plugins.

### Fonts

This config uses Powerline to enhance the statuslines in vim. For some symbols to work, you can use one of the patched fonts on https://github.com/Lokaltog/powerline-fonts and change the font in the .vimrc file.
By default, it uses [PragmataPro](http://www.fsd.it/fonts/pragmatapro.htm) by Fabrizio Schiavi.

## Credits

### Vim Addon manager
See: https://github.com/MarcWeber/vim-addon-manager

To manage retrieve additional plugins for vim (Powerline, AutoComplPop, L9)

### Powerline 

See: https://github.com/Lokaltog/powerline

**Mode-dependent highlighting**

![icon normal](https://raw.github.com/Lokaltog/powerline/develop/docs/source/_static/img/pl-mode-normal.png)
![icon insert](https://raw.github.com/Lokaltog/powerline/develop/docs/source/_static/img/pl-mode-insert.png)
![icon visual](https://raw.github.com/Lokaltog/powerline/develop/docs/source/_static/img/pl-mode-visual.png)
![icon replace](https://raw.github.com/Lokaltog/powerline/develop/docs/source/_static/img/pl-mode-replace.png)

### Other
Some other plugins it retrieves:

* AutoComplPop
* L9 (dependency for AutoComplPop)


## * Regarding manually compiled vim

I have used this configuration/installer successfully on vim compiled on windows (cygwin) and centos with the following options:
```bash
./configure --disable-selinux --enable-rubyinterp --enable-pythoninterp --with-features=big
```
For windows users that don't want cygwin, this also works with [Cream](http://cream.sourceforge.net/)
