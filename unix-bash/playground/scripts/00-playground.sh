#!/bin/bash

# MAN page
.\" Manpage for nuseradd.
.\" Contact vivek@nixcraft.net.in to correct errors or typos.
.TH man 8 "06 May 2010" "1.0" "nuseradd man page"

.SH NAME
nuseradd \- create a new LDAP user 

.SH SYNOPSIS
nuseradd [USERNAME]

.SH DESCRIPTION
nuseradd is high level shell program for adding users to LDAP server.  On Debian, administrators should usually use nuseradd.debian(8) instead.

.SH OPTIONS
The nuseradd does not take any options. However, you can supply username.

.SH SEE ALSO
useradd(8), passwd(5), nuseradd.debian(8) 

.SH BUGS
No known bugs.

.SH AUTHOR
Vivek Gite (vivek@nixcraft.net.in)

# STOUT and STERR
echo "this is going to stderr" >&2 
echo "this is going to stdout" >&1 
echo "this is also going to stderr" >&2 
echo "this is also going to stdout" >&1 