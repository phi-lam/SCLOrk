
~samplesFolder = "/home/sclork/Music/JJPS/Samples";
"JJPS_Load_Synth_and_Samples.scd".loadRelative;

(
~timeClient = SCLOrkTimeClient.new;
~clock = SCLOrkClock.new(~timeClient); // THIS NOW SURVIVES CTRL+PERIOD
)

a = ~mySamples.at('Eilish_Remix').play;
a.free;

(
SCLOrkPD.new(
	playerNumber: 10   , // put your player number here
	presetSearchDir: "/home/sclork/Music/JJPS/",
	orderByYear: false // false=alphabetical order of presets; true=display reference years
)
)