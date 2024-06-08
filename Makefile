%: %.v
	yosys -q -p 'synth_ice40 -top main -blif $@.blif' $<
	arachne-pnr -q -d 1k -o $@.txt -P vq100 -p Go_Board_Constraints.pcf $@.blif 
	icepack $@.txt $@.bin
	iceprog $@.bin
