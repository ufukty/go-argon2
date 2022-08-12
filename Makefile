docker-build:
	docker build -t go-argon2 .

docker-hub-push:
	docker tag local-image:go-argon2 go-argon2:alpine-libargon2-v20190702
	docker push go-argon2:alpine-libargon2-v20190702