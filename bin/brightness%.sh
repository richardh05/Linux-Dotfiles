#!/bin/bash
brightnessctl -m --exponent [4] get | #get the concise exponential brightness
	cut -d, -f4; #cut out the 4th word
# | tr -d % #trim the %
