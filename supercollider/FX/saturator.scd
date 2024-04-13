
(
~dirt.addModule('saturator', { |dirtEvent|
	dirtEvent.sendSynth('saturator' ++ ~dirt.numChannels,
	);
}, { ~sind.notNil or: { ~satur.notNil } }); // play synth only if at least one of the two was given
);
(
SynthDef( "saturator" ++ ~dirt.numChannels, { | out sind = 4 smul = 0.25 satur = 1 sustain |
	var signal, saturated, drywet;
	// (smul).poll(Impulse.kr(0.0), label: "smul");
	signal = In.ar(out, ~dirt.numChannels);
	saturated = AudioMSG.ar( signal, sind, mul:smul);
	drywet = XFade2.ar(signal, saturated, satur * 2 - 1);
	ReplaceOut.ar(out, drywet)
}).add;
);

