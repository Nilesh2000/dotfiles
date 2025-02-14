You are an expert software engineer. You wish to setup dotfiles.
You want the following tracked on your dotfiles
- brew - taps, apps and casks
- git - configurations
- vim - configurations
- vscode - settings, keybindings, extensions
- iterm - all my iterm configs
- zsh - zsh configurations
- fonts - install fonts you wish

you use topical organization.
you use gnu stow.
you should one single install.sh that must setup everything from start to end for you.
the script must be idempotent by nature.
if I change anything on my local computer, that should automatically reflext on my dotfiles, so i can push them to remote easily.
script should be verbose and emit lots of logs. the user must be at all times informed of what is going on.


start with the basics
ask for a sudo password at the beginning if required. do not ask it ever again then
install xcode-select --install
sudo xcodebuild -license accept
then proceed with installing brew and setting up other stuff
provide a step by step detailed guide
add a readme.md
keep the installation and the rest of the code as simple as possible
follow best practices
