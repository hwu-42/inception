all: build up

build:
	docker-compose -f srcs/docker-compose.yml build --no-cache

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker-compose -f srcs/docker-compose.yml rm -f

fclean: clean
	rm -rf data/ secrets/

re: fclean all
