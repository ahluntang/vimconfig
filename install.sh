

if [ -d ~/.vim ]
then
  echo "\033[0;33mThe .vim folder is present in your home folder.\033[0m You'll need to remove (backup!!!) ~/.vim if you want to install"
  exit
fi


echo "\033[0;34mCloning vimconfig...\033[0m"
hash git >/dev/null && /usr/bin/env git clone git@github.com:ahluntang/vimconfig.git vimconfig || {
  echo "git not installed"
  exit
}


echo "\033[0;34mChecking for mercurial...\033[0m"
if which hg >/dev/null; then
	echo "\033[0;34mMercurial installed...\033[0m"
else
	echo "\033[0;34mMercurial not found, vim addon manager will nog be able to retrieve plugins using hg...\033[0m"
fi

echo "\033[0;34mLooking for an existing vimrc config...\033[0m"
if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]
then
  echo "\033[0;33mFound ~/.vimrc.\033[0m \033[0;32mBacking up to ~/.vimrc.original\033[0m";
  mv ~/.vimrc ~/.vimrc.original;
fi

echo "\033[0;34mCreating .vimrc and .vim in homefolder...\033[0m"
ln -s vimconfig/vim ~/.vim
ln -s vimconfig/vimrc ~/.vimrc


echo "\033[0;34mDone, execute vi/vim to retrieve the vim plugins...\033[0m"

