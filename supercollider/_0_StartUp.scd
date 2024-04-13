// TODO!!! Unify with live-code-this startup
StartupFile.choose
HelpBrowser.instance
q = q ? ();
// "globals/0_loadGlobalUtils.scd".loadRelative;
// if(p == Ndef.dictFor(s) ) {p=nil} {p = Ndef.dictFor(s).quant_(4)};
// "interface/superDirt_startup*".loadRelative;
// "FX/vstPlugin*".loadRelative;
/*
(q.topDir +/+ "FX/vstPlugin.scd").openDocument;
"FX/fxLib.scd".loadRelative;
"FX/FXXX_orbs*".loadRelative;
"FX/myTidalFx.scd".loadRelative;
"interface/tidal_set_FX*".loadRelative;
VSTPlugin.plugins(s).do{|u|u.postln}
~dirt.stop:
*/
unixCmd("terminator"); // tidalvim
s.meter;
"Synths/tidalInstruments*".loadRelative;
// "loop_SoundIn.scd".loadRelative;
// "mini_Ruviaro_LoopStation.scd".loadRelative;
z = Pbind(amp: 1).play
z.stop
p.test.stop
p.test = { [Saw.ar(220, amp: 0.2), SinOsc.ar(440)] * 0.2 }
z.stop
s.meter
s.boot
s.quit
CmdPeriod.run
VSTPlugin
VSTPlugin.pluginList.do{|f| f.postln;};
s.quit
s.meter
Quarks.gui
Ndef(\orb0).gui
// s.record("/media/skmecs/TOSHIBA EXT1/TRABALHO/CAMPO/Recordings/2022-27-03_CAMPO.aiff")
