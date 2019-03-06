SCLOrkChat.new("phi");
(
// press A button to make sound
Ndef(\a).fadeTime = 1;
Ndef(\a, {
	var snd, snd1, snd1Round, snda, snd2, snd2Round, sndb;

	snd1 = LFSaw.ar(
		freq: ~wiiX.kr.range(20, 1600).lag(1),
		mul: ~wiiA.kr() * ~wiiY.kr.range(0, 1).lag(1)
	);

	snd1Round = LFSaw.ar(
		freq: ~wiiX.kr.range(20, 1600).round(),
		mul: ~wiiA.kr() * ~wiiY.kr.range(0, 1).lag(1)
	);

/*	snda = SelectX.kr(
		which: ~wiiB.kr.range(0, 1),
		array: [ snd1, snd1Round]
	);*/

/*	snd1 = ~wiiA.kr() * snd1;
	snd2 = SinOsc.ar(
		freq: 43 * ~wiiX.kr.range(1, 1000).lag(1),
		mul: ~wii1.kr() * ~wiiY.kr.range(0, 1).lag(1)
	);

	snd2Round = SinOsc.ar(
		freq: 43 * ~wiiX.kr.range(1, 1000).lag(1).round(),
		mul: ~wii1.kr() * ~wiiY.kr.range(0, 1).lag(1)
	);

	snd2 = SelectX.kr(
		which: ~wiiB.kr.range(0, 1).lag(1),
		array: [ snd2, snd2Round ]
	);

	snd2 = ~wii1.kr() * snd2;*/

	snda = Mix.ar(snda);
	snda = Limiter.ar(snda);
}).play;
)

