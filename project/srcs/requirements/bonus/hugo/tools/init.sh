#!/bin/bash

# Create new Hugo site if it doesn't exist
if [ ! -d "/var/www/hugo/site" ]; then
   hugo new site site
   cd site || exit
   # git init
   # git config --global --add safe.directory /var/www/hugo/site

   # git submodule add https://github.com/nanxiaobei/hugo-paper.git themes/paper
   # git submodule init
   # git submodule update --init --recursive
   # git submodule update --remote --merge

   # if [ ! -d "themes/paper" ]; then
   #     echo "Error: Theme installation failed"
   #     exit 1
   # fi

   mkdir -p static/images

   rm -rf content/containers/_index.md
   rm -rf content/security/_index.md
   rm -rf content/posts/_index.md
   mkdir -p content/{containers/{nginx,wordpress,mariadb},security/{fail2ban,ssl,docker,wordpress}}
   touch content/_index.md

      # Update the Quick Navigation section


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
baseURL = 'https://hugo.${DOMAIN_NAME}'
languageCode = 'en-us'
title = 'Inception'
theme = 'paper'

[params]
  # Theme appearance
  color = 'gray'
  avatar = '/images/42logo.png'
  name = 'Inception Project Documentation'
  bio = 'Docker Infrastructure Setup with Security Measures'
  
  # Theme behavior
  defaultTheme = "dark"
  monoDarkIcon = true
  showDate = true
  showFullContent = true
  mainSections = ["containers", "security"]
  showBreadcrumbs = true
  
  # Social links
  github = 'hwu-42'

# 吴会栋
# Huidong Wu
### age:    in my golden age ;)
### gender: MALE!!!
### belief: Life should be interesting, work either, if what you can offer is boring, leave me alone, pleeeeeeaze!
## [42 profile](https://profile.intra.42.fr/users/hwu)
## [github page](https://github.com/hwu-42)

![](https://cdn.intra.42.fr/users/e997caa75bf44b5ec119e768a1d28060/hwu.JPG)

# [menu]
#   [[menu.main]]
#     name = "Home"
#     url = "/"
#     weight = 1
#   [[menu.main]]
#     name = "Containers"
#     url = "/containers/"
#     weight = 2
#   [[menu.main]]
#     name = "Security"
#     url = "/security/"
#     weight = 3

[markup.goldmark.renderer]
  unsafe = true

[outputs]
  home = ["HTML", "RSS"]
  section = ["HTML", "RSS", "JSON"]
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