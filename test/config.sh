#!/bin/bash
set -e

testAlias+=(
	[zcashd:trusty]='zcashd'
)

imageTests+=(
	[zcashd]='
		rpcpassword
	'
)
