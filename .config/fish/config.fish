if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
#set -U fish_greeting "🐟"

# == ABBREVIATIONS ==
abbr vi "nvim"
abbr vim "nvim"
abbr la "ls -a"
abbr s "sudo"
abbr p "sudo pacman"
abbr spt "spotify_player"
#abbr stowdots "stow -d ~/dots/home -t ~/ ."
abbr neofetch "fastfetch"
abbr i3conf "nvim ~/.config/i3/config"
abbr kittyconf "nvim .config/kitty/kitty.conf"
abbr fishconf "nvim .config/fish/config.fish"
set -gx PATH "$HOME/Scripts:$HOME/.local/share/Jetbrains/Toolbox/scripts:$HOME/.local/share/dotnet:$PATH"

#wants to be at the end
zoxide init fish | source
