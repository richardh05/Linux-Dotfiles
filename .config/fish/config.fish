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
abbr newsboat "newsboat -u ~/Documents/urls"
abbr i3conf "nvim ~/.config/i3/config"
abbr kittyconf "nvim .config/kitty/kitty.conf"
abbr fishconf "nvim .config/fish/config.fish"
set -gx PATH "$HOME/Scripts:$HOME/.local/share/JetBrains/Toolbox/scripts:$HOME/.local/share/dotnet:$PATH"

if test -f ~/.profile
    # This is a hacky way to run Bash commands and get their exports into Fish
    # It's not perfect and won't handle all Bash constructs, but works for simple exports.
    for line in (bash -c 'source ~/.profile; printenv' | grep '=')
        # Split line at the first '='
        set -l key (echo "$line" | cut -d'=' -f1)
        set -l value (echo "$line" | cut -d'=' -f2-)
        # Export the variable in Fish
        set -gx "$key" "$value"
    end
end

#wants to be at the end
zoxide init fish | source
