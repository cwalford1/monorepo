cp ~/.bashrc ~/.bashrc_old_$(date -i)
cp ~/.inputrc ~/.intpurc_old_$(date -i)

ln -s $(pwd)/bashrc $HOME/.bashrc
ln -s $(pwd)/inputrc $HOME/.inputrc

mkdir -p $HOME/.config/tmux/
cp ($pwd)/tmux/tmux.conf $HOME/.config/tmux/
