fmaArm = props.globals.initNode("/instrumentation/pfd/fma/arm", " ", "STRING");
fmaThr = props.globals.initNode("/instrumentation/pfd/fma/thr", " ", "STRING");
fmaLat = props.globals.initNode("/instrumentation/pfd/fma/lat", " ", "STRING");
fmaVert = props.globals.initNode("/instrumentation/pfd/fma/vert", " ", "STRING");

var arm = nil;

setlistener("/it-autoflight/mode/arm", func() {
	arm = Text.arm.getValue();
	if (arm == "ILS") {
		fmaArm.setValue("LOC");
	} elsif (arm == "LNV") {
		fmaArm.setValue("LNAV");
	} elsif (arm == "LOC") {
		fmaArm.setValue("LOC");
	} else {
		fmaArm.setValue(" ");
	}
});

var lat = nil;

var updateLat = func() {
	lat = Text.lat.getValue();
	if (lat == "T/O") {
		fmaLat.setValue("TO/GA");
	} elsif (lat == "LNAV") {
		fmaLat.setValue("LNAV");
	} elsif (lat == "RLOU") {
		fmaLat.setValue("ROLLOUT");
	} elsif (lat == "HDG") {
		if (!Output.hdgInHld.getBoolValue()) {
			fmaLat.setValue("HDG SEL");
		} else {
			fmaLat.setValue("HDG HOLD");
		}
	} elsif (lat == "LOC") {
		fmaLat.setValue("LOC");
	} elsif (lat == "ALGN") {
		fmaLat.setValue("LOC");
	} else {
		fmaLat.setValue(" ");
	}
}

setlistener("/it-autoflight/mode/lat", updateLat);
setlistener("/it-autoflight/output/hdg-in-hld", updateLat);

var vert = nil;

setlistener("/it-autoflight/mode/vert", func() {
	vert = Text.vert.getValue();
	if (vert == "T/O" or vert == "T/O CLB" or vert == "G/A CLB") {
		fmaVert.setValue("TO/GA");
	} elsif (vert == "ALT HLD" or vert == "ALT CAP") {
		fmaVert.setValue("ALT");
	} elsif (vert == "ROLLOUT") {
		fmaVert.setValue("ROLLOUT");
	} elsif (vert == "FLARE") {
		fmaVert.setValue("FLARE");
	} elsif (vert == "SPD CLB" or vert == "SPD DES") {
		fmaVert.setValue("FLCH SPD");
	} elsif (vert == "V/S") {
		fmaVert.setValue("V/S");
	} elsif (vert == "G/S") {
		fmaVert.setValue("G/S");
	} elsif (vert == "FPA") {
		fmaVert.setValue("????");
	} else {
		fmaVert.setValue(" ");
	}
});

var thr = nil;

setlistener("/it-autoflight/mode/thr", func() {
	thr = Text.thr.getValue();
	if (thr == "PITCH") {
		fmaThr.setValue("THR REF");
	} elsif (thr == "RETARD") {
		fmaThr.setValue("IDLE");
	} elsif (thr == "THRUST") {
		fmaThr.setValue("SPD");
	} else {
		fmaThr.setValue(" ");
	}
});