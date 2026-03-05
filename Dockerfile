FROM eclipse-temurin:21-jre
WORKDIR /app
RUN apt-get update && apt-get install -y wget && wget -O app.war https://github.com/steve-community/steve/releases/latest/download/steve-3.11.0/steve-3.11.0.war
ENV TZ=Australia/Perth
EXPOSE 8180
CMD ["java", "-XX:MaxRAMPercentage=85", "-Dserver.port=${PORT:-8180}", "-jar", "app.war"]
