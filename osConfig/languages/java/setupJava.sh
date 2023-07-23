#!/bin/sh -x

#==============================================================================
#                       Setup Java
#==============================================================================
# Script to setup Java on a new developer environment.
# Homebrew should have already installed openjdk, jenv, maven, and gradle.
echo -e "\033[1;32m  ......Starting setupJava.sh......  \033[0m"

#             jenv
#------------------------------------------------------------------------------
# zshrc
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
source ~/.zshrc

jenv enable-plugin export
jenv enable-plugin maven

#             OpenJDK17
#------------------------------------------------------------------------------
# This should print the actual path you need to to add to jenv.
/usr/libexec/java_home -V

sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
jenv add /opt/homebrew/Cellar/openjdk@17/17.0.8/libexec/openjdk.jdk/Contents/Home
jenv doctor
jenv versions
jenv global 17.0.8
java -version

#             Project and Shell-specifc Options
#------------------------------------------------------------------------------
# jenv local 17.0.8
# jenv shell 17.0.8

echo -e "\033[0;31m  ======Finished setupJava.sh======  \033[0m"
