SPARK_LATEST="3.2.1"
JAVA_VERSION="1.8.0"

# setting envs
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export PATH="/usr/local/opt/openjdk@8/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v "$JAVA_VERSION")
export SPARK_HOME="/usr/local/Cellar/apache-spark/$SPARK_LATEST/libexec"