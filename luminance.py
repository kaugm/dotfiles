#!/usr/bin/env python3.8

import os
import re

def color(basecolor):

	# Prep hex string
	hexcode = basecolor[1:]

	# Split into R,G,B and convert to decimal values
	comp = [hexcode[i:i + 2] for i in range(0, len(hexcode), 2)]
	red = int(comp[0], 16)
	green = int(comp[1], 16)
	blue = int(comp[2], 16)

	# Calculate luminance and d value
	luminance = float((0.299 * red + 0.587 * green + 0.114 * blue)/255)

	# Check luminance value. If high, set R,G,B to 0
	d = 0
	if luminance > 0.5:
		d = 17
	else:
		d = 238
	
	# Convert to hex color code
	outputcolor = "#{0:02x}{1:02x}{2:02x}".format(abs(d), abs(d), abs(d))

	print(outputcolor)
	return(outputcolor)

def abs(x): 
  return max(0, min(x, 255))

with open('/home/karl/.cache/rpg/colors') as f:
	line8=f.readlines()[8]
color(eval(line8[7:]))




