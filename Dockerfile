FROM maven:3.9-eclipse-temurin-21 AS builder
WORKDIR /code
COPY . .
ARG DB_HOST
ARG DB_PASSWORD
RUN mvn -B -DskipTests -Ddb.ip=${DB_HOST} -Ddb.port=3306 -Ddb.schema=railway -Ddb.user=root -Ddb.password=${DB_PASSWORD} clean package -Pproduction
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=builder /code/target/*.war app.war
ENV TZ=Australia/Perth
EXPOSE 8180
CMD ["java", "-XX:MaxRAMPercentage=85", "-jar", "app.war"]
