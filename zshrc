# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="zemm-blinks"

# Aliases
alias tetra='cd ~/willsp_maven/Core/Websites/Tetra/trunk'
alias webapp='cd ~/willsp_maven/Core/Websites/Tetra/trunk/modules/websites-webapp/src/main/webapp'
alias wsm='cd ~/willsp_maven/Core/Websites/Tetra/trunk/modules/wsm-webapp/src/main/webapp'
alias widgets='cd ~/willsp_maven/Core/Websites/Tetra/trunk/modules/widget-webapp/src/main/webapp/CBLT_widgets'
alias csscompile='ant -f ~/willsp_maven/Core/Websites/Tetra/trunk/build/websitesEar.xml css.compile'
alias cssclean='ant -f ~/willsp_maven/Core/Websites/Tetra/trunk/build/websitesEar.xml css.clean'
alias mvnsi='mvn mavenus:frameworkextractor -DenableMavenus'
alias mvnst=runJSTest

runJSTest() {
    if [ ! -d "target/jswhip/venus" ]
    then
        mvn mavenus:frameworkextractor -DenableMavenus
    fi

    mvn mavenus:jswhip -Dtdd -DenableMavenus -Dtest=$1 -DfailIfNoTests=false
}

# SQL Aliases
alias sqldev='sqlplus falcon_user/falcon_user@dbe01.dev-5.cobaltgroup.com/FCD5'

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode mercurial screen)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/Users/willsp/bin:/Users/willsp/usefulgits/v8/out/native:/Users/willsp/platform-tools:/Users/willsp/apps/instantclient_11_2

unsetopt correct
