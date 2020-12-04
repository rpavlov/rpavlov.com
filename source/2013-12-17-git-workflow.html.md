---
title: Git workflow
date: 2013-12-17
tags: github, programming
published: true
---

There are several pretty popular Git workflows floating around. Chances are you're probably using something similar for your projects or at work. Here they are, just in case.

[A simple git branching model](https://gist.github.com/jbenet/ee6c9ac48068889b0912)

	# everything is happy and up-to-date in master
	git checkout master
	git pull origin master

	# let's branch to make changes
	git checkout -b my-new-feature

	# go ahead, make changes now.
	$EDITOR file

	# commit your (incremental, atomic) changes
	git add -p
	git commit -m "my changes"

	# keep abreast of other changes, to your feature branch or master.
	# rebasing keeps our code working, merging easy, and history clean.
	git fetch origin
	git rebase origin/my-new-feature
	git rebase origin/master

	# optional: push your branch for discussion (pull-request)
	#           you might do this many times as you develop.
	git push origin my-new-feature

	# optional: feel free to rebase within your feature branch at will.
	#           ok to rebase after pushing if your team can handle it!
	git rebase -i origin/master

	# merge when done developing.
	# --no-ff preserves feature history and easy full-feature reverts
	# merge commits should not include changes; rebasing reconciles issues
	# github takes care of this in a Pull-Request merge
	git checkout master
	git pull origin master
	git merge --no-ff my-new-feature


	# optional: tag important things, such as releases
	git tag 1.0.0-RC1

[The Atlassian Git Tutorial](https://www.atlassian.com/git/tutorial) is also a great repository of knowledge. Check out their workflows.