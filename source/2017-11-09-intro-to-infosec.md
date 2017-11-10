---
title: Intro to infosec
date: 2017-11-09
published: true
---

For the past several months I've been pursuing a self-direct education in information security and immersing myself in a wealth of amazing topics. It's an incredibly broad field, and daunting in its complexity but then what isn't. I figured writing about it would solidify some concepts and organize my thoughts.

My time is currently mostly devoted to reading while I collect tools and provision a sandbox. I settled on this amazing
free course from the University of Helsinki for a more structured approach [https://cybersecuritybase.github.io/](https://cybersecuritybase.github.io/)

The way I use, write and reason about code has changed significantly. This [paper](https://www.computer.org/cms/CYBSI/docs/Top-10-Flaws.pdf) categorizes software flaws into two groups

#### Implementation flaws

The classic bug. This could be an error throw due to an invalid reference, missing resource or just faulty logic. The list is extensive.

#### Design flaws

This is where it gets interesting. These flaws are deeper yet
all encompassing and include things like error pages leaking information, offloading auth to the client, poor sandboxing and assumption of trust between services or just plain old misconfiguration and leaving things exposed.

* Design systems assuming they will eventually be compromised, limit trust and live/die by the [principle of least privelege](https://en.wikipedia.org/wiki/Principle_of_least_privilege)

* Don't mix data and control instructions. Allowing untrusted input data to be executed like any other code leads to injection vulnerabilities and control-flow hijacking.
