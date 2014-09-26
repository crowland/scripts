#!/bin/sh

PROJECT_NAME=$1
PACKAGING=$2

echo "Creating maven project $PROJECT_NAME"

mkdir ${PROJECT_NAME}
cd ${PROJECT_NAME}

mkdir -p src/main/java
mkdir -p src/main/resources
mkdir -p src/main/webapp/WEB-INF
mkdir -p src/main/webapp/META-INF
mkdir -p src/test/java
mkdir -p src/test/resources

touch src/main/webapp/WEB-INF/web.xml

WEB_XML_TEMPLATE=$(cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<web-app
  xmlns="http://java.sun.com/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
  version="3.0">

  <display-name>${PROJECT_NAME}</display-name>

</web-app>
EOF
)

echo -e "${WEB_XML_TEMPLATE}" >> src/main/webapp/web.xml

touch pom.xml

POM_TEMPLATE=$(cat <<EOF
<project
 xmlns="http://maven.apache.org/POM/4.0.0"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

  <modelVersion>4.0.0</modelVersion>

  <groupId>${PROJECT_NAME}</groupId>
  <artifactId>${PROJECT_NAME}</artifactId>
  <version>0.1.0-SNAPSHOT</version>
  <packaging>${PACKAGING}</packaging>

  <name>${PROJECT_NAME}</name>
  <url>http://maven.apache.org</url>

  <build>
    <sourceDirectory>src/main/java</sourceDirectory>
    <testSourceDirectory>src/test/java</testSourceDirectory>
    <resources>
      <resource>
        <directory>src/main/resources</directory>
        <excludes>
          <exclude>**/*.java</exclude>
          <exclude>**/*.class</exclude>
        </excludes>
      </resource>
      <resource>
        <directory>src/main/java</directory>
        <excludes>
           <exclude>**/*.java</exclude>
            <exclude>**/*.class</exclude>
        </excludes>
      </resource>
    </resources>
    <testResources>
      <testResource>
      <directory>src/test/java</directory>
      <excludes>
        <exclude>**/*.java</exclude>
        <exclude>**/*.class</exclude>
      </excludes>
      </testResource>
      <testResource>
        <directory>src/test/resources</directory>
        <excludes>
          <exclude>**/*.java</exclude>
           <exclude>**/*.class</exclude>
        </excludes>
      </testResource>
    </testResources>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-war-plugin</artifactId>
        <configuration>
          <warSourceDirectory>src/main/webapp</warSourceDirectory>
          <packagingExcludes></packagingExcludes>
          <webResources>
            <webResource>
              <directory>src/main/webapp/WEB-INF</directory>
              <targetPath>WEB-INF</targetPath>
              <filtering>true</filtering>
            </webResource>
            <webResource>
              <directory>src/main/webapp/META-INF</directory>
              <targetPath>META-INF</targetPath>
              <filtering>true</filtering>
            </webResource>
		  </webResources>
        </configuration>
      </plugin>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-surefire-plugin</artifactId>
        <configuration>
          <includes>
          </includes>
          <excludes>
          </excludes>
          <testFailureIgnore>false</testFailureIgnore>
           <argLine>-XX:MaxPermSize=512m -Xmx1024m</argLine>
         </configuration>
       </plugin>
     </plugins>
  </build>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.7</version>
      <scope>test</scope>
    </dependency>
 </dependencies>
</project>
EOF
)

echo -e "${POM_TEMPLATE}" >> pom.xml