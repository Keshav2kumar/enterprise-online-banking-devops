# Stage 1: build
FROM maven:3.8.7-eclipse-temurin-17 as builder
WORKDIR /app
COPY application/pom.xml .
COPY application/src ./src
RUN mvn -B -DskipTests clean package

# Stage 2: runtime
FROM eclipse-temurin:17-jre
COPY --from=builder /app/target/*.jar /opt/app/app.jar
ENV JAVA_OPTS="-Xms512m -Xmx1024m"
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s CMD curl -f http://localhost:8080/health || exit 1
ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar /opt/app/app.jar"] 
