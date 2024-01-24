# WORK IN PROGRESS USE AT YOUR OWN RISK

Servers must be in: 
    ~/atomique/data/servers/

Multiple .txt files are allowed. See example folders.

Code could be anywhere but I use (and actually test):
    ~/atomique/code/

So to install it you do: 
    git clone "https://github.com/blackjack75/atomique_shell" ~/atomique/code/atomique_shell 

### Add aliases to .zshrc or .bashrc
    alias sshc='~/atomique_shell/ssh_connect.sh "$@"'
    alias sshcopyid='~/atomique_shell/ssh_copy_my_id_to_server.sh"$@"'


### Add this line to your tmux.conf file
### so that control-B +H opens list of ssh servers
    bind-key h new-window -n "ssh-selector" "$SHELL --login -i -c 'sshc'"
