# WORK IN PROGRESS USE AT YOUR OWN RISK
# THIS IS NOT READY FOR CONSUMPTION
# I'LL MAKE SURE TO UPDATE THIS WHEN IT CHANGES

# The documentation is mostly for me now, so I don't forget :-)



# Install code repos

Code repositories go in:

    mkdir -p ~/atomique/code/

So to install it as a user you do: 

    git clone "https://github.com/blackjack75/atomique_shell" ~/atomique/code/atomique_shell 

or (for me) as committer with proper ~/.ssh/config:

    git clone git@github.com-atomique-shell:blackjack75/atomique_shell.git ~/atomique/code/atomique_shell
 
    git clone git@github.com-servers:blackjack75/servers_santiago.git ~/atomique/data

Add the bin folder to your PATH in .zshrc or .bashrc 
so you can type *aa* for the main menu 
or *aassh* for the SSH connect menu

    export PATH=~/atomique/code/atomique_shell/bin:$PATH

Add this line to your tmux.conf file
so that control-B +A opens list of atomique main menu ssh servers 
and     control-B +H opens list of atomtique ssh servers 

    bind-key h new-window -n "atomique-ssh-selector" "$SHELL --login -i -c 'aassh'" 
    bind-key a new-window -n "atomique--menu" "$SHELL --login -i -c 'aa'"


Install cron model to update this repo hourly
(makes sense only for DEV on several machines on different architectures)
Same script can be used to update data repo 

    cd ~/atomique/code/atomique_shell
    ./install_cron.sh
    

# Setting up data folders

Data such as servers must be in ~/atomique/data : 
I have one separate repository for all my data that I just sync there. I need to share an example repository later when this is ready for prime time.

    mkdir -p ~/atomique/data/servers/

Multiple files can be put in this folder:

    ~/atomique/data/servers/my_servers.txt
    ~/atomique/data/servers/my_computers.txt

Format is simply one server per line (name, host, port, keywords all separated by a pipe)

    MacAir    | user@192.168.0.22    | 22 | Macintosh Laptop M1
    MacPro    | user@192.168.0.33    | 22 | Macintosh Trashcan Desktop Intel HomeServer
    MacStudio | user@192.168.0.44    | 22 | Macintosh Desktop M1 Studio Dev
    G4 Cube   | olduser@192.168.0.55 | 22 | Macintosh Leopard PowerPC
    Lema.org  | someuser@lema.org    | 22 | Debian Linux Website
