if status is-interactive
    load_nvmrc
end

function fish_greeting
    eval "$(/opt/homebrew/bin/brew shellenv)"
    neofetch
end

function next
  set -l command "npx next $argv"
  echo $command
  eval $command
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

/opt/homebrew/bin/zoxide init fish | source

source "$HOME/.cargo/env.fish"
# Created by `pipx` on 2024-07-11 19:15:57
set PATH $PATH /Users/gerardhernandez/.local/bin
fish_add_path /Users/gerardhernandez/.spicetify
