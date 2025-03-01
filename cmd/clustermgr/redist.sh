#!/bin/sh
#  
#  Copyright 2023 PayPal Inc.
#  
#  Licensed to the Apache Software Foundation (ASF) under one or more
#  contributor license agreements.  See the NOTICE file distributed with
#  this work for additional information regarding copyright ownership.
#  The ASF licenses this file to You under the Apache License, Version 2.0
#  (the "License"); you may not use this file except in compliance with
#  the License.  You may obtain a copy of the License at
#  
#     http://www.apache.org/licenses/LICENSE-2.0
#  
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#  
 

BASE=$(dirname "$0")
FILE=junocfg.log

cd ${BASE}

echo "Start running clustermgr ..."
echo 

find $FILE -mtime +2 -type f -delete

echo >> $FILE
echo "# ./clustermgr $@" >> $FILE
echo >> $FILE

ARGS=""

for i in "$@"
do
case $i in
	-type=*)
	ARGS="${ARGS} $i"
	shift
	;;
	-zone=*)
	ARGS="${ARGS} $i"
	shift
	;;
	-max_failures=*)
	ARGS="${ARGS} $i"
	shift
	;;
	-min_wait=*)
	ARGS="${ARGS} $i"
	shift
	;;
	-ratelimit=*)
	ARGS="${ARGS} $i"
	shift
	;;
esac
done

./clustermgr -cmd=redist ${ARGS} 2>&1 | tee -a $FILE
