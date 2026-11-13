l = SLiCE("/Users/mattpete/Dropbox/work/akademia/TEKNO-liveCodingWorkshop/liveCodingWorkshop/liveCodingSounds/");

(
// add a folder of samples (if name is nil then the file name will be used)
l.addSound(nil, "/Users/mattpete/Dropbox/work/ljudarkivet/909");

// add a single sample
l.addSound(\bou, "/Users/mattpete/Dropbox/work/ljudarkivet/bouing1.aif");

// add a synth function
l.addSound(\blip, {|freq|
	var sig;
	sig = Blip.ar(freq, \numHarm.kr(9));
});
)

// set the tempo
l.bpm(72);

// list the currently available sounds
l.listSounds;

// set master synth parameters
l.master(\revTime, 2);
l.master(\saturation, 4);

(
Pdef(\a,
	Pbind(
		\sound, Pseq([\kick, \clap, \sst], inf),
		\note, Pseq([-12, [0, 3], [-12, -8], 2, -2], inf),
		\amp, Pseq([0.3, 0.1, 0.1, 0.05]*3, inf),
		\atk, 0.01,
		\rel, 0.01,
		\div, 1,
		\dur, 0.125,
		\legato, 0.3,
		\delay, 0.1,
		\delTime, Prand([1/4, 1/3, 1/8], inf),
		\delFbTime, 4,
		\lpf, Pwhite(900, 9000),
		\saturation, 66,
		\reverb, Pwrand([0.0, 0.9], [0.9, 0.1], inf),
		\prob, 0.4,
		\reverse, 0,
		\pan, Pwhite(-0.5, 0.5),
		\saturation, 20
	)
).play(quant: 4);
)
Pdef(\a).stop;

(
Pdef(\b,
	Pbind(
		\sound, Prand([\kickme, \chh, \ohh, \chh], inf),
		\note, Pseq([0, 3, 5, 7, 2, -1, 12], inf),
		\amp, Pseq([0.3, 0.2, 0.1, 0.05], inf),
		\atk, 0.0,
		\rel, 0.7,
		\ctranspose, 12,
		\legato, 0.8,
		\dur, 0.25,
		\delay, 0,
		\loop, 1,
		\delTime, 1/3,
		\saturation, 0,
		\reverb, 0.1,
		\tremolo, 0,
		\tremoloRate, 0
	)
).play(quant: 4);
)
Pdef(\b).stop

(
Pdef(\c,
	Pbind(
		\sound, \triangle, //Prand([\bou, \sine, \saw], inf),
		\pulseWidth, Ndef(\pwm, {LFNoise1.kr(0.2).range(0.02, 0.98)}),
		\ctranspose, Prand([0, -12, 12], inf),
		\note, Prand([0, 3, 5, 8, 10], inf),
		\rel, 3,
		\atk, 0.66,
		\tremolo, 0.5,
		\tremoloRate, Pwhite(1, 8),
		\shaper, 1.0,
		\shaperBufA, 9,
		\shaperBufB, Pwhite(0, 7),
		\shaperMorph, Ndef(\morph, {SinOsc.ar(0.9)}),
		\shaperWarp, Pmeanrand(1.0, 8.0),
		\delay, 0.2,
		\reverb, 0.3,
		\reverse, 0,
		\amp, Pseq([0.2, 0.15, 0.1] * 0.8, inf),
		\dur, 0.25,
		\saturation, 0,
		\prob, 1.0
	)
).play(quant: 4);
)
Pdef(\c).stop;

(
Pdef(\d,
	Pbind(
		\sound, \chh,
		\delay, 0,
		\delTime, 1/8,
		\delFbTime, 5,
		\dur, Prand([1, 0.5, 0.25, 0.125], inf),
		\amp, 0.2,
		\prob, 1,
		\shaper, 1.0,
		\shaperWarp, 3,
		\shaperBufA, 2,
		\shaperBufB, 5,
		\shaperMorph, Pwhite(-1.0, 1.0)
	)
).play(quant: 4);
)
Pdef(\d).stop

(
Pdef(\e,
	Pbind(
		\sound, \blip,
		\note, Prand([0, 3, 5, 8, 10], inf),
		\numHarm, Ndef(\hmod, {SinOsc.ar(0.2).range(1, 10)}),
		\fmFreq, 273,
		\fmAmt, 100,
		\pan, Pwhite(-0.5, 0.5),
		\dur, 0.25,
		\legato, 0.3,
		\lpf, Pseg(Pwhite(180.0, 1800.0), Pwhite(4, 8), \exp, inf),
		\reverb, 0.9,
		\vibrato, 6,
		\vibRate, 0.5,
		\saturation, 0,
		\amp, Pwhite(0.3, 0.7)
	)
).play(quant: 4);
)
Pdef(\e).stop