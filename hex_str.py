# utils to convert "0a 0b 0c" to \x0a\x0b\x0c and back, etc.
def str_to_bytes(hstr):
	bytes = []
	hstr = ''.join(hstr.split(' '))
	for i in range(0, len(hstr), 2):
		bytes.append(int(hstr[i:i+2], 16))
	return bytes

def hex_to_str(hstr):
	bytes = []
	hstr = ''.join(hstr.split(' '))
	for i in range(0, len(hstr), 2):
		bytes.append(chr(int(hstr[i:i+2], 16)))
	return ''.join(bytes)

def str_to_hex(bstr):
	return ''.join(["%02X " % ord(x) for x in bstr]).strip()

if __name__ == "__main__":
	s1 = "3a313b33"
	s2 = hex_to_str(s1)
	print "hex_to_str: ", s1, "->", s2
	print "str_to_hex: ", s2, "->", str_to_hex(s2)
	print "str_to_bytes: ", str_to_bytes(s1)

	s3 = "\x32\x40\x20\x30"
	print "s3:", str_to_hex(s3)
