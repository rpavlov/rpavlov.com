---
title: Github pages domain takeover
date: 2019-02-09
published: true
---

Recently my partner's website was defaced, in that it was serving new, different content at the old url. It is a simple static site hosted
on github, which made the severity of this exploit initially puzzling. How could this happen? The site accepts no input and the DNS settings looked normal.

Luckily, this was one of those easily searchable and already known issues with Github pages. The short of it is, if you don't have a CNAME file at the root of your project and someone else beats you to it, they can claim your custom domain and Github will happily serve their index.html instead! Other providers often require you to have a TXT record in your DNS records, but GH does not require proof of owernship in order to set a custom domain in the repository settings. The final take-away is you can't trust even the big players to make sound technical decisions.

Here's a great, detailed [breakdown.](https://medium.com/@jehy/hijacking-domain-using-github-pages-41c80ac57523)