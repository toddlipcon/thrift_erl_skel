#!/bin/sh

BASE=`dirname $0`
THRIFT=$BASE/../thrift

erl -pa \
  $BASE/ebin \
  $BASE/gen/ebin \
  $THRIFT/ebin \
  -sname SKEL_SHORTNAME \
  -run SKEL_SHORTNAME_app start_all
