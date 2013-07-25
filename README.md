vimconfig
=========

##Installation

**Requirements**

* vim 7.3 (older versions don't support undofiles)
* git : to clone this repository
* hg (mercurial) : for the vim-addon-manager to retrieve some of the vim plugins
* curl or wget: to fetch the installation script.
* If you compiled vim manually, it should be configured with at least the following options:
  * --enable-pythoninterp (for the powerline to work)
  * --with-features=big (for multibyte/utf-8 support)

**Make sure you have moved your current .vim folder and .vimrc to a backup folder!**

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
