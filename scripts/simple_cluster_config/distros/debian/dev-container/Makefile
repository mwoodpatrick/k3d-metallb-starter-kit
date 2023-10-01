# [Learn Makefiles With the tastiest examples](https://makefiletutorial.com/)
NAME := westie-debian

build:
	docker buildx build --load -t ${NAME}:latest --label mylabel=xxx .

run:
	docker run --label myc=uuu --name ${NAME} ${NAME}:latest sleep infinity &

exec:
	docker exec -it -u node ${NAME} bash

image_inspect:
	docker image inspect ${NAME}

container_inspect:
	docker container inspect ${NAME}

container_stop:
	docker container stop ${NAME}

container_delete: container_stop
	docker container rm ${NAME}
