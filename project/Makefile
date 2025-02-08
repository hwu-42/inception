NAME= inception


# Makefile to set the correct pasv_address in vsftpd.conf and run docker-compose

# Define the path to the vsftpd.conf file inside the container
VSFTPD_CONF_PATH=srcs/requirements/bonus/ftp/conf/vsftpd.conf
ENV_PATH=srcs/.env

# Get the host machine IP (use the method you want for getting the IP)
HOST_IP := $(shell hostname -I | awk '{print $$1}')

#all: update_vsftpd_conf prepare $(NAME)
all: update_host_IP

# Update the vsftpd.conf file with the correct host IP
update_host_IP:
	@if grep -q "^pasv_address=" $(VSFTPD_CONF_PATH); then \
		sed -i "s/^pasv_address=.*/pasv_address=$(HOST_IP)/" $(VSFTPD_CONF_PATH); \
	else \
		echo "\npasv_address=$(HOST_IP)" >> $(VSFTPD_CONF_PATH); \
	fi
	@if grep -q "^DOMAIN_IP=" $(ENV_PATH); then \
		sed -i "s/^DOMAIN_IP=.*/DOMAIN_IP=$(HOST_IP)/" $(ENV_PATH); \
	else \
		echo "\nDOMAIN_IP=$(HOST_IP)" >> $(ENV_PATH); \
	fi



prepare:
	mkdir -p /home/hwu/data/wordpress
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
	@sudo rm -rf /home/hwu/data
	@docker network prune -f

rebuild:
	@docker-compose -f srcs/docker-compose.yml down --remove-orphans
	@docker network prune -f
	@docker-compose -f srcs/docker-compose.yml up --build -d

re: fclean all

.PHONY: all clean fclean re prepare rebuild