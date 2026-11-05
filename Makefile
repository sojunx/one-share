.PHONY: build run

build:
	@./gradlew bootJar --no-daemon

run: build
	@java -jar build/libs/*.jar
