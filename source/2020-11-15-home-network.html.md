---
title: The evergreen home networking blog post
date: 2020-11-15
published: true
---
I've reached the point in my life where I find home networking fun. It's either that or a model train set. The catalyst was finally setting up an Open-WRT router, which gives me options. The ability to put the Vodafone KabelBox modem in full bridge mode is mandatory for proper NAT resolution and to access local services from outside. The hosting hub is a raspberry pi with a number of additional services like nginx.

## Open-WRT & KabelBox

Luckily Vodafone are nice enough to provide the option to toggle bridge mode on their router/modem devices. It was deeply buried [here](https://kabel.vodafone.de/meinkabel/einstellungen/interneteinstellungen/bridgemode_tipps#).

However, after enabling it my internet connection died. I noticed the router was being assigned an ip on the WAN interface from the gateway (modem), but I couldn't ping through to any DNS servers.  After investing several hours reading the open-wrt docs and searching online I noticed a tip about restarting the cable modem in order to assign the router a new ip for the WAN interface (one that isn't from the old 192.0.1 pool, but instead something fresh from the ISP, in a completely different subnet). This interface remains running as a DHCP client which is the default. In fact, no additional configuration outside of wifi setup had to be done for the router. Anyway once again the rule of thumb about computers is if in doubt; restart.

## Cloudflare & DNS

On the Cloudfront side, I had to create a couple of records and then use my Global API key (Token didn't work for some reason) in order to run a Crontask which updates the A record whenever the router receives a new public IP from the ISP. We want this router accessible from the internet. Hackers welcome I guess. The CF DNS records consist of an A record initially set to anything, but subsequently updated by the crontask running on open-wrt. An A record of dynamic-> *router-ip * and a CNAME record of rpavlov -> dynamic.rpavlov.com are created. Pinging either one will resolve to CF's server, so my ip is nicely hidden and protected from DDoS. The steps are outlined here https://github.com/dcerisano/cloudflare-dynamic-dns . Finally, add a Page Rule to redirect all traffic to https.

## Raspberry Pi
0. Disable ssh password.
1. We need to reserve a static ip for the pi in the LAN. Easily done through the open-wrt Luci web interface.
2. We need to expose port 80/433 in the router firewall from the WAN interface, and route it to the Pi local ip on the LAN interface. Additionaly we need to remap the port that the router's Web interface server (uHttpd) is running on to something else in order to free up those ports.
3. Issue an SSL cert with Certbot, by authentication through a TXT file in the webroot.
4. Drop the static blog files in /var/www/html.
5. Add my [hardened nginx config](https://github.com/rpavlov/nginx).

## Dropbox replacement

Dropbox can't really be trusted, so I trade reliability and security for decreased paranoia. Instead I use [Syncthing](https://syncthing.net/) which runs on each client device (laptops, PC)  and doesn't require hosting. It works out of the box flawlessly.

## Next up

* [Funkwhale](https://funkwhale.audio/) for streaming my own music files outside of Spotify.
* A Tor relay.
* This blog as a hidden service, which is pretty straightforward actually: Download Tor, modify the `.../tor-browser_en-US/Browser/TorBrowser/Data/Tor/torrc` to point to nginx, then access at the relevant vhost+port.

## Conclusion

Much respect to the legion of clever elves who made all this software magic possible. Throughout the course of writing this post I also realized I'll probably be touching computers until the day I die, which seems like a mixed blessing.