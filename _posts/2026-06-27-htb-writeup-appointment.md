---
layout: single
title: 'Appointment'
excerpt: 'Appointment is a very easy Linux machine which showcases beginner SQL Injection techniques against an SQL database enabled web application.'
date: 2026-06-27
classes: wide
header:
  teaser: /assets/images/htb-writeup-appointment/appointment_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.svg
categories:
  - HTB Starting Point
tags:
  - Tier-1-Fundamental-Exploitation
os: Linux
difficulty: Very Easy
release: 2021-10-06
ip: 10.129.98.135
---

{% include info-card.html %}

## Task 1

![Task 1](/assets/images/htb-writeup-appointment/Task 1.png)

## Task 2

![Task 2](/assets/images/htb-writeup-appointment/Task 2.png)

## Task 3

![Task 3](/assets/images/htb-writeup-appointment/Task 3.png)

## Task 4

![Task 4](/assets/images/htb-writeup-appointment/Task 4.png)

<pre class="language-"><code class="language-">
❯ nmap -sCV -p80 10.129.98.135 -oN targeted
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-06-27 12:02 -05
Nmap scan report for 10.129.98.135
Host is up (0.21s latency).

PORT   STATE SERVICE VERSION
80/tcp open  http    <span style="color: #bb66ff;">Apache httpd 2.4.38 ((Debian))</span>
|_http-server-header: Apache/2.4.38 (Debian)
|_http-title: Login

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 11.70 seconds
</code></pre>

## Task 5

![Task 5](/assets/images/htb-writeup-appointment/Task 5.png)

## Task 6

![Task 6](/assets/images/htb-writeup-appointment/Task 6.png)

## Task 7

![Task 7](/assets/images/htb-writeup-appointment/Task 7.png)

## Task 8

![Task 8](/assets/images/htb-writeup-appointment/Task 8.png)

## Task 9

![Task 9](/assets/images/htb-writeup-appointment/Task 9.png)

## Task 10

![Task 10](/assets/images/htb-writeup-appointment/Task 10.png)

## SQL Injection

![login](/assets/images/htb-writeup-appointment/Login%20Page.png)

![SQL Injection](/assets/images/htb-writeup-appointment/SQL%20Injection%20Login.png)

![Flag](/assets/images/htb-writeup-appointment/Flag.png)

## Submit Flag

![Task 11](/assets/images/htb-writeup-appointment/Task 11.png)

![You have solved Appointment!](/assets/images/htb-writeup-appointment/You%20have%20solved%20Appointment!.png)
