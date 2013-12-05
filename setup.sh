echo "This will clobber your dotfiles"

rm -f ~/.bashrc
ln -s ~/repos/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc


rm -f ~/.gitconfig
ln -s ~/repos/dotfiles/.gitconfig ~/.gitconfig

rm -f ~/.inputrc
ln -s ~/repos/dotfiles/.inputrc ~/.inputrc
#How do I reload inputrc?