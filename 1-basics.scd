// 1. DOWNLOAD INSTALLERS --------------------------------------------

// Go here: https://supercollider.github.io/downloads
// Download the following:
// • SuperCollider (select the latest version for your system, by clicking on the corresponding tab).
// • SC3Plugins on the same page.

// Now go here: https://github.com/mattiaspetersson/slice
// Click the green button, labelled '<>Code', and select Download ZIP.

// Install SuperCollider! (leave the other files for now)
// -------------------------------------------------------------------










// 2. WHAT IS PROGRAMMING?
// - The practice usually involves writing code.
// - This code follows a specific syntax (grammar) depending on the language.
// - The code makes up a set of instructions for the computer on how to behave in certain situations.
// - Programming languages can be either compiled or interpreted.
// - In compiled languages the human readable code is compiled into machine code.
// - This results in a binary file, separate from the source code, that can be run on specific systems (Win, Mac).
// - In interpreted languages, like SuperCollider, the source code is interpreted directly, line by line.
// - A special program called the Interpreter converts each line into binary form and executes it on the cpu.
// - This is what makes live coding possible!
// -------------------------------------------------------------------










// 3. FIRST TESTS ----------------------------------------------------
// Open SuperCollider! Watch the Post window.
// If the somewhat cryptic text in the post window ends with a welcome greeting, it means we're ok!

// Now check out the help browser and read through the introductory overview together.

1 + 2; // place your cursor somewhere on this line and press cmd+return (Mac), or ctrl+return (PC)

// This operation evaluated the code and posted it in the Post window.

// Now run the line below in the same way:
"hello world".postln;

// In this example, we have a string of characters, and we send it the message .postln (post line).
// As programmers, we refer to .postln as a method and in this case the String is the receiver of
// this method call.
// Note that the result was posted twice in the post window. This is because besides posting the line,
// SuperCollider always also posts the final receiver (indicated by a different color and an arrow).

// We can enclose blocks of code on several lines by enclosing them in parentheses:
(
"hello world".postln;
"i'm live coding".postln;
3 * 7;
)
// -------------------------------------------------------------------










// 4. VARIABLES -------------------------------------------------------
// To simplify the code and to be able to reuse values programmers often use variables.
// A variable is a "container" for something and has a name that the programmer decides.
// The computer needs to know about these variables and allocate memory before we can use them.
// In SC there are three types of variables:
// • Regular declared variables. These are declared with the keyword var and an arbitrary name
// at the beginning of the code.
// • Pre-declared Interpreter variables. These are the global variables a-z.
// • On-the-fly declared Environment variables. Denoted with the ~ and could also be considered
// global (unless you change your Environment).

// Regular variables needs to be declared first of all in the beginning of the code block we want to run.
// Variable declaration is written like this in SC syntax:

var midiNote; // declares a variable with an arbitrary name (note the semicolon that ends the statement!)
var hey, drum, a, x; // declares several variables at the same time (note the commas and semicolon!)
var drum = 34; // declare a variable and assign it a default value


// To put something in these variable we use the syntax:
(
var hey;
hey = 134; // the equal sign is the variable assigner.
hey.postln;
23;
)

// Scope.
// The variables you declare needs to be part of the same scope as they will be used in.
// The scope is a piece of code that you select and evaluate (run) at the same time.
// Select this code and press cmd+return (Mac) or ctrl+return (Win/Linux).

var numA, numB, numC;
numA = 7;
numB = 3;
numC = numA + numB;

// Watch the post window!
// Now try to run one line at a time with shift+return. This causes an error! Why?
// -------------------------------------------------------------------










// 5. FIRST SOUNDS ----------------------------------------------------
// To create a sound in SC you need to do 3 things:

// 5.1. Boot the Server. This is the audio engine that sends the actual sound out on our soundcard.
// Since this is done so often, SC by default has the server stored in the global variable s,
// so we only need to tell it to boot.

s; // try run this first. localhost is the name of the default server. Its ip address is 127.0.0.1.
s.boot; // now boot it. Watch the lower right corner!




// 5.2. Create a SynthDef. This could be though of as a recipe for a sounding device.
(
SynthDef.new(\firstSynth, // a SynthDef needs a name in the form of a symbol (or a string).
	{ // the curly brackets denotes a Function. This is where we create our sound.
		// declare a variable called sig. This variable is LOCAL to the function.
		var sig;
		// assign a PinkNoise generator to the sig variable.
		sig = PinkNoise.ar(0.2);
		// .ar means audio rate!
		// .kr is also possible for control rate.

		// Out defines on which channel on the soundcard the sound should play.
		Out.ar(0, sig);
	}
).add; // we also need to add the SynthDef to the (already booted) Server.
)

// same thing without the comments
(
SynthDef.new(\firstSynth, {
	var sig;
	sig = PinkNoise.ar(0.2);
	Out.ar(0, sig);
}).add;
)




// 5.3. Create a Synth. With this class you can play on the SynthDef.
x = Synth.new(\firstSynth); // start the synth named \firstSynth. Store it in variable x.
// It should make a noise in the left channel only.

x.free; // free stops the synth from playing and frees the synth node on the server.



// Another SynthDef
(
SynthDef(\secondSynth, {
	var sig;
	sig = SinOsc.ar(500, 0, 0.1); // instead of the noise: a sine wave oscillator
	Out.ar(0, sig); // play it out on channel 1 (SC always starts counting at 0!)
}).add;
)

// play it
y = Synth(\secondSynth);
y.free;

// play it together with the other one
x = Synth(\firstSynth);
y = Synth(\secondSynth);
x.free;
y.free;
// -------------------------------------------------------------------









// 6. INTERACTING WITH RUNNING SYNTHS --------------------------------
// It gets more exciting if you can interact with synths that are running.
// To do this we need to introduce the concept of arguments in functions.
// Arguments works like inputs into the function.
// They need to be declared at the very beginning of the function, before the variables:

(
SynthDef(\thirdSynth, {arg freq, amp;
	var sig;
	sig = SinOsc.ar(freq, 0, amp);
	Out.ar(1, sig);
}).add;
)

// this will start a silent synth because we didn't set the freq or amp yet.
// if we don't set arguments in a SynthDef, they will default to 0.
// IMPORTANT: AN AMPLITUDE OF 1 IS AS LOUD AS IT GETS WITHOUT DISTORTION. WATCH YOUR EARS!!!
z = Synth(\thirdSynth);
z.set(\freq, 300, \amp, 0.1); // set the 2 parameters simultaneously
z.set(\freq, 800); // change the frequency only
z.set(\amp, 0.05); // change the amplitude only
z.free;


(
// note that re-evaluating a SynthDef with the same name replaces the previous one!
SynthDef(\thirdSynth, {arg freq = 300, amp = 0.1; // we could also add default values
	var sig;
	sig = SinOsc.ar(freq, 0, amp);
	Out.ar(1, sig);
}).add;
)

// now this isn't silent anymore because of the default values.
z = Synth(\thirdSynth);
z.set(\freq, 400)
z.free;


(
// Mixing two sounds by simple addition
SynthDef(\fourthSynth, {arg freq = 300, amp = 0.1, out = 0; // added an out argument
	var sig;
	sig = SinOsc.ar(freq.lag(0.9), 0, amp) + PinkNoise.ar(0.3 * amp);
	Out.ar(out, sig);
}).add;
)

z = Synth(\fourthSynth);
z.set(\freq, 400);
z.set(\amp, 0.05); // change the amplitude only
z.set(\out, 1, \freq, 200, \amp, 0.3);

y = Synth(\fourthSynth);
y.set(\freq, 202, \amp, 0.3);
y.set(\out, 0);

z.free; y.free;