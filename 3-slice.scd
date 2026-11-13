// 1. INSTALL SC3Plugins and SLiCE ------------------------------------

// 1.1. Run the line below. It should open a folder on your system.
Platform.userAppSupportDir.openOS;
// Make sure that there is a folder called Extensions in this folder. If not, create it!

// 1.2 Unzip the previously downloaded sc3Plugins and SLiCE (if not done already).
// Move the folders inside the Extensions folder.

// The SC3Plugins adds sonic possibilities to SuperCollider in the form of sound generators and effects.
// SLiCE is a live coding system that we will take a look at very soon.

// 1.3 Re-compile class library. Whenever you add stuff to the Extensions folder, SuperCollider needs to re-compile its class library. Go to the menu Language->Recompile Class Library (you can also just restart SC).
// -------------------------------------------------------------------




// 2. SLiCE ----------------------------------------------------------

// While the default synth-piano sound could be useful for testing, music making and live coding with patterns becomea more interesting when using different sounds and samples.

// SLiCE is my own Live Coding Environment, that provides a simplified framework for pattern interaction by adding useful default values and a streamlined SynthDef factory. In practice, this means more sonic possibilities.

// SLiCE automatically boots the sound server when launched. It also loads a set of default sounds.
// Run the following line to boot it and store it into the variable l:
l = SLiCE();
l.bpm(126)

// now run this pattern
(
Pdef(\a,
	Pbind(
		\sound, \pulse,
		\ctranspose, Prand([-12, 0, 12], inf),
		\note, Pseq([0, 3, 5, -2, 10], inf),
		\amp, Pwhite(0.1, 0.3),
		\dur, Prand([0.5, 0.25, 0.125], inf),
		\reverb, 0.5
	)
).play;
)
Pdef(\a).stop;

// Check the currently available sounds:
l.listSounds; // try the other sounds in the pattern above

// SLiCE can also play samples. Add a folder of soundfiles (WAV or AIF files supported) like this:
l.addSound(nil, "/Users/mattpete/Dropbox/work/akademia/TEKNO-liveCodingWorkshop/liveCodingWorkshop/liveCodingSounds/"); // change the path to the folder

// Check the currently available sounds again
l.listSounds; // try some of the newly added sounds in the pattern below

// also note the added delay
(
Pdef(\b,
	Pbind(
		\sound, Prand([\kickme, \chh, \ohh, \chh], inf),
		\note, Pseq([0, 3, 5, 7, 2, -1, 12], inf),
		\amp, Pseq([0.3, 0.2, 0.1, 0.05], inf),
		\ctranspose, 12,
		\legato, 0.8,
		\dur, 0.25,
		\delay, 0,
		\delTime, 1/3,
		\reverb, 0.1,
		\prob, 0.8
	)
).play(quant: 4); // quant is a way to keep different patterns in sync
)
Pdef(\b).stop



// sounds can also be synth functions
(
l.addSound(\blip, {|freq| // NOTE: the \note in the pattern will be converted to frequency!
	var sig;
	sig = Blip.ar(freq, \numHarm.kr(9));
});
)

// a pattern using the newly added sound. Also check out some of the new parameters below.
// \pan, \legato, \lpf, \vibrato, \vibRate, \saturation
(
Pdef(\e,
	Pbind(
		\sound, \blip,
		\note, Prand([0, 3, 5, 8, 10], inf),
		\numHarm, Pwhite(1, 10),
		\pan, Pwhite(-0.5, 0.5),
		\dur, 0.25,
		\legato, 0.3,
		\lpf, Pseg(Pwhite(180.0, 1800.0), Pwhite(4, 8), \exp, inf),
		\reverb, 0.9,
		\vibrato, 6,
		\vibRate, 0.5,
		\saturation, 3,
		\amp, Pwhite(0.1, 0.3)
	)
).play(quant: 4);
)
Pdef(\e).stop;

// Check the help for SLiCE for more parameters and info!