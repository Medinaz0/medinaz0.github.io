#!/bin/bash
# new-post.sh - Create a new HTB write-up post
# Usage: ./new-post.sh "MachineName"

NAME="$1"

if [ -z "$NAME" ]; then
  echo "Usage: ./new-post.sh \"MachineName\""
  exit 1
fi

SLUG=$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
DATE=$(date +%Y-%m-%d)
FILE="_posts/${DATE}-htb-writeup-${SLUG}.md"
DIR="assets/images/htb-writeup-${SLUG}"

mkdir -p "$DIR"

cat > "$FILE" << EOF
---
layout: single
title: "${NAME} - Hack The Box"
excerpt: ""
date: ${DATE}
classes: wide
header:
  teaser: /assets/images/htb-writeup-${SLUG}/${SLUG}_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.webp
categories:
  - hackthebox
tags:
  -
---

![](/assets/images/htb-writeup-${SLUG}/${SLUG}_logo.png)

## Reconnaissance

## Exploitation

## Privilege Escalation
EOF

echo "✅ Created: ${FILE}"
echo "✅ Created: ${DIR}/"
nvim "$FILE"
