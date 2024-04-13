({

    /* ~vwet = Bus.control(s, 4);
    ~vdry = Bus.control(s, 4);
    ~vdelay = Bus.control(s, 4);
    ~vsize = Bus.control(s, 4);
    ~vlocut = Bus.control(s, 4);
    ~vhicut = Bus.control(s, 4);

    ~vwet.setn([0.2, 0.2, 0.3, 0.2]);
    ~vdry.setn(1!4);
    ~vdelay.setn([0.1, 0.1, 0.125, 0.15]);
    ~vsize.setn(0.60!4);
    ~vlocut.setn([0.7, 0.7, 0.64, 0.64]);
    ~vhicut.setn([0.25, 0.25, 0.125, 0.125]); */

    (
        SynthDef(\masterFX, { | in out bypass = 0 |
            ReplaceOut.ar(out, VSTPlugin.ar( In.ar(in, 2), 2, bypass ));
        }).add;

        SynthDef(\vst_insert, { | in out bypass=0 |
            ReplaceOut.ar(out, VSTPlugin.ar( In.ar(in, 2), 2, bypass ));
        }).add;
    );

    0.2.wait;
    ~masterFxGroup = Group.after(1); // after default group
    0.2.wait;
    ~comp = VSTPluginController( Synth( \masterFX, [ \in, 0, \out, 0 ], target: ~masterFxGroup , addAction: 'addToTail') );
    0.2.wait;
    // ~comp.open( "Auburn Sounds Couture.vst3" );
    ~comp.open( "RoughRider3.vst3" );
    1.wait;
    // s.sync;
    ~comp.readProgram("/home/skmecs/vst/roughRider.fxp");
    ~comp.editor;
    // ~comp.close;
    // s.sync;
    // " \n compressor loaded  \n".postln;
    1.wait;
    ~fxGroupO0 = Group.after(1); // after default group
    0.1.wait;
    /*
    ~eqOrb0 = VSTPluginController( Synth( \vst_insert, [ \in, 2, \out, 2 ], ~fxGroupO0, addAction: \addToTail ) );
    0.2.wait;
    ~eqOrb0.open( "ZBandpass2" );/
    1.wait;
    s.sync;
    ~eqOrb0.readProgram("/home/skmecs/vst/orb0eqPedras.fxp");
    0.2.wait;
    s.sync;
    */
    // AppClock.play(~eqOrb0.gui);
    " \n EQ at orb 0 loaded \n".postln;

    ~verbOrb0 = VSTPluginController( Synth(\vst_insert, [ \in, 2, \out, 2 ], ~fxGroupO0, addAction: \addToTail));
    0.2.wait;
    ~verbOrb0.open( "/home/skmecs/.vst/Tal-Reverb-4.so" );
    1.wait;
    s.sync;
    ~verbOrb0.readProgram( "/home/skmecs/vst/orb0verb.fxp" );
    s.sync;
    ~verbOrb0.editor;
    0.2.wait;
    s.sync;

    // ~verbOrb0.map(1, ~vwet.subBus(0));
    // ~verbOrb0.map(2, ~vdry.subBus(0));
    // ~verbOrb0.map(3, ~vdelay.subBus(0));
    // ~verbOrb0.map(4, ~vsize.subBus(0));
    // ~verbOrb0.map(5, ~vlocut.subBus(0));
    // ~verbOrb0.map(6, ~vhicut.subBus(0));
    " \n verb at orb 0 loaded  \n".postln;

    ~fxGroupOrb1 = Group.after(1);

    ~verbOrb1 = VSTPluginController( Synth( \vst_insert, [ \in, 4, \out, 4 ], ~fxGroupOrb1, addAction: \addToTail ) );

    0.2.wait;
    s.sync;
    ~verbOrb1.open( "Tal-Reverb-4" );
    2.wait;
    ~verbOrb1.readProgram("/home/skmecs/vst/orb1verb.fxp");
    s.sync;
    ~verbOrb1.editor;
    // s.sync;
    // ~verbOrb1.map(1, ~vwet.subBus(1));
    // ~verbOrb1.map(2, ~vdry.subBus(1));
    // ~verbOrb1.map(3, ~vdelay.subBus(1));
    // ~verbOrb1.map(4, ~vsize.subBus(1));
    // ~verbOrb1.map(5, ~vlocut.subBus(1));
    // ~verbOrb1.map(6, ~vhicut.subBus(1));
    " \n reverb at orb 1 loaded \n ".postln;

    ~fxGroupOrb2 = Group.after(1);
    0.2.wait;
    s.sync;
    /*
    ~eqOrb2 = VSTPluginController( Synth(\vst_insert, [ \in, 6, \out, 6 ], ~fxGroupOrb2, addAction: \addToTail) );
    0.2.wait;
    ~eqOrb2.open( "ZHighpass2" );
    1.wait;
    ~eqOrb2.readProgram("/home/skmecs/vst/zHipass2_Orb2-EQ.fxp");
    s.sync;
    "eq at orb 3 loaded".postln;
    */
    ~verbOrb2 = VSTPluginController( Synth(\vst_insert, [ \in, 6, \out, 6 ], ~fxGroupOrb2, addAction: \addToTail));
    0.2.wait;
    ~verbOrb2.open( "Tal-Reverb-4" );

    Ndef(\fx, \vst -> { VSTPlugin.ar(\in.ar(0 ! 2), 2) });
    // Route \white to \fx. (Don't use '<>>' or '<<>'!)
    Ndef(\fx).set(\in, Ndef(\orb2));
    ~fx = VSTPluginNodeProxyController(Ndef(\fx)).open("Tal-Reverb-4", editor: true);
    ~fx.editor;

    Ndef(\fx).play;
    Ndef(\orb1)[101] = \vstFilter -> { |in| VSTPlugin.ar(in, 2) };
    ~rev1 = VSTPluginNodeProxyController(Ndef(\orb1), 101).open("Tal-Reverb-4", editor: true);
    1.wait;
    ~rev1.readProgram("/home/skmecs/vst/orb1verb.fxp");
    ~rev1.editor;
    s.sync;
    // ~verbOrb2.close;
    // ~verbOrb2.map(1, ~vwet.subBus(2));
    // ~verbOrb2.map( 2, ~vdry.subBus(2));
    // ~verbOrb2.map(3, ~vdelay.subBus(2));
    // ~verbOrb2.map(4, ~vsize.subBus(2));
    // ~verbOrb2.map(5, ~vlocut.subBus(2));
    // ~verbOrb2.map(6, ~vhicut.subBus(2));
    // AppClock.play( ~verbOrb2.editor );
    "\n verb at orb 2 loaded \n".postln;

    /*
    ~fxGroupOrb3 = Group.after(1);
    1.2.wait;
    s.sync;
    ~verbOrb3 = VSTPluginController( Synth(\vst_insert, [ \in, 8, \out, 8 ], ~fxGroupOrb3, addAction: \addToTail));
    1.2.wait;

    ~verbOrb3.open( "Tal-Reverb-4" );
    1.wait;
    ~verbOrb3.readProgram("/home/skmecs/vst/orb3verb.fxp");
    ~verbOrb3.editor;
    s.sync;
    // ~verbOrb3.map( 1, ~vwet.subBus(3) );
    // ~verbOrb3.map( 2, ~vdry.subBus(3) );
    // ~verbOrb3.map( 3, ~vdelay.subBus(3) );
    // ~verbOrb3.map( 4, ~vsize.subBus(3) );
    // ~verbOrb3.map(5, ~vlocut.subBus(3));
    // ~verbOrb3.map(6, ~vhicut.subBus(3));
    " \n verb at orb 3 loaded \n ".postln;
    0.2.wait;
    (
        SynthDef(\vst_istrument, {arg out;
            OffsetOut.ar(out, VSTPlugin.ar(nil, ~dirt.numChannels));
        }).add;
    );
    0.2.wait;
    //
    ~acid = VSTPluginController( Synth(\vst_istrument, [\out, Ndef(\orb3).bus]) );
    // // 0.4.wait;
    ~acid.open( "Vital.vst3" );
    // 4.wait;
    // ~acid.loaded;
    // ~acid.readProgram("/home/skmecs/vst/abl3.fxp");
    // 2.2.wait;
    // ~acid.close;
    */

    /*
    ~acid.gui;
    ~acid.editor
    ~acid.numParameters;
    ~acid.close;
    ~acid.info.printAll;
    ~acid.currentProgram
    ~acid.numParameters
    */
    // 0.2.wait;
    // ~acid.setTempo(110);
    // 0.2.wait;
    // ~acid.setPlaying(true);
    // ~acid.midi.noteOn(0, note: 60, veloc: 1);
    // ~acid.midi.noteOff(0, note: 60);
    // ~dirt.soundLibrary.addMIDI(\abl, ~acid.midi);
    // " \n acid at orb 3 loaded \n ".postln;
}).fork;
