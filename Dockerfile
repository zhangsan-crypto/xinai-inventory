FROM maven:3.9-eclipse-temurin-8 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests -B

FROM tomcat:9.0-jre8
WORKDIR /usr/local/tomcat
COPY --from=build /app/target/xinai-inventory.war webapps/ROOT.war
RUN rm -rf webapps/ROOT
EXPOSE 8080
CMD ["catalina.sh", "run"]