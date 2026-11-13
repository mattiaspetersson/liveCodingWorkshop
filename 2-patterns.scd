// PATTERNS

// Boot the server by running the line below:
s.boot;

// Run the code block below by placing the cursor somewhere inside the parentheses
// and press cmd+return (Mac) or ctrl+return (PC).
(
p = Pbind(
	\note, Pseq([0, 3, 5, -1], inf),
	\dur, 0.5
).play;
)
// stop the pattern by running:
p.stop;

// Try different values in the Pbind and re-run it.

// Patterns are a nicer and more flexible way of playing and interacting with synths.
// There are 2 basic types of patterns in SC:
// • Event patterns - generates musical Events comprised of key/value pairs, for example (\note, 3, \dur, 0.25).
// • Value patterns - generates simple values. Commonly used to set values for specific keys in Event Patterns.

// A single Event can be constructed like this:
e = (note: 0, dur: 2);
e.play; // it can also be played! Try changing the values in the event and play it again.

// Note that the Post window posts quite a lot of other parameters that was already there!



// Some value pattern examples:
p = Pseq([0, 1, 2], 3); // a value pattern that holds a sequence of numbers that should be repeated 3 times.
x = p.asStream; // convert the pattern to a stream (a list) of values that could be retrieved by calling next.
x.next; // run this line repeatedly and watch the post window

// a value pattern that selects a random element from the list 3 times
p = Prand([0, 1, 2], 3).asStream;
p.next; // run this line repeatedly and watch the post window

// a value pattern that shuffles a sequence of numbers and repeats it 3 times
p = Pshuf([0, 1, 2], 3).asStream;
p.next; // run this line repeatedly and watch the post window

// a value pattern that generates a random value between the low and the high value
p = Pwhite(0.0, 1.0).asStream;
p.next; // run this line repeatedly and watch the post window




// Pbind combines several key/value pairs into one stream of Events.
// It binds (or maps) different keys to the specified values.
// And those values are either simple numbers or value patterns.
(
p = Pbind(
	\note, 5,
	\dur, 0.25 // the \dur key relates to TempoClock.default. A value of 1 equals a quarter note.
).play; // when you tell a Pbind to play it returns an EventStreamPlayer.
)
p.stop;
// The EventStreamPlayer calls .next on each value pattern in the Pbind, setting values for an event. Then it waits the specified \dur and continues with the next values.




// When live coding, Pdef is useful, because it makes it possible to re-evaluate patterns on the fly, without having to stop them first, and to refer to them by an arbitrary name.
(
Pdef(\a,
	Pbind(
		\ctranspose, Prand([-12, 0, 12], inf),
		\note, Pseq([0, 1, [4, 6, 8], 3, -2], inf),
		\amp, Pwhite(0.1, 0.3),
		\dur, Prand([0.5, 0.25, 0.125], inf)
	)
).play;
)
Pdef(\a).stop;