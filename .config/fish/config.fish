if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
source ~/.asdf/asdf.fish

set -x PATH $PATH /Applications/WezTerm.app/Contents/MacOS