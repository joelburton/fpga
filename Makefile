%.blif: %.sv
	yosys -q -p 'synth_ice40 -top main -blif $@' $<

%.txt: %.blif
	arachne-pnr -q -d 1k -o $@ -P vq100 -p $(*F).pcf $< 

%.bin: %.txt
	icepack $< $@

%: %.bin
	iceprog $<

.PHONY: clean

clean:
	rm -f *.blif *.txt *.bin