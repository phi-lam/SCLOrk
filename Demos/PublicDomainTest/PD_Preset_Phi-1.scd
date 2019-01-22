// ==================================
// Preset: PHI
// Number of voices: 3
// Most recent year sampled: 2003
// Comments: Planning to have at least 5 voices with more flexibility in
//                   the ability to change parameters and have interesting sounds
// ==================================

// =========================================
// Adjust the path to your samples folder
// =========================================

//~samplesFolder = "/home/sclork/Music/CopyrightSamples";
~samplesFolder = "/Users/Phi/Music/Samples/SCLOrk Samples/CopyrightSamples";

// =============================
// Load samples and SynthDefs
// =============================

"PD_Load_Synth_and_Samples.scd".loadRelative;

// ============================
// Test if samples loaded OK
// ============================

a = ~mySamples.at('1983C').play;
b = ~mySamples.at('1956A').play;
c = ~mySamples.at('1982A').play;
a.free;
b.free;
c.free;

/* ==================================
// SCLOrkTimeClient and SCLOrkCLOck
// ==================================
// Create a new time client, and one SCLOrkCLOck
// This needs to be done ONLY ONCE after you open SuperCollider
// BOTH will survive Ctrl+period */
~timeClient = SCLOrkTimeClient.new;
~clock = SCLOrkClock.new(~timeClient); // UPDATE: THIS NOW SURVIVES CTRL+PERIOD

// ========================================
// PRINT THE BEATS IF YOU WANT TO SEE THEM
// ========================================
// If you hit Ctrl+period, you have to run this again to see the beats
~clock.play({ "server beats: %".format(~clock.beats).postln; ^1 });

// IF WORKING AT HOME, use a local clock instead of the above clock:
~clock = TempoClock(60/60).permanent_(true);

(
Pbindef(\p1,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('1995A'), // Gangster's Paradise Downbeat
	\dur, 1/8,
	\rate, 80/80,//120/80, //124/124,
	\startPos, 0.253, // 1) Downbeat = 0.253, 2) "We keep spending"
	\att, 0.01,
	\rel, 1, //0.75, Pwhite(0.9, 3),
	//\amp, 0.4,
	\amp, Pseq([
		1, 0, 0, 0,   0, 0, 1, 0, // beat 1
		0, 0, 0, 0,   0, 0, 0, 0, // beat 2
		1, 0, 0, 0,   0, 0, 0, 0, // beat 3
		1, 0, 0, 0,   0, 0, 0, 0, // beat 4
	], inf) *0.3
).play(~clock, quant: 4).quant = 4;
)

(
Pbindef(\p2,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('2003A'), // 50 Cent In da club String hits
	\dur, 1/2,
	\rate, 1, //Pseq([1, 1.5, 2, 2.5], inf),
	\startPos, Pseq([0.1, 0.197], inf),   // Rhythm A
	/*\startPos, Pseq([0.11, 0.197], inf),*/  // Rhythm B--> cool rhythm change
	\att, 0.0,
	\rel, 0.8,
	\amp, 1
).play(~clock, quant: 4).quant = 4;
)

(
Pbindef(\p3,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('2004A'), //Usher Yeah -- this sample is super loud
	\dur, 1/4, //1/4,
	\rate, Pseq([
		0.675, 0, 0, 0, 0, 0, 0, 0,    0.755, 0, 0, 0, 0, 0, 0, 0,
		0.79, 0, 0, 0, 0, 0, 0, 0,   0.755, 0, 0, 0, 0, 0, 0, 0,
	], inf), //105/105, //Pseq([1, 1.5, 2, 2.5], inf),
	\startPos, 0.69, //Prand([0.69, 0.7, 0.87], inf), //Pseq([0.2, 0.199], inf),
	\att, 0.5,
	\rel, 0.3, //Pwhite(0.3, 0.6),
	\amp, /*0.4,*/ Pseq([
		1, 0, 0, 0, 0, 0, 0, 0,  1, 0, 0, 0, 0, 0, 0, 0, // beat 1
		1, 0, 0, 0, 0, 0, 0, 0,  1, 0, 0, 0, 0, 0, 0, 0, // beat 2
		1, 0, 0, 0, 0, 0, 0, 0,  1, 0, 0, 0, 0, 0, 0, 0, // beat 3
		1, 0, 0, 0, 0, 0, 0, 0,  1, 0, 0, 0, 0, 0, 0, 0, // beat 4
	], inf) * 0.2,
).play(~clock, quant: 4).quant = 4;
)