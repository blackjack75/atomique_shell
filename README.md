# WORK IN PROGRESS USE AT YOUR OWN RISK
# NO NOT USE NOW



Data such as servers must be in ~/atomique/data : 

    mkdir -p ~/atomique/data/servers/
    ~/atomique/data/servers/myservers.txt

You can add other .txt files in the same folder.


Code repositories go in:

    mkdir -p ~/atomique/code/

So to install it as a user you do: 

    git clone "https://github.com/blackjack75/atomique_shell" ~/atomique/code/atomique_shell 

or (for me) as committer with proper ~/.ssh/config:

    git clone git@github.com-atomique-shell:blackjack75/atomique_shell.git ~/atomique/code/atomique_shell 

### Add the bin folder to your PATH in .zshrc or .bashrc
    ~/atomique/code/atomique_shell/bin

### Add this line to your tmux.conf file
### so that control-B +H opens list of ssh servers
    bind-key h new-window -n "ssh-selector" "$SHELL --login -i -c 'sshc'"
