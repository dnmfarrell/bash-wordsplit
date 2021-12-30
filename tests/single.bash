#!/bin/bash
source "bootstrap-tests.bash"
test_name="common cases"
args="'foo'	'bar baz' '\\a\\\`b\\\"c\\\$'"
wordsplit "$args"
if [ -z "$WORDERR" ];then
  pass "no parse error"
else
  fail "parse error: $WORDERR"
fi
if [ $WORDC -eq 3 ];then
 pass "$test_name count"
else
 fail "$test_name count got '$WORDC'"
fi
col=0
if [ "${WORDS[$col]}" = 'foo' ];then
  pass "$test_name col $col"
else
  fail "$test_name col $col got '${WORDS[$col]}'"
fi
col=1
if [ "${WORDS[$col]}" = 'bar baz' ];then
  pass "$test_name col $col"
else
  fail "$test_name col $col got '${WORDS[$col]}'"
fi
col=2
if [ "${WORDS[$col]}" = '\a\`b\"c\$' ];then
  pass "$test_name col $col"
else
  fail "$test_name col $col got '${WORDS[$col]}'"
fi
end
