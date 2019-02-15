//=================
// LOAD SAMPLES
// LOAD SYNTHDEF
// (all in a single block)
// ================

s.waitForBoot({

	Buffer.freeAll;

	~mySamples = Dictionary.new(100);

	// copied from wslib to avoid installing the Quark
	~asNumberIfPossible = { arg string;
		var couldBeNumber = string.every({ |item, i|
			((item.isDecDigit) or: (item == $.))
			or: ((item == $-) && (i == 0))
		});

		if(couldBeNumber && (string != "-") )
		{string.interpret} {string}
	};


	// Dictionary will be populated with buffers
	// Dictionary keys will be first 5 characters of file name, which in this case are always something like 1978A, 1956B, etc.
	// So code below looks for FIRST NUMBER in the path string.
	// LIMITATION: no other previous part of the path should contain numbers (in other words, you can't have a path like /home/sclork/Music45/samples/... as this code would wrongly think 45 is the beginning of file name).

	(~samplesFolder++"/*.wav").resolveRelative.pathMatch.do({ arg path;
		var index = 0;
		var key, value;

		path.postln;

		// find first number in path (hopefully first character of file name, which begins with year)
		while(
			{ ~asNumberIfPossible.value(path[index].asString).isNumber.not },
			{ index = index + 1 }
		);

		key = path[index..(index+4)].asSymbol;
		value = Buffer.readChannel(s, path, channels: [0]);

		s.sync;

		~mySamples.put(key, value);

	});

	// SynthDef

	SynthDef("playBuf", {arg amp=1, rate=1, att=0.01, rel=0.1, bufnum=0, startPos=0, crv = -4;
		var snd, env;
		env = Env.perc(attackTime: att, releaseTime: rel, level: amp, curve: crv).kr(2);
		snd = PlayBuf.ar(
			numChannels: 1,
			bufnum: bufnum,
			rate: rate * BufRateScale.kr(bufnum),
			startPos: startPos * BufSamples.kr(bufnum)
		);
		Out.ar(0, snd*env)
	}).add;

	SynthDef("playBufASR", {arg amp=1, rate=1, att=0.01, rel=0.1, bufnum=0, startPos=0, gate=1;
		var snd, env;
		env = Env.asr(attackTime: att, sustainLevel: amp, releaseTime: rel).kr(doneAction: 2, gate: gate);
		snd = PlayBuf.ar(
			numChannels: 1,
			bufnum: bufnum,
			rate: rate * BufRateScale.kr(bufnum),
			startPos: startPos * BufSamples.kr(bufnum)
		);
		Out.ar(0, snd*env)
	}).add;

SynthDef("distortion", {arg amp = 1, rate=1, att=0.01, rel=0.1, bufnum=0, startPos=0, crv = -4, dist = 1, filter = 8000, gate = 1;
	var snd, env, clip;
	env = Env.asr(attackTime: att, sustainLevel: amp, releaseTime: rel).kr(doneAction: 2, gate: gate);
	snd = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: startPos * BufSamples.kr(bufnum)
	);
	clip = LPF.ar(Clip.ar(snd, (dist - 1), (1 - dist)), filter, (1/(1-dist)));
	Out.ar(0, clip * env)
}).add;

SynthDef("shoegaze", {arg amp = 1, rate=1, att=0.01, rel=0.1, bufnum=0, startPos=0, dist = 1, filter = 8000, gate = 1, mix = 0.5, depth = 0.5;
	var snd, env, clip, verb;
	env = Env.asr(attackTime: att, sustainLevel: amp, releaseTime: rel).kr(doneAction: 2, gate: gate);
	snd = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: startPos * BufSamples.kr(bufnum)
	);
	clip = LPF.ar(Clip.ar(snd, (dist - 1), (1 - dist)), filter, (env/(1-dist)));
	verb = FreeVerb.ar(clip, mix, depth, 0);
	Out.ar(0, verb)
}).add;

SynthDef("wheniwasolder", {arg amp = 1, rate=1, att=0.01, rel=0.1, bufnum=0, startPos=0, tremolo = 1/3, width = 0.5, limit = 0, gate = 1, mix = 0.5, depth = 0.5;
	var snd, env, trem, verb;
	env = Env.asr(attackTime: att, sustainLevel: amp, releaseTime: rel).kr(doneAction: 2, gate: gate);
	snd = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: startPos * BufSamples.kr(bufnum)
	);
	trem = snd * env * Pulse.ar(tremolo, width).range(limit, 1);
	verb = FreeVerb.ar(trem, mix, depth, 0.6);
	Out.ar(0, verb)
}).add;

SynthDef("springVerb1", {arg amp=1, rate=1, att=0.01, rel=0.1, bufnum=0, startPos=0, crv = -4, notch = 1000, filterdecay = 0.1, springdelay = 0.075, springdecay = 1, mix = 0.5, springsize = 0.75, damp = 0.5, bouncerate = 5, bouncedepth = 1.1;
	var snd, env, bounce, filter, delay, verb;
	env = Env.perc(attackTime: att, releaseTime: rel, level: amp, curve: crv).kr(2);
	snd = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: startPos * BufSamples.kr(bufnum)
	);
	bounce = SinOsc.kr(bouncerate).range(1/bouncedepth, bouncedepth);
	filter = CombN.ar(snd, 0.01, 1/notch, filterdecay, env);
	delay = CombC.ar(filter, 0.2, springdelay * bounce, springdecay);
	verb = (FreeVerb.ar(delay, 1, springsize, damp) * mix) + (snd * env * 1 - mix);
	Out.ar(0, verb * env)
}).add;

SynthDef("springVerbASR1", {arg amp=1, rate=1, att=0.01, rel=0.1, bufnum=0, startPos=0, crv = -4, notch = 1000, filterdecay = 0.1, springdelay = 0.075, springdecay = 1, mix = 0.5, springsize = 0.75, damp = 0.5, bouncerate = 5, bouncedepth = 1.1, gate = 1;
	var snd, env, bounce, filter, delay, verb;
	env = Env.asr(attackTime: att, sustainLevel: amp, releaseTime: rel).kr(doneAction: 2, gate: gate);
	snd = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: startPos * BufSamples.kr(bufnum)
	);
	bounce = SinOsc.kr(bouncerate).range(1/bouncedepth, bouncedepth);
	filter = CombN.ar(snd, 0.01, 1/notch, filterdecay, env);
	delay = CombC.ar(filter, 0.2, springdelay * bounce, springdecay);
	verb = (FreeVerb.ar(delay, 1, springsize, damp) * mix) + (snd * env * 1 - mix);
	Out.ar(0, verb * env)
}).add;

SynthDef("shimmerVerb1", {arg amp=1, rate=1, att=0.01, rel=0.1, bufnum=0, startPos=0, crv = -4, octavemix = 0.5, delay = 0.075, feedback = 0.1, mix = 0.5, size = 0.75, damp = 0.5, bouncerate = 5, bouncedepth = 1.1;
	var snd, env, bounce, send, oct, shimmer, verb;
	env = Env.perc(attackTime: att, releaseTime: rel, level: amp, curve: crv).kr(2);
	snd = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: startPos * BufSamples.kr(bufnum)
	);
	oct = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: rate * 2 * BufRateScale.kr(bufnum),
		startPos: startPos * BufSamples.kr(bufnum)
	);
	bounce = SinOsc.kr(bouncerate).range(1/bouncedepth, bouncedepth);
	shimmer = CombN.ar(oct * env, 0.2, delay, feedback);
	verb = (FreeVerb.ar(shimmer, 1, size, damp) * octavemix) +
	(FreeVerb.ar(snd * env, 1, size, damp) * (1 - octavemix));
	send = (verb * mix) + (snd * env * (1-mix));
	Out.ar(0, send)
}).add;

SynthDef("shimmerVerbASR1", {arg amp=1, rate=1, att=0.01, rel=0.1, bufnum=0, startPos=0, gate = 1, octavemix = 0.5, delay = 0.075, feedback = 0.1, mix = 0.5, size = 0.75, damp = 0.5, bouncerate = 5, bouncedepth = 1.1;
	var snd, env, bounce, send, oct, shimmer, verb;
	env = Env.asr(attackTime: att, sustainLevel: amp, releaseTime: rel).kr(doneAction: 2, gate: gate);
	snd = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: startPos * BufSamples.kr(bufnum)
	);
	oct = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: rate * 2 * BufRateScale.kr(bufnum),
		startPos: startPos * BufSamples.kr(bufnum)
	);
	bounce = SinOsc.kr(bouncerate).range(1/bouncedepth, bouncedepth);
	shimmer = CombN.ar(oct * env, 0.2, delay, feedback);
	verb = (FreeVerb.ar(shimmer, 1, size, damp) * octavemix) +
	(FreeVerb.ar(snd * env, 1, size, damp) * (1 - octavemix));
	send = (verb * mix) + (snd * env * (1-mix));
	Out.ar(0, send)
}).add;

SynthDef("cymbals", {arg bus = 0, amp = 0.3, att = 0.01, damp = -16, rel = 2, deptha = 50, depthb = 100, freq = 600, hfreq = 8000, q = 5;
	var osca, oscc, oscb, snd, env, filter;
	env = Env.perc(att, rel, amp, damp).kr(doneAction: 2);
	osca = WhiteNoise.ar(1).range(1/deptha, deptha);
	oscb = SinOsc.ar(freq: freq * 7.7).range(1/depthb, depthb);
	oscc = SinOsc.ar(freq: freq * 3.5).range(1/depthb, depthb);
	snd = SinOsc.ar(freq: freq * oscb, mul: env) + SinOsc.ar(freq: freq * osca, mul: env) + SinOsc.ar(freq: freq * oscc, mul: env);
	filter = LPF.ar(in: RHPF.ar(in: snd, freq: hfreq, rq: 1/q), freq: hfreq * 8) + RHPF.ar(in: snd, freq: hfreq, rq: 1/q);
	Out.ar(bus, Mix.ar(filter, 0));
}).add;

SynthDef("snare", {arg bus = 0, amp = 0.1, head = 180, att = 0.01, rela = 0.2, relb = 0.5, relc = 0.7, rattle = 0.5, amf = 100;
	var enva, envb, envc, snda, sndb, sndc, snd;
	enva = Env.perc(att, rela, amp, -7).kr;
	envb = Env.perc(att, relb, amp/2.5, -7).kr;
	envc = Env.perc(att, relc, amp/17, -8).kr(doneAction: 2);
	snda = LPF.ar(LFTri.ar(freq: [head, head * 2.5], mul: enva), 300);
	sndb = GrayNoise.ar(envb * (Pulse.ar(freq: (head / [1.5, 2]), width: rattle).range(0, amp)));
	sndc = LPF.ar(ClipNoise.ar(envc * BrownNoise.ar(1).range(0, 1)), 12000);
	snd = HPF.ar((snda + sndb + sndc), head/1.3);
	Out.ar(bus, Mix.ar(snd, 0));
}).add;

SynthDef("bassdrum", {arg bus = 0, amp = 0.3, freqa = 50, freqb = 67, att = 0.01, rel = 0.45;
	var env, envp, click, snd, wood;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	envp = Env.perc((att + rel) * 0.35, (att + rel) * 0.65, amp).kr(doneAction: 2);
	click = LPF.ar(BrownNoise.ar(mul: Env.perc(att, 0.05, amp).kr), 225);
	wood = BPF.ar(GrayNoise.ar(mul: Env.perc(att, 0.03, amp * SinOsc.ar(freqa * 2).range(0.3, 1)).kr), freqa * 8, 1/10);
	snd = SinOsc.ar(freq: (envp.range(freqa, freqb) * [1, 2, 3]), mul: env * [1, 0.1, 0.05]) + click + (wood * 0.7);
	Out.ar(bus, Mix.ar(snd));
}).add;

SynthDef("noisefloor", {arg bus = 0, amp = 0.3;
	var noise, wind, rain, mix;
	noise = GrayNoise.ar(0.025) + PinkNoise.ar(0.05);
	wind = BPF.ar(BrownNoise.ar(0.06), LFNoise2.kr(1/2).range(120, 3000), 1/7);
	rain = LPF.ar(Dust2.ar(7, 0.75), 7500);
	mix = noise + wind + rain;
	Out.ar(bus, Splay.ar(mix));
}).add;
}); // end of waitForBoot
