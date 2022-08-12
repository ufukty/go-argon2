docker-build:
	docker build -t go-argon2 .

docker-hub-push:
	docker tag go-argon2 ufukty/go-argon2:alpine-libargon2-v20190702
	docker push ufukty/go-argon2:alpine-libargon2-v20190702