// =====================
// SAVE AS
// Save this file with your own name appended
// ex. PD_Start_Here_Bruno.scd
// (same folder)
// =====================

SCLOrkChat.new(\phi);
// =========================================
// Adjust the path to your samples folder
// =========================================

~samplesFolder = "/home/sclork/Music/Samples/CopyrightSamples";
//~samplesFolder = "/Users/Phi/Music/Samples/SCLOrk Samples/CopyrightSamples";

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
// BOTH will survive Ctrl+period
~timeClient = SCLOrkTimeClient.new;
~clock = SCLOrkClock.new(~timeClient); // UPDATE: THIS NOW SURVIVES CTRL+PERIOD
*/
// ========================================
// PRINT THE BEATS IF YOU WANT TO SEE THEM
// ========================================
// If you hit Ctrl+period, you have to run this again to see the beats
//~clock.play({ "server beats: %".format(~clock.beats).postln; ^1 });

// IF WORKING AT HOME, use a local clock instead of the above clock:
~clock = TempoClock(60/60).permanent_(true);



// =====================
// BRIEF EXPLANATION
// =====================

// Open one of my Presets file template, save as with your own name and numbering, and start composing from there.

// The goal is for you to compose one musical loop using a minimum of 4 and a maximum of 8 Pbindefs that run simultaneously.

// I'm calling each of these pre-composed loops as "presets". You will compose one or more "presets" that we can use as backbone of our Public Domain piece. Feel free to create more than one preset and submit to me.

// The best presets will be used to structure the final composition.

// Save each of your presets as a separate file, like "PD_Preset_Bruno-1.scd", "PD_Preset_Bruno-2.scd", etc.

// Each Pbindef plays a "part", much like an orchestral or choral part. So Pbindef(\p1) is player 1, Pbindef(\p2) is player 2, etc. Eventually these Pbindefs will be playing by real individual players in SCLOrk. As you compose, you play them all together in this file to check results. But keep in mind final goal (in a future week) will be to distribute the Pbindefs you create to separate SCLOrk players.

// Change anything other parameter you want, but keep \dur always as 1/8. If you have a very specific need for a triplet, let me know and I'll help you. But a lot of great patterns can be created just with the 1/8 duration, and messing with the amp grid (the list of 0's and 1's).

// You could have all your players using the same sample, or all using different samples, and you can control which portion of the sample is used, etc. Try to keep at least one of the samples in a very recognizable state -- can the audience tell what is one of the songs playing? We want that to happen at least some of the time.

// Refer to the samples folder to see what samples are available. You just need to use the year plus the letter to refer to them inside the Pbindef (for example, '1990A', '1968A', etc). Note it must be inside single quotes.

// ===============
// COMPOSE!
// Here are a bunch of Pbindefs.
// Modify them as you want to create an awesome sequence
// The best sequences will be used as "presets" in the final piece
// PS. If you are done creating one polyphonic sequence and wants to move on and create another one, simply SAVE AS this file with a new name, and go ahead modifying the Pbindefs again.
// ===============



// ================
// PRESET PHI-2004
// ================
// Scroll all the way down for additional TOOLS for quick start, stop, clear the Pbindefs

// IF WORKING AT HOME, use a local clock instead of the above clock:
~clock = TempoClock(60/60).permanent_(true);

(

Pbindef(\p1,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('1995C'), // Gangster's Paradise Downbeat
	\dur, 1/8,
	\rate, 120/80, //124/124,
	\startPos, 0.253, // 1) Downbeat = 0.253, 2) "We keep spending"
	\att, 0.01,
	\rel, 0.75, //Pwhite(0.9, 3),
	\amp, /*0.4,*/ Pseq([
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
	\bufnum, ~mySamples.at('2016A'), //Usher Yeah
	\dur, 1/4,
	\rate, 248/124, //Pseq([1, 1.5, 2, 2.5], inf),
	\startPos, Prand([0.69, 0.7, 0.87], inf), //Pseq([0.2, 0.199], inf),
	\att, 0.1,
	\rel, Pwhite(0.3, 0.6),
	\amp, /*0.4,*/ Pseq([
		1, 0, 0, 1,   0, 0, 0, 0, // beat 1
		0, 0, 0, 0,   1, 0, 1, 0, // beat 2
		1, 0, 0, 1,   0, 1, 0, 0, // beat 3
		0, 0, 0, 1,   1, 0, 1, 0, // beat 4
	], inf) * 0.5,
).play(~clock, quant: 4).quant = 4;
)

(
Pbindef(\p3,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('2003A'), // 50 Cent In da club String hits
	\dur, 1/2,
	\rate, 1, //Pseq([1, 1.5, 2, 2.5], inf),
	\startPos, Pseq([0.1, 0.197], inf),
	\att, 0.0,
	\rel, 0.5,
	\amp, 1
).play(~clock, quant: 4).quant = 4;
)

/*
// 50-cent swing beat
(
Pbindef(\p3,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('2003A'), // 50 Cent In da club String hits
	\dur, 1/2,
	\rate, 1, //Pseq([1, 1.5, 2, 2.5], inf),
	\startPos, Pseq([0.1, 0.197], inf),
	\att, 0.0,
	\rel, 0.5,
	\amp, 1
).play(~clock, quant: 4).quant = 4;
)
*/


/* Shape of You freaky polyphony
(
Pbindef(\p1,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('2017A'),
	\dur, 4,
	\rate, 0.625, //124/124,
	\startPos, 0, //Pseq([0.2, 0.199], inf),
	\att, 0.01,
	\rel, 40, //Pwhite(0.9, 3),
	\amp, 1
).play(~clock, quant: 4).quant = 4;
) */

//Pbindef(\p1).pause;
//Pbindef(\p1).resume;

/* SAVE: LOVE YOURSELF SNIPPET
(
Pbindef(\p2,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('2016A'),
	\dur, 1/4,
	\rate, 248/124, //Pseq([1, 1.5, 2, 2.5], inf),
	\startPos, Prand([0.69, 0.7, 0.87], inf), //Pseq([0.2, 0.199], inf),
	\att, 0.1,
	\rel, Pwhite(0.3, 0.6),
	\amp, /*0.4,*/ Pseq([
		1, 0, 0, 1,   0, 0, 0, 0, // beat 1
		0, 0, 0, 0,   1, 0, 1, 0, // beat 2
		1, 0, 0, 1,   0, 1, 0, 0, // beat 3
		0, 0, 0, 1,   1, 0, 1, 0, // beat 4
	], inf) * 0.8,
).play(~clock, quant: 4).quant = 4;
) */



/*(
Pbindef(\p2,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('1982A'),
	\dur, 1/8,
	\rate, 120/124, //Pseq([1, 1.5, 2, 2.5], inf),
	\startPos, Prand([0.69, 0.7, 0.87], inf), //Pseq([0.2, 0.199], inf),
	\att, 0.1,
	\rel, Pwhite(0.3, 0.6),
	\amp, Pseq([
		1, 0, 0, 0,   0, 0, 0, 0, // beat 1
		0, 0, 0, 0,   0, 0, 1, 0, // beat 2
		0, 0, 0, 0,   0, 0, 0, 0, // beat 3
		0, 0, 0, 0,   1, 0, 1, 0, // beat 4
	], inf) * 0.8,
).play(~clock, quant: 4).quant = 4;
)*/

Pbindef(\p4,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('1976A'),
	\dur, 1/8,
	\rate, 1.18 * Pwrand([1, 6/5], [0.9, 0.1], inf), //Pseq([1, 1.5, 2, 2.5], inf),
	\startPos, 0.4, //Pseq([0.2, 0.199], inf),
	\att, 0.1,
	\rel, Prand([0.1, 1], inf) * 1,
	\amp, Pseq([
		1, 0, 0, 0,   0, 0, 0, 0, // beat 1
		1, 0, 0, 0,   0, 0, 0, 1, // beat 2
		1, 1, 0, 0,   0, 0, 0, 0, // beat 3
		0, 0, 0, 0,   1, 0, 1, 0, // beat 4
	], inf) * 0.7,
).play(~clock, quant: 4).quant = 4;


Pbindef(\p5,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('1982A'),
	\dur, 1/8,
	\rate, 120/124 * 2, //Pseq([1, 1.5, 2, 2.5], inf),
	\startPos, Pn(Pseries(0, 0.1, 10), inf), //Pseq([0.2, 0.199], inf),
	\att, 0.01,
	\rel, 0.3,
	\amp, Pseq([
		0, 1, 0, 0,   0, 0, 0, 0, // beat 1
		0, 0, 0, 0,   0, 0, 0, 1, // beat 2
		0, 0, 1, 0,   0, 0, 0, 0, // beat 3
		0, 0, 0, 0,   1, 0, 0, 0, // beat 4
	], inf) * 0.5,
).play(~clock, quant: 4).quant = 4;


Pbindef(\p6,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('1994A'),
	\dur, 1/8,
	\rate, 0.95,
	\startPos, 0.8, //Pseq([0.2, 0.199], inf),
	\att, 0.1,
	\rel, 0.1,
	\amp, Pseq([
		0, 0, 0, 0,   0, 0, 0, 0, // beat 1
		0, 0, 0, 0,   0, 0, 0, 0, // beat 2
		1, 1, 0, 0,   0, 0, 0, 0, // beat 3
		0, 0, 0, 0,   0, 0, 1, 0, // beat 4
		0, 0, 0, 0,   0, 0, 0, 0, // beat 1
		0, 0, 0, 0,   0, 0, 0, 0, // beat 2
		1, 0, 0, 0,   0, 0, 0, 0, // beat 3
		0, 0, 0, 0,   1, 0, 1, 0, // beat 4
	], inf),
).play(~clock, quant: 4).quant = 4;

Pbindef(\p7,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('1983B'),
	\dur, 1/8, //Prand([1/4, Rest(1/4)], inf),
	\rate, 1.35, //Pseq([1, 1.5, 2, 2.5], inf),
	\startPos, 0.8, //Pseq([0.2, 0.199], inf),
	\att, 0.01,
	\rel, 0.1,
	\amp, Pseq([
		0, 0, 0, 0,   0, 0, 0, 0, // beat 1
		0, 0, 0, 0,   0, 0, 0, 0, // beat 2
		0, 0, 0, 0,   0, 0, 0, 0, // beat 3
		0, 0, 0, 0,   1, 0, 1, 1, // beat 4
	], inf),
).play(~clock, quant: 4).quant = 4;


Pbindef(\p8,
	\instrument, "playBuf",
	\bufnum, ~mySamples.at('1976A'),
	\dur, 1/8, //Prand([1/4, Rest(1/4)], inf),
	\rate, 2, //Pseq([1, 1.5, 2, 2.5], inf),
	\startPos, 0.2, //Pseq([0.2, 0.199], inf),
	\att, 0.1,
	\rel, Pwhite(0.1, 0.2),
	\amp, Pseq([
		0, 0, 0, 0,   0, 0, 0, 0, // beat 1
		0, 0, 0, 0,   0, 0, 0, 0, // beat 2
		0, 0, 0, 0,   0, 0, 0, 0, // beat 3
		0, 0, 0, 0,   1, 1, 1, 0, // beat 4
	], inf),
).play(~clock, quant: 4).quant = 4;
)



// TOOLS

// uncomment the whole thing by deleting the /* in the beginning of this line
// Pause all Pbindefs:
Pbindef.all.do{|i| i.pause };

// Resume all:
Pbindef.all.do{|i| i.resume };

// If everything is broken:
Pbindef.all.do({ |i| i.clear });

// Pause / resume individual Pbindefs:
Pbindef(\p1).pause;
Pbindef(\p2).pause;
Pbindef(\p3).pause;
Pbindef(\p4).pause;
Pbindef(\p5).pause;
Pbindef(\p6).pause;
Pbindef(\p7).pause;
Pbindef(\p8).pause;

Pbindef(\p1).resume;
Pbindef(\p2).resume;
Pbindef(\p3).resume;
Pbindef(\p4).resume;
Pbindef(\p5).resume;
Pbindef(\p6).resume;
Pbindef(\p7).resume;
Pbindef(\p8).resume;


