#!/usr/bin/env python
# little dec <-> hex command line converter
# (c) Leon Szpilewski, http://github.com/jsz
# License GPL3

mode = 32

mode_data = {
		8 : { 'max_int' : 0xff,
					'bits_in_word' : 8,
					'hfstr' : "0x%.2x"},
		16 : { 'max_int' : 0xffff,
					 'bits_in_word' : 16,
					 'hfstr' : "0x%.4x"},
		32 : { 'max_int' : 0xffffffff,
					 'bits_in_word' : 32,
					 'hfstr' : "0x%.8x"},
		64 : { 'max_int' : 0xffffffffffffffff,
					 'bits_in_word' : 64,
					 'hfstr' : "0x%.16x"},
		}


SIGNED = True 

import sys

def bit_count(integer):
	count = 0
	while(integer):
		integer &= (integer - 1)
		count += 1
	return count

if len(sys.argv) <= 1:
	print "syntax: %s [-m 16/32/64] <number(s)>" % (sys.argv[0])
	sys.exit(23)
cmd = sys.argv[1:]
if sys.argv[1] == '-m':
	mode = int(sys.argv[2])
	cmd = sys.argv[3:]
elif sys.argv[1][0:2] == "-m":
	mode = int(sys.argv[1][2:])
	cmd = sys.argv[2:]

try:
	cur_mode = mode_data[mode]
except KeyError:
	print "no such mode %i!" % (mode)
	sys.exit(24)

for s in cmd: 
	kind = "dec" 
	o = s
	if s[0] == '-':
		s = s[1:]
		kind = "decneg"
	if s[0] == '0' and s[1] == 'x':
		s = s[2:]
		kind = "hex"
	if s[len(s)-1] == 'h':
		s = s[0:len(s)-1]
		kind = "hex"
	t = s
	if kind == "hex":
		i = int(s, 16)
		if SIGNED:
			if i >= (1<<cur_mode['bits_in_word']-1): 
				i = i - (1<<cur_mode['bits_in_word'])
		t = "%i" % i 
	
	if kind == "dec" or kind == "decneg":
		fstr = "0x%.2x"
		i = int(s, 10)
		if kind == "decneg":
			i = cur_mode['max_int'] - i + 1 
		t = cur_mode['hfstr'] % (i)
	print o, " -> ", t


