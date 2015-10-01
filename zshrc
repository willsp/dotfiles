
# Aliases
# Websites
tcs() {
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
alias tetra='cd $TETRA_HOME'
alias webapp='cd $TETRA_HOME/modules/websites-webapp/src/main/webapp'
alias wsm='cd $TETRA_HOME/modules/wsm-webapp/src/main/webapp'
alias widgets='cd $TETRA_HOME/modules/widget-webapp/src/main/webapp/CBLT_widgets'
alias css='mvn -Pcss.compile validate'
alias cssclean='mvn -Pcss.clean validate'
alias mvnsi='mvn mavenus:frameworkextractor -DenableMavenus'
alias mvnst=runJSTest
alias c=chrome-cli
alias p4pen='p4 changes -u willsp -c willsp_sea-willsp-mac_cblt -s pending'
alias p4sub='p4 changes -u willsp -c willsp_sea-willsp-mac_cblt -s submitted'
alias dockenv=eval "$(docker-machine env dev)"
alias vim=nvim

#Scripts
m() {
    mkdir -p $1
    cd $1
}

acceptance() {
    local current=`pwd`
    tetra
    cd acceptance
    mvn test -Dtest.env=qa-1 -Dtest.browser=FF -Dtest.threadcount=60 -Dtest.include="**/$1.java" -Dnitraside=active
    cd "$current"
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

# Use modern completion system
autoload -Uz compinit
compinit

unsetopt correct

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Prompt
function precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))


    ###
    # Truncate the path if it's too long.
    
    PR_FILLBAR=""
    PR_PWDLEN=""
    
    local promptsize=${#${(%):---(%n@%m:%l)---()--}}
    local pwdsize=${#${(%):-%~}}
    
    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
	    ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
	PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
    fi


    ###
    # Get APM info.

    if which ibam > /dev/null; then
	PR_APM_RESULT=`ibam --percentbattery`
    elif which lapm > /dev/null; then
	PR_APM_RESULT=`apm`
    fi
}


setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
	local CMD=${1[(wr)^(*=*|sudo|-*)]}
	echo -n "\ek$CMD\e\\"
    fi
}


setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst


    ###
    # See if we can use colors.

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"


    ###
    # See if we can use extended characters to look nicer.
    
    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}

    
    ###
    # Decide if we need to set titlebar text.
    
    case $TERM in
	xterm*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	screen)
	    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
	    ;;
	*)
	    PR_TITLEBAR=''
	    ;;
    esac
    
    
    ###
    # Decide whether to set a screen title
    if [[ "$TERM" == "screen" ]]; then
	PR_STITLE=$'%{\ekzsh\e\\%}'
    else
	PR_STITLE=''
    fi
    
    
    ###
    # APM detection
    
    if which ibam > /dev/null; then
	PR_APM='$PR_RED${${PR_APM_RESULT[(f)1]}[(w)-2]}%%(${${PR_APM_RESULT[(f)3]}[(w)-1]})$PR_LIGHT_BLUE:'
    elif which apm > /dev/null; then
	PR_APM='$PR_RED${PR_APM_RESULT[(w)5,(w)6]/\% /%%}$PR_LIGHT_BLUE:'
    else
	PR_APM=''
    fi
    
    
    ###
    # Finally, the prompt.

    PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_CYAN$PR_SHIFT_IN$PR_ULCORNER$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
$PR_GREEN%(!.%SROOT%s.%n)$PR_GREEN@%m:%l\
$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_HBAR${(e)PR_FILLBAR}$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
$PR_MAGENTA%$PR_PWDLEN<...<%~%<<\
$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_URCORNER$PR_SHIFT_OUT\

$PR_CYAN$PR_SHIFT_IN$PR_LLCORNER$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
%(?..$PR_LIGHT_RED%?$PR_BLUE:)\
${(e)PR_APM}$PR_YELLOW%D{%H:%M}\
$PR_LIGHT_BLUE:%(!.$PR_RED.$PR_WHITE)%#$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_NO_COLOUR '

    RPROMPT=' $PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_BLUE$PR_HBAR$PR_SHIFT_OUT\
($PR_YELLOW%D{%a,%b%d}$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_LRCORNER$PR_SHIFT_OUT$PR_NO_COLOUR'

    PS2='$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_BLUE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$PR_LIGHT_GREEN%_$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR '
}

setprompt
