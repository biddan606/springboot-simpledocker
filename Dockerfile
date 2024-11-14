FROM gradle:jdk21-alpine AS builder
WORKDIR /build

COPY . .

RUN gradle bootJar --no-daemon

# 실행 스테이지
FROM bellsoft/liberica-runtime-container:jre-21-slim-musl
WORKDIR /app

# 빌드 스테이지에서 생성된 jar 파일만 복사
COPY --from=builder /build/build/libs/*-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]


