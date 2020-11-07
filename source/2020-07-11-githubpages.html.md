---
title: Github pages bug
date: 2020-07-11
published: true
---

Barely a day goes by now where I don't discover a bug in some service, tool or program. Sometimes it's even the default configuration that's wrong. Anyway, this one is a blog post because it's about Github pages where this blog lives.

I noticed the site was 404ing after I made the repository itself private. I reverted that, but still seeing a 404. I hadn't deployed any code changes either. I ruled it out as issue with the custom domain name because https://rpavlov.github.io was also 404.

Of course, others out there have had this same problem on and off since 2012 (According to the top answer on Stackoverflow).  The solution is to delete and re-push your remote `gh-pages` branch. Pretty lame solution. Possible bug on Github's end, according to comments.

```bash
git checkout gh-pages

git push origin --delete gh-pages

git push origin
```

It appears the option to have a private repo with public github pages is graciously on offer as a paid feature by GH.

