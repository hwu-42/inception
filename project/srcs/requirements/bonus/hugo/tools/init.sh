#!/bin/bash

# Create new Hugo site if it doesn't exist
if [ ! -d "/var/www/hugo/site" ]; then
   hugo new site site
   cd site || exit
   mkdir -p static/images
   rm -rf content/containers/_index.md
   rm -rf content/security/_index.md
   rm -rf content/posts/_index.md
   mkdir -p content/{containers/{nginx,wordpress,mariadb},security/{fail2ban,ssl,docker,wordpress}}
   touch content/_index.md


   ls -R content/
chmod -R 755 content/
mkdir -p archetypes
   cat > archetypes/default.md <<EOL
---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: false
weight: {{ .Site.RegularPages | len }}
---
EOL

cd /var/www/hugo/site
pwd
git init && git submodule add https://github.com/adityatelange/hugo-PaperMod.git themes/paper && git submodule update --init --recursive


cat > hugo.toml <<EOL
# Hugo configuration file
# General settings
baseURL = 'https://hugo.${DOMAIN_NAME}'
languageCode = "en-us"
title = "My website"
theme = "paper"

# Metadata
author = "huidong"
description = "This is where you can find my public info."
copyright = "2025, huidong"

# Enable or disable specific features
disableKinds = ["taxonomy", "taxonomyTerm"]

# Permalinks settings
[permalinks]
    post = "/:year/:month/:day/:slug/"

# Taxonomies
[taxonomies]
    tag = "tags"
    category = "categories"

# Hugo server settings
[server]
    port = 1313
    baseURL = "http://localhost:1313/"

# Outputs (default is HTML)
[outputFormats]
    [outputFormats.HTML]
    mediaType = "text/html"
    isPlainText = false

# Menu settings
[[menu.main]]
    identifier = "home"
    name = "Home"
    url = "/"
    weight = 1

EOL


cat > content/_index.md <<EOL
# 吴会栋
# Huidong Wu
### age:    in my golden age ;)
### gender: MALE!!!
### belief: Life should be interesting, work either, if what you can offer is boring, leave me alone, pleeeeeeaze!
## [42 profile](https://profile.intra.42.fr/users/hwu)
## [github page](https://github.com/hwu-42)

![](https://cdn.intra.42.fr/users/e997caa75bf44b5ec119e768a1d28060/hwu.JPG)
EOL

else
   cd site || exit
fi

hugo server --logLevel="error" >> /var/www/hugo/logs.txt 2>&1 \
    --bind=0.0.0.0 \
    --port=1313 \
    --baseURL="https://hugo.${DOMAIN_NAME}" \
    --appendPort=false \
    --disableFastRender \
    --ignoreCache \
    --verbose \
    --gc


# For production:
# DOMAIN_NAME="example.com"

# # Clean up old files and generate a fresh build
# hugo --gc --minify --baseURL="https://hugo.${DOMAIN_NAME}"

# # Ensure Nginx serves the latest files (modify the path if needed)
# sudo systemctl reload nginx