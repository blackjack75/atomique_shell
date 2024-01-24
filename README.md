# WORK IN PROGRESS USE AT YOUR OWN RISK
# NO NOT USE NOW

Servers must be in: 
    ~/atomique/data/servers/

Multiple .txt files are allowed. See example folders.
My data folder is a separate git repo. I may share and example repo.

Code could be anywhere but I use (and actually test):
    ~/atomique/code/

So to install it as a user you do: 
    git clone "https://github.com/blackjack75/atomique_shell" ~/atomique/code/atomique_shell 

for me committer with proper ~/.ssh/config:
    git clone git@github.com-atomique-shell:blackjack75/atomique_shell.git ~/atomique/code/atomique_shell 

### Add the bin folder to your PATH in .zshrc or .bashrc
    ~/atomique/code/atomique_shell/bin

### Add this line to your tmux.conf file
### so that control-B +H opens list of ssh servers
    bind-key h new-window -n "ssh-selector" "$SHELL --login -i -c 'sshc'"
