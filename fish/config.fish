if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    eval "$(/opt/homebrew/bin/brew shellenv)"
    eval "$(rbenv init -)"
    export NVM_DIR=~/.nvm
    export PATH="$PATH:/Users/gerardhernandez/code/chromium/depot_tools"
    neofetch
end

function r:s
    rails s
end

function serve
   npm start
end

function next
  set -l command "npx next $argv"
  echo $command
  eval $command
end
