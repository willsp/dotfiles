source exports.zsh

# Aliases
# Websites
tcs() {
    devshare.sh
    ant -f $TETRA_HOME/modules/deploy.xml server.start.tomcat
}

alias tcx='ant -f $TETRA_HOME/modules/deploy.xml server.stop.tomcat'
alias tct='tail -f $TETRA_CATALINA_BASE/logs/catalina.out  $TETRA_CATALINA_BASE/logs/websites_*.log'
alias tcl='cd $TETRA_CATALINA_BASE/logs'
alias tc='cd $TETRA_CATALINA_BASE'
alias tcw='cd $TETRA_CATALINA_BASE/webapps'
 
alias wls='ant -f $TETRA_HOME/modules/deploy.xml server.start'
alias wlx='ant -f $TETRA_HOME/modules/deploy.xml server.stop'
alias wlt='tail -f $TETRA_HOME/weblogic/logs/stdout.log  $TETRA_HOME/weblogic/logs/websites_*.log'
alias wll='cd $TETRA_HOME/weblogic/logs'
alias wl='cd $TETRA_HOME/weblogic'

#Custom
alias tetra='cd ~/cblt/Core/Websites/Tetra/trunk'
alias webapp='cd ~/cblt/Core/Websites/Tetra/trunk/modules/websites-webapp/src/main/webapp'
alias wsm='cd ~/cblt/Core/Websites/Tetra/trunk/modules/wsm-webapp/src/main/webapp'
alias widgets='cd ~/cblt/Core/Websites/Tetra/trunk/modules/widget-webapp/src/main/webapp/CBLT_widgets'
alias csscompile='ant -f ~/cblt/Core/Websites/Tetra/trunk/build/websitesEar.xml css.compile'
alias cssclean='ant -f ~/cblt/Core/Websites/Tetra/trunk/build/websitesEar.xml css.clean'
alias mvnsi='mvn mavenus:frameworkextractor -DenableMavenus'
alias mvnst=runJSTest
alias c=chrome-cli
alias t='todo.sh -d $HOME/Dropbox/todo/.config'

#Scripts
m() {
    mkdir -p $1
    cd $1
}

runJSTest() {
    if [ ! -d "target/jswhip/venus" ]
    then
        mvn mavenus:frameworkextractor -DenableMavenus
    fi

    if [ -z $1 ]
    then
        mvn mavenus:jswhip -Dtdd -DenableMavenus -DfailIfNoTests=false
    else
        mvn mavenus:jswhip -Dtdd -DenableMavenus -Dtest=$1 -DfailIfNoTests=false
    fi
}

server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    python -m SimpleHTTPServer "$port"
}

function fuck() {
    if killall -9 "$2"; then
        echo ; echo " (╯°□°）╯︵$(echo "$2"|toilet -f term -F rotate)"; echo
    fi
}

# SQL Aliases
alias sqldev='sqlplus falcon_user/falcon_user@dbe01.dev-5.cobaltgroup.com/FCD5'

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Customize to your needs...
export PATH=/usr/local/opt/ruby/bin:/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/Users/willsp/bin:/Users/willsp/usefulgits/v8/out/native:/Users/willsp/platform-tools:/Users/willsp/apps/instantclient_11_2
export GEM_HOME='/usr/local/Cellar/gems/2.0'

unsetopt correct


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

. /Users/willsp/usefulgits/powerline/powerline/bindings/zsh/powerline.zsh
