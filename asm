#!/usr/bin/env python
# a little wrapper around nasm to make assembling
# small snippets of x86 from stdin easier
# 
# NASM must be installed and in $PATH
# 
# example:
#  ./asm mov eax, 1
#  ./asm "lbl: jmp lbl"   //produces eb fe
#  ./asm "jmp 0"          //produces e9 fd ff
#
# (c) Leon Szpilewski, http://github.com/jsz
# Licensed under GPL3

import sys
import os
import tempfile

if len(sys.argv) <= 1:
	print "syntax: %s <asm instruction>" % (sys.argv[0])
	os.exit(23)

s = " ".join(sys.argv[1:])

tf = tempfile.NamedTemporaryFile()
n = tf.name

tf.write(s)
tf.flush()

print os.popen("nasm %s -o %s && hexdump -C %s && rm -f %s" % (n, n+".out", n+".out", n+".out")).read()

tf.close()
