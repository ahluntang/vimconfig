if [ -d ~/.vim ]
then
  echo "The .vim folder is present in your home folder. You'll need to remove (backup!!!) ~/.vim if you want to install"
  exit
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


echo "Cloning vimconfig..."
hash git >/dev/null && /usr/bin/env git clone git@github.com:ahluntang/vimconfig.git ${DIR}/vimconfig || {
  echo "git not installed"
  exit
}


echo "Checking for mercurial..."
if which hg >/dev/null; then
	echo "Mercurial installed..."
else
	echo "\Mercurial not found, vim addon manager will nog be able to retrieve plugins using hg..."
fi

echo "Looking for an existing vimrc config..."
if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]
then
  echo "Found ~/.vimrc. Backing up to ~/.vimrc.original";
  mv ~/.vimrc ~/.vimrc.original;
fi

echo "Creating .vimrc and .vim in homefolder..."
ln -s ${DIR}/vimconfig/vim ~/.vim
ln -s ${DIR}/vimconfig/vimrc ~/.vimrc


echo "Done, execute vi/vim to retrieve the vim plugins..."
echo "Make sure you have Mercurial/hg installed for this"

