NAME= inception


# Makefile to set the correct pasv_address in vsftpd.conf and run docker-compose

# Define the path to the vsftpd.conf file inside the container
VSFTPD_CONF_PATH=vsftpd.conf

# Get the host machine IP (use the method you want for getting the IP)
HOST_IP := $(shell hostname -I | awk '{print $$1}')

# Update the vsftpd.conf file with the correct host IP
update_vsftpd_conf:
	if grep -q "^pasv_address=" $(VSFTPD_CONF_PATH); then \
		sed -i "s/^pasv_address=.*/pasv_address=$(HOST_IP)/" $(VSFTPD_CONF_PATH); \
	else \
		echo "pasv_address=$(HOST_IP)" >> $(VSFTPD_CONF_PATH); \
	fi

all: update_vsftpd_conf
