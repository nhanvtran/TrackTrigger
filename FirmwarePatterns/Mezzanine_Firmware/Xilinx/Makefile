# Makefile for Xilinx ISE 14.x

# design name
DESIGN = vipram

# target device
BASE   = xc7k160t
PACK   = fbg484
SPEED  = 1

# path to the VHDL source code files
VSRC = ../src/*.vhd

###############################################################################

#$(DESIGN).mcs: $(DESIGN).bit
#	promgen -p mcs -c -data_width 16 -x xcf08p -w -u 0 $(DESIGN).bit

$(DESIGN).bit: $(DESIGN)_par.ncd $(DESIGN).twr
	bitgen $(DESIGN)_par.ncd $(DESIGN).bit -d -w \
	-g UserID:0x00defec8 \
	-g ConfigRate:6 \
	-g Compress

$(DESIGN).twr: $(DESIGN)_par.ncd $(DESIGN).pcf
	trce $(DESIGN)_par.ncd $(DESIGN).pcf -e 3 -o $(DESIGN).twr

$(DESIGN)_par.ncd: $(DESIGN)_map.ncd $(DESIGN).pcf
	par -w $(DESIGN)_map.ncd $(DESIGN)_par.ncd $(DESIGN).pcf

$(DESIGN)_map.ncd: $(DESIGN).ngd
	map -w -p $(BASE)-$(PACK)-$(SPEED) -o $(DESIGN)_map.ncd $(DESIGN).ngd $(DESIGN).pcf

$(DESIGN).ngd: $(DESIGN).ngc $(DESIGN).ucf
	ngdbuild -p $(BASE)-$(PACK)-$(SPEED) -uc $(DESIGN).ucf -dd . $(DESIGN).ngc $(DESIGN).ngd

$(DESIGN).ngc: $(VSRC) $(DESIGN).prj $(DESIGN).scr $(DESIGN).xcf
	sed -e 's/TARGET/$(BASE)-$(PACK)-$(SPEED)/g' $(DESIGN).scr > $(DESIGN).xst
	xst -ifn $(DESIGN).xst

clean:
	rm -Rf xst xlnx_auto* _xmsgs
	rm -f *~ *.ise *.xrpt *.ptwx *.twx *.psr *.cfi
	rm -f *.par *.ncd *.prm *.mcs *.ngm *.log *.bgn *.drc *.pad *.sig *_vhdl.prj
	rm -f *.bit *.bld *.mrp *.pcf *.srp *.xml *.twr *.lst *.csv *.lso *.map *.xwbt
	rm -f $(DESIGN).ngc *.ngd *.xpi *pad.txt part.txt *.xst *.ngr *.unroutes *.mcs *.hex *.bin



