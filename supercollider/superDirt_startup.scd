q = q ? ();
{
    if (~dirt != nil ) { ~dirt.stop; ~dirt.freeAllSoundFiles; ~dirt.free; };
    0.1.wait;
    ~dirt = SuperDirt(2, s);
    s.sync; // wait for samples to  be read
    ~dirt.start(57120, ([2, 4, 6, 8]), NetAddr("0.0.0.0") );
    s.sync; // wait for samples to be read
    0.1.wait;
    ~dirt.loadSoundFiles(q.samples);
    ~dirt.loadSoundFileFolder("/home/skmecs/Trabalho/CAMPO/asas/asas", 'asas');
    0.1.wait;
    // "../interface/sync-to-tidal*".loadRelative;

    q.orb0 = ~dirt.orbits[0];
    q.orb1 = ~dirt.orbits[1];
    q.orb2 = ~dirt.orbits[2];
    q.orb3 = ~dirt.orbits[3];

    0.2.wait;
    Ndef(\orb0).ar(2);
    Ndef(\orb1).ar(2);
    Ndef(\orb2).ar(2);
    Ndef(\orb3).ar(2);
    /*
    [ Ndef(\orb0), Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.proxyspace.clock_(p.clock));
    */

    0.2.wait;
    Ndef(\orb0).proxyspace.quant_(1);
    Ndef(\orb1).proxyspace.quant_(1);
    Ndef(\orb2).proxyspace.quant_(1);
    Ndef(\orb3).proxyspace.quant_(1);
    0.2.wait;
    q.orb0.outBus = Ndef(\orb0).bus;
    q.orb1.outBus = Ndef(\orb1).bus;
    q.orb2.outBus = Ndef(\orb2).bus;
    q.orb3.outBus = Ndef(\orb3).bus;
    0.2.wait;

    Ndef(\orb0).play(2);
    Ndef(\orb1).play(4);
    Ndef(\orb2).play(6);
    Ndef(\orb3).play(8);

    2.wait;
    "/tidalInstruments*".loadRelative;

    ~dirt.loadSynthDefs("/tidalInstruments*");
    // ~dirt.loadSynthDefs("../Synths/vstinstrument*");

    2.wait; // wait for samples to be read
    "/FX/myTidalFx*".loadRelative;

    Ndef(\allOrbs, {
	Limiter.ar(
	    Ndef(\orb0) + Ndef(\orb1) + Ndef(\orb2) + Ndef(\orb3)
	);
    }).play;

    "super-dirt prepared".postln;
}.fork;
