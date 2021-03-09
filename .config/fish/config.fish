if status --is-login
    # colourise man pages
    set -gx LESS_TERMCAP_mb \e'[01;31m' # begin blinking
    set -gx LESS_TERMCAP_md \e'[01;38;5;74m' # begin bold
    set -gx LESS_TERMCAP_me \e'[0m' # end mode
    set -gx LESS_TERMCAP_se \e'[0m' # end standout-mode
    set -gx LESS_TERMCAP_so \e'[38;5;246m' # begin standout-mode - info box
    set -gx LESS_TERMCAP_ue \e'[0m' # end underline
    set -gx LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline
end

if command -v exa >/dev/null
    function ls
        exa -F --git --group-directories-first --time-style long-iso --colour-scale $argv
    end
end

function _maybe_source
    if [ -f $argv ]
        source $argv
    end
end

_maybe_source $HOME/.config/fish/completions/kubernetes-tools.fish
_maybe_source $HOME/.iterm2_shell_integration.fish

functions -e _maybe_source

function iterm2_print_user_vars
    set -l kube_context (kubectl config current-context)
    set -l kube_namespace (kubectl config view --minify --output 'jsonpath={..namespace}')
    set -l git_branch (git branch 2> /dev/null | grep \* | cut -c3-)

    iterm2_set_user_var kube_context "$kube_context"
    iterm2_set_user_var kube_namespace "$kube_namespace"
    iterm2_set_user_var git_branch "$git_branch"
end

if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

