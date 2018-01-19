# THIS DOCKER FILE WAS DEVELOPED BY ASSISTANZ NETWORKS

# SPECIFY THE CONTAINER IMAGE
FROM microsoft/windowsservercore

MAINTAINER "Avinash Dimmeta"


# COPY THE APACHE INSTALLATION FILES INTO THE CONTAINER
ADD ./setup c:/source

RUN powershell.exe -command \

# INSTALLING JAVA JRE
./source/jre.cmd; \

# INSTALLING JAVA JDK
./source/jdk.cmd; \

# COPYING CUSTOMIZE TOMCAT FILES TO C drive
Copy-Item c:/source/tomcat -Destination c:/tomcat -Recurse; \

# SETTING UP ENVIRONMENT PATH VARIABLES FOR JRE & JDK FOLDERS
./source/Environmentvariable.ps1; \

# Installing Tomcat service
cmd.exe /c c:/source/tomcatservice.bat; \

# SET TOMCAT SERVICE TO RUN UNDER LOCAL SYSTEM ACCOUNT
sc.exe config tomcat9 obj=LocalSystem start=auto; \

# REMOVE TOMCAT SETUP FILES FROM SOURCE DIRECTORY
#cmd.exe /c rd /S /Q c:\source


cmd.exe /c dir %CATALINA_HOME%; \
cmd.exe /c rd /S /Q %CATALINA_HOME%\webapps\ROOT; \
#COPY target/calculator-1.0.war %CATALINA_HOME%\webapps\ROOT.war
#Copy-Item ./target/calculator-1.0.war $CATALINA_HOME/webapps/ROOT.war
cmd.exe /c copy %WORKSPACE%\target\calculator-1.0.war %CATALINA_HOME%\webapps\ROOT.war
