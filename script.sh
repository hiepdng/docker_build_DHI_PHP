#!/bin/bash
# Guides:
# 
#-----------------------------------------------------------------

# Define your Docker ID and Token as variables
DHI_USER="your-docker-username"
DHI_TOKEN="your-personal-access-token"
DHI_IMAGE="dhi.io/php:8.5.8-debian13-dev" # Replace with your required image and tag

# Authenticate to the DHI registry
echo "$DHI_TOKEN" | docker login dhi.io -u "$DHI_USER" --password-stdin

# Pull the image
docker pull "$DHI_IMAGE"

# Get files from the image
docker create --name my_container "$DHI_IMAGE"
docker cp my_container:/usr/local/etc/php/ .
docker rm temp_container
docker rmi "$DHI_IMAGE"


# Modify the php.ini
sed -i \
    -e "s/(max_execution_time.*)/;\1\nmax_execution_time = 60/" \
    -e "s/(max_input_time.*)/;\1\nmax_input_time = 60/" \
    -e "s/(max_input_vars.*)/;\1\nmax_input_vars = 3000/" \
    -e "s/(memory_limit.*)/;\1\nmemory_limit = 256M/" \
    -e "s/(post_max_size.*)/;\1\npost_max_size = 64M/" \
    -e "s/(upload_max_filesize.*)/;\1\nupload_max_filesize = 64M/" \
    -e "s/(display_errors.*)/;\1\ndisplay_errors = Off/" \
    -e "s/(display_startup_errors.*)/;\1\ndisplay_startup_errors = Off/" \
    -e "s/(log_errors.*)/;\1\nlog_errorlog_errors = On/" \
    -e "s/(error_reporting.*)/;\1\nerror_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/" \
    -e "s/(expose_php.*)/;\1\nexpose_php = Off/" \
    -e "s/(session.use_only_cookies.*)/;\1\nsession.use_only_cookies = 1/" \
    -e "s/(session.cookie_httponly.*)/;\1\nsession.cookie_httponly = 1/" \
    -e "s/(session.cookie_secure.*)/;\1\nsession.cookie_secure = 1/" \
    -e "s/(session.use_strict_mode.*)/;\1\nsession.use_strict_mode = 1/" \
    -e "s/(session.cookie_samesite.*)/;\1\nsession.cookie_samesite = "Lax"/" \
    -e "s/(allow_url_fopen.*)/;\1\nallow_url_fopen = Off/" \
    -e "s/(allow_url_include)/;\1\nallow_url_include = Off/" \
    -e "s/(disable_functions.*)/;\1\ndisable_functions = exec,shell_exec,passthru,system,popen,proc_open/" \
    -e "s/(opcache.enable.*)/;\1\nopcache.enable = 1/" \
    -e "s/(opcache.enable_cli.*)/;\1\nopcache.enable_cli = 1/" \
    -e "s/(opcache.memory_consumption.*)/;\1\nopcache.memory_consumption = 128/" \
    -e "s/(opcache.interned_strings_buffer.*)/;\1\nopcache.interned_strings_buffer = 8/" \
    -e "s/(opcache.max_accelerated_files.*)/;\1\nopcache.max_accelerated_files = 10000/" \
    -e "s/(opcache.validate_timestamps.*)/;\1\nopcache.validate_timestamps = 0/" \
    php.ini




# Create mount directory on the host system
mkdir -p /home/app/apache2/htdocs
sudo chown -R 65532:65532 /home/app/apache2/
