FROM maven:3.8.3-amazoncorretto-17 AS compiler

RUN yum install -y git

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