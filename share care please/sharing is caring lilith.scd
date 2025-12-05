(
// --- drumz <3 ---

SynthDef(\kick, {
	var snd;
	snd = SinOsc.ar(Env([300,70,50],[0.05,0.2]).ar); //:3 (recommended numbers i'd like to play with are 300-600)
	snd = snd + (Hasher.ar(Sweep.ar) * Env.linen(0.001,0.001,0.001).ar);
	snd = snd * Env.perc(0.001,1).ar(Done.freeSelf);
	snd = snd!2 * \amp.kr(-10.dbamp);
	Out.ar(\out.kr(0), snd);
}).add;

SynthDef(\snare, {
	var snd;
	snd = SinOsc.ar(Env([400,210,200],[0.01,0.2]).ar); //:3
	snd = snd + (BPF.ar(Hasher.ar(Sweep.ar),2034,0.3) * Env.linen(0.001,0.001,0.001).ar);
	snd = snd * Env.perc(0.001,0.3).ar(Done.freeSelf);
	snd = snd!2 * \amp.kr(-10.dbamp);
	Out.ar(\out.kr(0), snd);
}).add;

SynthDef(\hat, {
	var snd;
	snd = BPF.ar(Hasher.ar(Sweep.ar),4034,0.1) * 13.dbamp; //:3 (4000-9000 range is fun)
	snd = snd * Env.perc(0.02,0.03).ar(Done.freeSelf);
	snd = snd!2 * \amp.kr(-10.dbamp);
	Out.ar(\out.kr(0), snd);
}).add;

SynthDef(\clap, {
	var snd;
	snd = BPF.ar(Hasher.ar(Sweep.ar),1000,0.1) * 13.dbamp; //:3
	snd = snd * Env([0,1,0,1,0,1,0],[0.001,0.01,0.001,0.01,0.001,0.1]).ar(Done.freeSelf);
	snd = snd!2 * \amp.kr(-10.dbamp);
	Out.ar(\out.kr(0), snd);
}).add;

// real pro lilith tip - you can change the first snd values marked with a "//:3" on each drum in order to get different sounds / timbres from them

// just don't touch the .dbamp unless you wanna change the value

// --- skittery ---

SynthDef(\dirty,{
	var dens=MouseX.kr(5,80);
	var trg=Dust2.kr(dens);
	var step=TIRand.kr(24,84,trg);
	var freq=step.midicps*LFNoise1.kr(12).range(0.4,1.8);
	var env=Decay2.kr(trg,0.0005,TRand.kr(0.005,0.03,trg));
	var click=HPF.ar(WhiteNoise.ar(0.2),5000)*env;
	var tone=Pulse.ar(freq,0.3)*env*0.4;
	var burst=(Hasher.ar(Sweep.ar)*0.1)*env;
	var sig=(tone+burst+click)*MouseY.kr(0.1,2);
	Out.ar(0,sig!2);
}).add;

)



// --- the w1w17h drummer instruction manual ---

// the skittering noise is mouse controlled ! so :3 just move that thing around !
// the x axis controls density of the glitches, having them appear more often
// the y axis controls how present they will sound
// cmd + enter the synthdefs up top first, and then cmd + enter the routine below
// when you feel like you've had enough, cmd + . and relax

(
Routine{
	var bpm= 230;
	var beat=60/bpm;
	Synth(\dirty);
	loop{
		Synth([\kick,\snare,\hat,\clap].choose);
		(beat/2).wait;
		//fun fact, if you replace the x here with a multiple of 2 on the beat line
		//i.e: (beat/x).wait
		// it'll make it go faster

		// my personal favorite tempo to hear this at is around 170-180 bpm. go ahead and play with it
	};
}.play;
)

