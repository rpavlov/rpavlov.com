---
title: The evergreen home networking project blog post
date: 2020-11-17
published: false
---
I've reached the point in my life where I find home networking fun. It's either that or a model train set. The catalyst was finally setting up an Open-WRT router, which gives me options. The ability to put the Vodafone KabelBox modem in full bridge mode is mandatory for proper NAT resolution and to access local services from outside. The hosting hub is a raspberry pi with a number of additional services.

## open-wrt and KabelBox

Luckily Vodafone are nice enough to provide the option to toggle bridge mode on their router/modem devices. It was deeply buried [here](https://kabel.vodafone.de/meinkabel/einstellungen/interneteinstellungen/bridgemode_tipps#)

However, after enabling it my internet connection died. I noticed the router was being assigned an ip on the WAN interface from the gateway (modem), but I couldn't ping through to any DNS servers.  After investing several hours reading the open-wrt docs and searching online I noticed a tip about restarting the cable modem in order to assign the router a new ip for the WAN interface (one that isn't from the old 192.0.1 pool, but instead something fresh from the ISP, in a completely different subnet). This interface remains running as a DHCP client which is the default. In fact, no additional configuration outside of wifi setup had to be done for the router. Anyway once again the rule of thumb about computers is if in doubt; restart.

## Raspberry Pi
1. We need to reserve static ip for the pi. Easyily done through the open-wrt Luci web interface.
2. We need to expose Funkwhale and the webserver currently running behind ther router to the internet. Luckily open-wrt has a set of plugins for DynDNS. But for this to happen over HTTPS, we need to install the Curl plugin and CA certs: `opkg install ca-certificates`. We also need the `ddns-scripts_cloudflare` plugin because I use Cloudflare (I know, but their consistent domain naming pricing won me over. Adios Namecheap). Still in Luci, the `ddns`  service also needs to be added to startup via System -> Startup -> enable.

On the Cloudfront side, I had go get my global [API Key](https://dash.cloudflare.com/profile/api-tokens).

The Pi is administered through [Ansible](https://www.ansible.com), as are pushes to this blog. It's running nginx which proxies through to
* [Funkwhale](https://funkwhale.audio/) for streaming my own music files
* [this site](____)
* and a Tor relay.

## Dropbox replacement

Dropbox can't really be trusted, so I trade reliability and security for decreased paranoia. Instead I use [Syncthing](https://syncthing.net/) which runs on each client device (laptops, PC)  and doesn't require a server. It works out of the box flawlessly.

## Hidden service deployment

Pretty straightforward.
1. Download Tor, modify the `.../tor-browser_en-US/Browser/TorBrowser/Data/Tor/torrc` to point to nginx, then access at the relevant vhost+port.

Much respect to the legion of clever elves who made all this software magic possible. Throughout the course of writing this post I also realized I'll probably be touching computers until the day I die, which seems like a mixed blessing.