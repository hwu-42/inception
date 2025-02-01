NAME= inception

all: prepare $(NAME)

prepare:
	@mkdir -p /home/hwu/data/wordpress
	@mkdir -p /home/hwu/data/mariadb
	@mkdir -p /home/hwu/data/hugo
	@sudo chmod 777 /home/hwu/data/hugo
	@sudo chmod 777 /home/hwu/data/wordpress
	@sudo chmod 777 /home/hwu/data/mariadb
	@sudo chown -R hwu:hwu /home/hwu/data/wordpress
	@sudo chown -R hwu:hwu /home/hwu/data/mariadb
	@sudo chown -R hwu:hwu /home/hwu/data/hugo
	@sudo sed -i '/hwu.42.fr/d' /etc/hosts
	@sudo echo "127.0.0.1 hwu.42.fr" >> /etc/hosts
	@sudo echo "127.0.0.1 hugo.hwu.42.fr" >> /etc/hosts

$(NAME):
	@docker-compose -f srcs/docker-compose.yml up --build -d

clean:
	@docker-compose -f srcs/docker-compose.yml down --remove-orphans
	@docker network prune -f

fclean: clean
	@docker system prune -af
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@sudo rm -rf /home/hwu/data/wordpress/*
	@sudo rm -rf /home/hwu/data/mariadb/*
	@sudo rm -rf /home/hwu/data/hugo/*
	@docker network prune -f

rebuild:
	@docker-compose -f srcs/docker-compose.yml down --remove-orphans
	@docker network prune -f
	@docker-compose -f srcs/docker-compose.yml up --build -d

re: fclean all

.PHONY: all clean fclean re prepare rebuild