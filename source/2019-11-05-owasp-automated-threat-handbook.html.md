---
title: Summary - OWASP Automated threat handbook
date: 2019-11-05
published: true
---

Some quick thoughts after reading the [OWASP Automated Threat Handbook](https://www.owasp.org/images/3/33/Automated-threat-handbook.pdf)

These kinds of attacks are carried out by seemingly legitimate but actually malicious users of your application. The crux of it is: spend time thinking about how your application can be probed, scanned, scraped, flooded or most commonly have it's otherwise normal functionality subverted.

The next step is to build in countermeasures. This is where a prioritized checklist would lend itself well to laying out which things to build or plan for. There is a huge variety of actionable steps to take: obfuscating urls such that your site can't be spidered, adding page and session-specific tokens, purposely load-testing/flooding your app, performing user-agent fingerprinting to weed out some automated requests, writing test cases for abuse scenarios, monitoring for anomalous requests and dozens of other things. The priority depends on your infrastructure inventory and your risk tolerance which should hopefully have been clarified after your risk assessment (which you did, right?).

Automated threats kind of fall into two attacker use cases: application recon and unfair resource usage. In the context of e-commerce (where these threats are most common), this can mean sniping/hoarding concert tickets or scraping product prices, enumerating valid users or validating stolen credit cards. So, this means that when creating legitimate features take the time to think of how they can be subverted or have unintended uses. From a technical point of view, ensure you've performed security assessments and vulnerability scans, have monitoring and instrumentation in place and a whole bunch of other things like real-time detection and alerting from sources such as logs, DNS and computing resources. If you have health-checks you should have security-checks too, and spikes in CPU usage should be as concerning as spikes in unusual requests.