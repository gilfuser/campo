fork{
    MIDIClient.init;    // if not already done
    s.sync;
    2.wait;
    m = MIDIOut(1);  // use virtual source port "out0"
    0.2.wait;
    m.connect(1);  // connect to MIDIClient.destinations[1]
    0.2.wait;
    ~dirt.soundLibrary.addMIDI(\acid, m);
    m.latency = 0;

    Ndef( \soundIn, { | amp = 0.21 |
        var sig = SoundIn.ar(0, amp);
        LeakDC.ar(sig!2);
    }).play;
    Ndef( \soundIn).gui;
    if ( m.class == MIDIOut and: ~dirt.class == SuperDirt )
    {
        ~dirt.soundLibrary.addMIDI(\mb33, m);
    };

    /*
    Ndef(\acid).ar(2);
    0.2.wait;
    ProxyChain.from( Ndef(\acid), [ \soundin, \comp, \bitcrush, \wah, \pitch, \modelay, \verb, ] );
    wait(0.2);
    ProxyChain(\acid).gui;
    0.2.wait;
    x = Pbind(\degree, Prand([1, 2, 3, [0, 5]], inf), \bend, Pwhite(0, 76, inf));
    z = { SoundIn.ar(0) }.play;
    s.meter
    // chain a midi event into the pattern and play it (see Pchain)

    (x <> (type: \midi, midiout: m)).play;
    (
        Pdef(\vsti,
            Ppar([
                Pbind(
                    \type, \midi,
                    // this line is optional b/c noteOn is the default
                    // just making it explicit here
                    \midicmd, \noteOn,
                    \midiout, ~acid.midi,    // must provide the MIDI target here
                    \chan, 0,
                    // degree is converted to midinote, not just frequency
                    \degree, Pbrown(-7, 12, Prand([3,5,7],inf)),
                    \dur, Pwrand([0.25, Pn(0.125, 2)], #[0.8, 0.2], inf),
                    // \legato, sin(Ptime(inf) * 0.5).linexp(-1, 1, 1/3, 3),
                    \amp, Pexprand(0.1, 0.2, inf),
                    \bend, Pwhite(0, 76, inf),
                )/*,
                Pbind(
                    \type, \midi,
                    // this line is optional b/c noteOn is the default
                    // just making it explicit here
                    // \midicmd, \noteOn,
                    \vst_param, 2,
                    \midiout, ~acid.midi,    // must provide the MIDI target here
                    \chan, 2,
                    \degree, Prand([\Rest, -7, -12], inf),
                    \dur, 0.25,
                    // degree is converted to midinote, not just frequency
                    // \degree, Pwhite(-7, 12, inf),
                    // \dur, Pwrand([0.25, Pn(0.125, 2)], #[0.8, 0.2], inf),
                    \legato, sin(Ptime(inf) * 0.5).linexp(-1, 1, 1/4, 1),
                    \amp, Pexprand(0.1, 0.2, inf),
                    // \bend, Pwhite(0, 76, inf),
                )*/
            ], inf)
        );
    );

    Pdef(\vsti).gui;
    a = Pbind(\degree, Prand([1, 2, 3, [0, 5]], inf), \bend, Pwhite(0, 76, inf));
    (a <> (type: \midi, midiout: ~vstI.midi)).play;


    (
        // substitute your own device here
        var    mOut = MIDIOut.newByName("FastLane USB", "Port A").latency_(Server.default.latency);

        p = Pbind(
            \type, \midi,
            // this line is optional b/c noteOn is the default
            // just making it explicit here
            \midicmd, \noteOn,
            \midiout, mOut,    // must provide the MIDI target here
            \chan, 0,
            // degree is converted to midinote, not just frequency
            \degree, Pwhite(-7, 12, inf),
            \dur, Pwrand([0.25, Pn(0.125, 2)], #[0.8, 0.2], inf),
            \legato, sin(Ptime(inf) * 0.5).linexp(-1, 1, 1/3, 3),
            \amp, Pexprand(0.5, 1.0, inf)
        ).play(quant: 1);
    )
    */
}
