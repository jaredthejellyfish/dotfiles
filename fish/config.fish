if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    eval "$(/opt/homebrew/bin/brew shellenv)"
    nvm use 18.17.1
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

# pnpm
set -gx PNPM_HOME "/Users/gerardhernandez/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

/opt/homebrew/bin/zoxide init fish | source