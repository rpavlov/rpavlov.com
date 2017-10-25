---
title: Multi-user git
date: 2017-10-24
published: true
---

Modify your ~/.ssh/config file as such to seamlessly utilize multiple git users on the same machine

    Host user1
      Hostname github.com
      User git
      IdentityFile ~/.ssh/username1_pubkey
      IdentitiesOnly yes

    Host user2
      Hostname github.com
      User git
      IdentityFile ~/.ssh/username2_pubkey
      IdentitiesOnly yes

Then for your repo ensure ```git remote -v``` is of the form

    git@user1:<username1>/<username1-repo>.git

Of course, ensure your ssh key is added to the respective repo.
