export JAVA_HOME=/Library/Java/JavaVirtualMachines/1.6.0_51-b11-457.jdk/Contents/Home
export P4CLIENT=willsp_maven
export P4PORT=perforce.cobaltgroup.com:1667
export P4USER=willsp
export P4EDITOR=/usr/bin/vim
export EDITOR=/usr/bin/vim
export USERDNSDOMAIN=sea.ds.adp.com
export ANT_OPTS="-Dfile.encoding=UTF-8 -Xmx3072m -XX:MaxPermSize=1024m"
export MAVEN_OPTS="-Dorg.apache.el.parser.SKIP_IDENTIFIER_CHECK=true -Xmx1024m -Xms512m -XX:PermSize=64m -XX:MaxPermSize=512m -Duser.timezone=PST -agentlib:jdwp=transport=dt_socket,server=y,address=9000,suspend=n"

export TETRA_HOME=/Users/willsp/willsp_maven/Core/Websites/Tetra/trunk
export TETRA_CATALINA_BASE=$TETRA_HOME/modules/sandbox-env-tomcat/target/catalina_base
 
alias tcs='ant -f $TETRA_HOME/modules/deploy.xml server.start.tomcat'
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
