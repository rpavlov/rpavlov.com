---
title: Live over Tor
date: 2021-02-13
published: true
tags: tor
---
One of the things I've been meaning to do for a while is gain a better understanding of the onion protocol and how hidden services are hosted. I got about 50% through the Tor [whitepaper](https://www.freehaven.net/anonbib/cache/tor-design.pdf) before deciding to pivot to some practical applications, so this blog is now mirrored at [http://xzjjcvowtdunfx4z6dkeund7sjvt3k7nphgcfdusy64smyqpmdusmpad.onion/](http://xzjjcvowtdunfx4z6dkeund7sjvt3k7nphgcfdusy64smyqpmdusmpad.onion/)

## The steps

This blog is currently hosted on my 3rd gen Raspberry Pi and served by nginx, so we'll setup tor there as well.

Installing Tor requires either building from source, or adding some 3rd party APT repositories. I used the repos because building will take a while. There are some gotchas, however, since Raspbian differs from Debian in a few ways. More detailed info [here.](https://2019.www.torproject.org/docs/debian.html.en)

In short, it's sufficient to add the following to your `/etc/apt/sources.list`. The `[arch=amd64]` is important else your `apt get update` will fail. Also pay attention to your raspbian version. Is it jessie, stretch or buster? Double check with `cat /etc/os-release`.

```shell
deb [arch=amd64] https://deb.torproject.org/torproject.org buster main
deb-src [arch=amd64] https://deb.torproject.org/torproject.org buster main
```

Add the package signing GPG keys.

```shell
curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
```

Hope this works.

```shell
apt update && apt upgrade
apt install tor deb.torproject.org-keyring
```

Next, ensure the hidden service dir  `/var/lib/tor/hidden_service` exists and has the correct permissions.

```shell
sudo chown -R debian-tor /var/lib/tor/hidden_service
sudo chmod 700 /var/lib/tor/hidden_service
```

Edit `/etc/tor/torrc` to reflect the setup

```shell
HiddenServiceDir /var/lib/tor/hidden_service
HiddenServicePort 80 127.0.0.1:8080
```

Finally, add a vhost to nginx. Your web root may vary so double check that.

```nginx
server {
    listen 127.0.0.1:8080;
    root /var/www/html;
    client_max_body_size 32M;
    charset utf-8;
    index index.html;
}
```

Now, do a `service tor restart && service nginx reload` and you should now find a `hostname` and `private_key` file in `/var/lib/tor/hidden_service`. Your hostname is your onion url so go ahead and test that. If something went wrong, which is highly likely, tail your `/var/log/syslog`, `/var/log/nginx/access.log` and `/var/log/nginx/error.log` for hints. Apparently Tor is supposed to generate logs in `/var/log/tor` but mine is empty.

## Ah, one more thing

Setting up a middle/guard relay is pretty trivial, and a great way to help out the community. Add a few lines to `/etc/tor/torrc`, restart,  and we're good to go.

```
ORPort 9001
ExitRelay 0
SocksPort 0
ControlSocket 0
ContactInfo roumen@rpavlov.com
Nickname CiaSurveillanceVan
```

## Bonus pro-tip

Now would be a good time to run a backup of the Pi's SD card, to save our hours of toil. I have an additional usb drive attached and mounted so I will drop it there. Note that your SD card might have a different name, so check with `lsblk`.

`dd bs=4M if=/dev/mmcblk0 of=/media/pi-space/sd-card-backup-2021-02.img`

Namaste.