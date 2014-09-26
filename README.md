##scripts
=======

Miscellaneous utility scripts.

###Bash

##mvn-project.sh

...Bash script for creating an empty maven java project.
...Creates the following project directories and files
..*pom.xml
..*src/main/java
..*src/main/resources
..*src/main/webapp/WEB-INF
..*src/main/webapp/META-INF
..*src/main/test/java
..*src/main/test/resources

...Packaging types (war is only supported currently with jar support to be added soon.)

...Usage
..*Add script to a directory in your path (or where you able to execute it)
..*Make sure the script is executable (chmod 755 mvn-project.sh)
..*cd to directory you will to create the project
..*Execute "mvn-project.sh war your-project-name-here"