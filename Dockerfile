# Etapa 1: construir el JAR
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: imagen liviana para correr la app
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Nombre del JAR generado (ajustá si el nombre real es distinto)
ARG JAR_FILE=target/libreria-0.0.1-SNAPSHOT.jar

# Copiar JAR desde etapa de build
COPY --from=build /app/${JAR_FILE} app.jar

EXPOSE 8080

# Arrancar la app
ENTRYPOINT ["java","-jar","/app/app.jar"]