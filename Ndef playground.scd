/* NDef Playground */

/* Ideas:
      1) 808 bass using SinOsc to gliss to a note
      2) Multiple NDefs turning on and off for Map of the Problematique effect



LFPulse: changing note with LFPulse chooses top and bottom note

Line: single ramp, then stop on final

MouseX and MouseY, round to snap to notes

*/

// Example 3: one LFPulse controlling harmonic, another controlling mul

Ndef(\a).fadeTime = 11; // run this, then go back to the block of code above and do more changes.

(
Ndef(\a, {
	var harmonic, snd;
	// round numbers to ensure integers only:
	harmonic = LFPulse.ar(3).range(3, 13).round(1);
	snd = SinOsc.ar(
		freq: 43 * harmonic,
		mul: LFPulse.ar(2).range(0.1, 0.3)
	);
	snd = Limiter.ar(Mix.ar(snd)); // don't change this line
}).play;
)

/* CURRENT TEST */

(
Ndef(\a, {
	var harmonic, snd;
	// round numbers to ensure integers only:
	harmonic = MouseX.kr(1, 16).round(1) * LFPulse.ar(43).range(1,7).round(1);
	//harmonic = MouseX.kr(2, 3).round(1) * LFPulse.ar(8);


	snd = LFTri.ar(
		freq: 43 * harmonic,
		mul: MouseY.kr(0, 0.5)
	);
	snd = snd * LFPulse.ar(0.33, 0, 0.2);
	snd = Limiter.ar(Mix.ar(snd));
}).play;
)


/**** SAVE ****
****
***/

(
Ndef(\a, {
	var harmonic, snd;
	// round numbers to ensure integers only:
	harmonic = MouseX.kr(1, 16).round(1) * LFPulse.ar(43).range(1,7).round(1);
	//harmonic = MouseX.kr(2, 3).round(1) * LFPulse.ar(8);


	snd = LFTri.ar(
		freq: 43 * harmonic,
		mul: MouseY.kr(0, 0.5)
	);
	snd = snd * LFPulse.ar(1);
	snd = Limiter.ar(Mix.ar(snd));
}).play;
)




// Piano C3 = 130.812

// ++ code copied from bruno
(
Ndef(\a, {
	var harmonic, snd;
	harmonic = 2.5;
	snd = LFTri.ar(
		freq: 43 * harmonic,
		mul: SinOsc.ar(1/10).range(0.0, 0.5)
	);
	snd = Limiter.ar(Mix.ar(snd)); // don't change this line
}).play;
)
// -- end of copied code

// ++ code copied from miles
(
Ndef(\a, {
	var harmonic, snd;
	harmonic = MouseX.kr(2, 16).round(1);
	//harmonic = 1; // change this number, anything between 1 to 32, then control + enter
	snd = LFPulse.ar(
		freq: 43 * harmonic * LFTri.ar(1).range(1, 3).round(1),
		mul: LFSaw.ar(1).range(1, 0.4) // you can also change the volume here
	);
	snd = Limiter.ar(Mix.ar(snd)); // don't change this line
}).play;
)
// -- end of copied code

// ++ code copied from josh
(
Ndef(\a, {
	var harmonic, snd;
	harmonic = 16 * LFNoise2.kr(1).range(1.1, 0.9);
	snd = RLPF.ar(GrayNoise.ar(1), LFNoise2.kr(1/3).range(100, 10000), 1/5);
	snd = Limiter.ar(Mix.ar(snd)); // don't change this line
}).play;
)
// -- end of copied code

// ++ code copied from bruno
(
Ndef(\a, {
	var harmonic, snd;
	harmonic = rrand(1, 8) * [1, 1.001];
	snd = SinOsc.ar(
		freq: 43 * harmonic,
		mul: SinOsc.ar(1/10).range(0.0, 0.5)
	);
	snd = Limiter.ar(Mix.ar(snd)); // don't change this line
}).play;
)
// -- end of copied code

// ++ code copied from davMo
(
Ndef(\a, {
	var harmonic, snd;
	// try out LFNoise1 and LFNoise2 as well:
	harmonic = LFNoise0.kr(LFNoise0.kr(7).range(2, 19).round(1)).range(2,10).round(1); // two harmonics at same time
	snd = Pulse.ar(
		freq: [43 * harmonic, 43* harmonic/2, 43*harmonic/4],
		mul: 0.4
	);
	snd = Limiter.ar(Mix.ar(snd));
}).play;
)
// -- end of copied code

// ++ JOSH BIRDS
snd = snd * LFPulse.ar(SinOsc.kr(1/3).range(3, 17), 0, 0.1);
// -- end of copied code
