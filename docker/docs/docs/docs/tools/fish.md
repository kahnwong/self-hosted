---
title: fish
---

## Install
```
$ brew install fish
$ curl -fsSL https://starship.rs/install.sh | bash
```

## Config colors
`fish_config colors`

## Fish config
```bash title="~/.config/fish/config.fish"
#set PATH /usr/local/bin $HOME/bin $HOME/Library/Python/3.8/bin $PATH

### FISH
# default
set fish_user_paths /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
# set PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/kahnwong/.pyenv/versions/cli/bin

# for making escape key work as meta, need to suppress it
set fish_escape_delay_ms 3000

# suppress fish_greeting message
set -g fish_greeting

### THEME
# # PURE
# set fish_function_path /Users/kahnwong/.config/fish/functions/theme-pure/functions/ $fish_function_path
# source /Users/kahnwong/.config/fish/functions/theme-pure/conf.d/pure.fish

# STARSHIP
starship init fish | source

# ### TOOLS
# # Java
# set JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-9.0.4.jdk/Contents/Home

# # GPG
# set GPG_TTY tty

# pyenv
set -g PYENV_ROOT $HOME/.pyenv
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source
set PYENV_VERSION 3.7.9
set pipenv_fish_fancy yes

### alias
## topydo
function t
    topydo $argv
end

function tt
    topydo due:"<=today"
end

function ta
    topydo ls -- -+blog -+media
end

function tr
    ta -due:
end

function tc
    topydo columns
end

function diff
    colordiff $argv
end

function ping
    gping $argv
end
```

## Starship config
```bash title="~/.config/starship.toml"
[aws]
disabled = true
#format = " [$symbol$profile]($style) "
#style = "bold yellow"
#symbol = "🅰 "
#[aws.region_aliases]
#ap-southeast-2 = "au"
#us-east-1 = "va"
#ap-southeast-1 = "sg"

[git_branch]
format = "on [$symbol$branch]($style) "
style = "bold green"

[git_commit]
disabled = true
commit_hash_length = 7
tag_symbol = "🔖 "
style = "underline green"
only_detached = false

[git_status]
disabled = false
style = "blue"
staged = '[++\($count\)](green)'
ahead = "⇡${count}"
diverged = "⇕⇡${ahead_count}⇣${behind_count}"
behind = "⇣${count}"

#[python]
#format = 'via [${symbol}${pyenv_prefix}(${version} )(\($virtualenv\))]($style)'

[gcloud]
disabled = true

[nodejs]
format = "via [🤖 $version](bold green) "
```