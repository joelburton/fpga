%.json: %.v $(other)
	yosys -p "read_verilog $^; synth_ice40 -json $@"


%.json: %.sv $(other)
	yosys -p "read_verilog -sv $^; synth_ice40 -json $@"

# %.asc: %.blif
# 	arachne-pnr -q -d 1k -o $@ -P vq100 -p go.pcf $<

%.asc: %.json
	nextpnr-ice40 --hx1k --pcf go.pcf --package vq100 --asc $@ --json $<
	
%.bin: %.asc
	icepack $< $@

%: %.bin
	iceprog $<

%.out: %.sv
	iverilog $< $(*F)_test.sv -o$@

%.out: %.v
	iverilog $< $(*F)_test.v -o$@

%.test: %.out
	./$<
	rm $<
	gtkwave dump.vcd

.PHONY: clean
# .PRECIOUS: %.asc %.blif

clean:
	rm -f *.blif *.asc *.bin *.json *.vcd
