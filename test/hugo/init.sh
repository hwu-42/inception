cat <<HERE > /src/hugo.toml
URL = 'http://localhost:1313'
languageCode = 'en-us'
title = 'Huidong Wu'
theme = ""  # No theme being used
HERE

# Create the content/_index.md file
cat <<HERE > /src/content/_index.md
---
title: "Huidong Wu"
---

# 吴会栋
# Huidong Wu

### age:    in my golden age ;)
### gender: MALE!!!
### belief: Life should be interesting, work either. If what you can offer is boring, leave me alone, pleeeeeeaze!

## [42 profile](https://profile.intra.42.fr/users/hwu)
## [GitHub Page](https://github.com/hwu-42)

![](https://cdn.intra.42.fr/users/e997caa75bf44b5ec119e768a1d28060/hwu.JPG)

# Thanks to [Dillinger](https://dillinger.io/)
HERE

# Create the layouts/_default/single.html file
cat <<HERE > /src/layouts/_default/single.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{ .Title }}</title>
</head>
<body>
  <main>
    <article>
      {{ .Content }}
    </article>
  </main>
</body>
</html>
HERE
