# DOCKER, JENKINS AND ECS – JAVA APPLICATION

Run vs CMD.
RUN: Executes commands in a new layer, creating a new image. Commonly used for installing software packages. 
CMD: Sets a default command or parameters that can be overridden when launching a Docker container.


## IRL Java application setup with external application.config file.

1.	Import AWS compiler and MVN. 
2.	Install the application of server. 
### Stage-1
3.	Setup working directory /app.
4.	CP pom.xml.
5.	Install jar.
6.	CP all file.
7.	MVN clean package.
### Stage-2
8.	Set working directory as /var/app.
9.	CP jar file from stage 1.
10.	CP production config in./config (Spring boot picks from here)
11.	EXPOSE port
12.	CP startup.sh file and give chmod a+x startup.sh.
13.	CMD startup.sh file.
FROM maven:3.8.3-amazoncorretto-17 AS compiler
RUN yum install -y git

```
WORKDIR /app

COPY pom.xml /app/pom.xml

RUN mvn -Dmaven.test.skip=true clean install

COPY . /app

WORKDIR /app

RUN mvn --batch-mode -Dmaven.test.skip=true clean package

FROM amazoncorretto:17 as auth

WORKDIR /var/app

COPY --from=compiler /app/target/demo-0.0.1-SNAPSHOT.jar .

COPY /deployment/application-prod.properties ./config/application-prod.properties

EXPOSE 8080

COPY startup.sh .
RUN chmod a+x startup.sh

CMD ["./startup.sh"]
```

