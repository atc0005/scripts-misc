#!/bin/bash

# Purpose:
#
# Wrapper script to call GoAccess binary for quick one-off reports
# from Apache log files. Intended to help spot abusive behavior
# from bots and other brute-force usage patterns.

# https://goaccess.io/man
# https://github.com/allinurl/goaccess

TODAY=$(date '+%Y%m%d')
HOST_NAME="SHORTNAME_HERE"
LOG_FILE="other_vhosts_access.log"
FILTER_STRING="05/Feb"

# Visitors only, ReverseDNS resolution enabled
grep "${FILTER_STRING}" ${LOG_FILE} | \
	goaccess \
		--log-format VCOMMON \
		--agent-list \
		--all-static-files \
		--enable-panel="HOSTS" \
		--ignore-panel="REQUESTS" \
		--ignore-panel="REQUESTS_STATIC" \
		--ignore-panel="NOT_FOUND" \
		--ignore-panel="VISITORS" \
		--ignore-panel="OS" \
		--ignore-panel="BROWSERS" \
		--ignore-panel="VISIT_TIMES" \
		--ignore-panel="VIRTUAL_HOSTS" \
		--ignore-panel="REFERRERS" \
		--ignore-panel="REFERRING_SITES" \
		--ignore-panel="KEYPHRASES" \
		--ignore-panel="STATUS_CODES" \
		--ignore-panel="REMOTE_USER" \
		--ignore-panel="GEO_LOCATION" \
		--with-output-resolver \
		-o ${HOST_NAME}-${TODAY}-visitors-resolved.html

# All panels, IPs only
grep "${FILTER_STRING}" ${LOG_FILE} | \
	goaccess \
		--log-format VCOMMON \
		--agent-list \
		--all-static-files \
		-o ${HOST_NAME}-${TODAY}-IPs-only.html

