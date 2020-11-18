#!/bin/sh

set -eu

ruby script/setup_local_database.rb

ruby test/automated.rb $@
