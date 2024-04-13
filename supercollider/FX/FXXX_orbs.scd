{

	//
	[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3), Ndef(\orb4) ].do(_.addSpec(
		/* tape -----*/ \trate, [ 0.125, 4, \lin, 0.125, 0.25 ],  \tphase, [ 0, 2], \toffset, [0, 1],
		                \tdepth, [0, 1],
		// /* hole -----*/ \hrate, [0, 1],  \damp, [0, 1],  \hsize, [0.5, 3],  \hdif, [0, 1],  \hfb, [0, 1],
		// /* filter ---*/ \ftype, [0, 4, \lin, 1, 0], \sfreq, \freq, \res, [0, 1],
		/* pitch -*/ \pideg,  [-12, 12, \lin, 1],  \pdisp,  [0, 0.5],  \tdisp, [0, 1],  \slide, [0.02, 2],
		/* wah ------*/ \wrate,  [0, 10, \lin],  \depth, [0, 1], \jdepth, [0, 1], \jfreq, [0.1, 10, \exp],
		                \sinsaw, [0, 1, \lin, 1, 0],  \ggain, [0.001, 1, \lin/*\amp*/],\wring, [0.001, 1, \exp],
		/* llfo -----*/ \lrate, [ 0, 16, \lin, 0.125, 1 ],  \hifreq, [200, 20000, \exp, 0, 20000],
		                \lwidth, [ 0, 1 ], \sisap, [0, 2, \lin,1, 1],  \iphase, [ 0.001, 1, \exp, 0, 0.5 ],
		// /* duck --*/ \dcurve, [-6, 6],  \dwidth, [0, 1],  \ddur, [ 0.25, 4 ],  \iphase, [ 0, 1 ],
		// /* strobe */ \strob, [0.25, 12, 1, 0.25],  \scurve, [0, 6, 0, 1],  \ontime, [0.16, 16],
	                    // \offtime, [0.16, 16],  \sphase, [0.16, 16],
		/* comp -----*/ \cctrl, [0, 3, \lin, 1, 1], \thresh, [-60.dbamp, 1, \amp], \slopea, [0.05, 1],
		                \clamp, [0.002, 0.4], \relax, [0.005, 2], \delta, [0.01, 10],
		/* ampFin ---*/ \limDrive, \ampx4,  \ampLimit, \amp,  \postAmp, \ampx4,
        // \cps, [0.1,1],
        \wet200, [0.0, 1.0], \wet210, [0.0, 1.0],
	) );

    Ndef(\orb1).addSpec(\delta, [0, 20]);

	q.fx.orb1 = ProxyChain.from( Ndef(\orb1),
		[ 'tape', /*'hole', 'filter', */ 'wah', 'llfo', /* 'strobe', */ 'comp', 'ampFin' ]
	);
	q.fx.orb2 = ProxyChain.from( Ndef(\orb2),
		[ 'tape', /*'hole', 'filter', */'wah', 'llfo', 'comp', 'ampFin' ]
	);
	q.fx.orb3 = ProxyChain.from( Ndef(\orb3),
		[ 'tape', /*'hole', 'filter', */'wah', 'llfo', 'comp','ampFin' ]
	);
	q.fx.orb4 = ProxyChain.from( Ndef(\orb4),
		[ 'pitch', 'tape', /*'hole', 'filter', */'wah', 'llfo', 'comp', 'ampFin' ]
	);

	0.2.wait;

	[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3), Ndef(\orb4) ].do(_.set(
		/* tape */ \trate, 0.25, \tphase, 0, \tdepth, 0.5, \toffset, 0.5,
		// /* hole */ \hrate, 0.5, \damp, 0.5, \hsize, 1, \hdif, 0.7, \hfb, 0,
		// /* filter */ \ftype, 1, \sfreq, 632.46, \res, 0.5,  // lpf, bpf, hpf, notch, peak
		/* wah */ \wrate, 1, \depth, 0.75, \sinsaw, 0, \jdepth, 0.1, \jfreq, 1,
		/* llfo */ \lrate, 0, \iphase, 0.5, \lwidth, 0.5, \sisap, 0, \midfreq, 60, \hifreq, 20000,
		// /* strobe */ \strob, 1, \sphase, 1, \ontime, 1, \offtime, 1, \scurve, 0,
		/* comp */ \cctrl, 1, \thresh, 0.5, \slopea, 1, \clamp, 0.002, \relax, 0.02, \delta, 1,
		/* ampFin */ \limDrive, 1.25, \ampLimit, 1, \postAmp, 1,
		\cps, 1
	) );

	Ndef(\orb2).set(
		/* pitch */ \pideg, 0, \pdisp, 0.001, \tdisp, 0.1, \slide, 0.2,
		// /* tape */ \trate, 0.25, \tphase, 1, \tdepth, 0.25, \toffset, 0.5
	);

	Ndef(\orb3).set(
		/* comp */ \cctrl, 3, \thresh, -60.dbamp, \slopea, 0.1, \clamp, 0.002, \relax, 0.5,
		// /* hole */ \hrate, 1, \damp, 0.01, \hsize, 1.66, \hdif, 0.7, \hfb, 0.75,
		/* tape */ \trate, 0.5, \tphase, 0, \tdepth, 0.25, \toffset, 0.5
	);

    Ndef(\orb4).set(
        /* comp */ \cctrl, 3.0, \thresh, 0.2, \slopea, 0.49, \clamp, 0.002, \relax, 0.95, \deltas, 3.0,
        /* ampFin */ \limDrive, 1.25, \ampLimit, 0.95, \postAmp, 1.0
    );

	0.1.wait;
	(
	// q.fx.orb1.remove(\tape)
		[ 'tape', /*'hole', 'filter',*/'wah', /*'llfo', 'duck', 'strobe', */'comp', 'ampFin' ].do(
			{ |i| q.fx.orb1.add(i, 0) }
		);
		[ 'tape', /*'hole', 'filter', */'wah', /*'llfo', */'comp', 'ampFin' ].do(
			{ |i| q.fx.orb2.add(i, 0) }
		);
		[ 'tape', /*'hole', 'filter', */'wah', /*'llfo', */'comp', 'ampFin' ].do(
			{ |i| q.fx.orb3.add(i, 0) }
		);
		[ 'pitch', 'tape', /*'hole', 'filter', */'wah', /*'lpf', */'comp', 'ampFin' ].do(
			{ |i| q.fx.orb4.add(i, 0) }
		);
	);
    // q.fx.orb1.add('tape', 0.2);

	q.fxDir = thisProcess.nowExecutingPath.dirname;
	0.1.wait;
	(
		// Pro: good for liveCoding || Con: dificult to access controlkeys.
		{
			// var fxDir = thisProcess.nowExecutingPath.dirname

			q.guiOrb1 = q.fx.orb1.gui(33).moveTo(0, 570);
			q.guiOrb2 = q.fx.orb2.gui(33).moveTo(500, 570);
			q.guiOrb3 = q.fx.orb3.gui(33).moveTo(1000, 570);
			q.guiOrb4 = q.fx.orb4.gui(38).moveTo(1500, 570);

			// q.guiOrb4 = q.fx.orb4.gui(8).moveTo(0, 0);
			q.o0Pset = NdefPreset( Ndef(\orb1) );

            // q.o0Pset.loadSettings( q.fxDir ++ "/orb1.pxpreset.scd");
			q.o0PsetGui = NdefPresetGui(q.o0Pset, 40).moveTo(0, 570);


			q.o1Pset = NdefPreset( Ndef(\orb2) );
			/*
			q.o1Pset.loadSettings( q.fxDir ++ "/orb2.pxpreset.scd");
			q.o1PsetGui = NdefPresetGui(q.o1Pset, 40).moveTo(500, 570);
			*/

			q.o2Pset = NdefPreset( Ndef(\orb3) );
			/*
			q.o2Pset.loadSettings( q.fxDir ++ "/orb3.pxpreset.scd");
			q.o2PsetGui = NdefPresetGui(q.o2Pset, 40).moveTo(1000, 570);
			*/

			q.o3Pset = NdefPreset( Ndef(\orb4) );
			q.o3Psetgui = NdefPresetGui(q.o3Pset, 40).moveTo(1500, 570);

			/*
			q.o3Pset.loadSettings( q.fxDir ++ "/orb4.pxpreset.scd");
			*/
            {
        q.guiMb33 = q.mb33.gui(50).moveTo(500, 570);
        q.mb33Pset = NdefPreset( \soundIn );
        q.talVerb_SoundIn.editor;
        q.roughRider_SoundIn.editor;
    }.defer(1);

		}.defer;
	);
    ">>>> FXs in Orbs <<<<".postString
}.fork;
