#!/bin/bash
source "bootstrap-tests.bash"
test_name="unterminated quote"
wordsplit "'foo"
if [ $? -gt 0 ];then
  pass "$test_name (single)"
else
  fail "$test_name (single) returns success"
fi
if [ -n "$WORDERR" ];then
  pass "$test_name set WORDERR"
else
  fail "$test_name does not set WORDERR"
fi

wordsplit "foo" # clear error
if [ $? -eq 0 ];then
  pass "$test_name clears error"
else
  fail "$test_name does not clear error"
fi
if [ -z "$WORDERR" ];then
  pass "$test_name clears WORDERR"
else
  fail "$test_name does not clear WORDERR"
fi

wordsplit '"foo'
if [ $? -gt 0 ];then
  pass "$test_name (double)"
else
  fail "$test_name (double) returns success"
fi
if [ -n "$WORDERR" ];then
  pass "$test_name set WORDERR"
else
  fail "$test_name does not set WORDERR"
fi

end
