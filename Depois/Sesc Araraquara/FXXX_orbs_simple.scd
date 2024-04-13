{

	//
	Ndef(\orb0).addSpec( /* tape -----*/ \trate, [ 0.125, 4, \lin, 0.125, 0.25 ],  \tphase, [ 0, 2], \toffset, [0, 1], \tdepth, [0, 1] );

	0.2.wait;
	q.fx.orb0 = ProxyChain.from( Ndef(\orb0),
		[ 'tape', /*'hole', 'filter', 'wah', 'llfo', 'strobe', 'comp', 'ampFin' */ ]
	);
	0.2.wait;

	Ndef(\orb0).set(
		/* tape */ \trate, 0.25, \tphase, 0, \tdepth, 0.5, \toffset, 0.5,
	);

	0.1.wait;
	q.fx.orb0.add('tape', 0.2);

	q.fxDir = thisProcess.nowExecutingPath.dirname;
	0.1.wait;

}.fork;
