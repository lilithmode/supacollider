# hi
### ok let's break this down, i had wanted / planned on making something that created a bit of a jittery random drum vibe for this patch
### i had also wanted to do something foodman-esque / idm adjacent, and what better way to do that by completely ditching control for the drums, and only controlling a texture

## here's the script:
### drums:

```
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
```

### a lot of the drums are synthesized off of things i found off the forum in order to implement them and have them sound "feasible" to me
### i don't really care about realism in these drums, so a lot of these are just variables with stacks of things that are being modeled through some effects
### to be quite honest, i don't really know what most of these do but it seems to work with the drum sound design. i do notice however that changing the numbers on the SinOsc lines for each drum seems to change it pretty drastically, so i put a couple of notes there saying that the player can mess around with those with no problem :3
### besides that it was a lot of copy and paste, trial and error until i got the sounds the way that i wanted to right. i did this so much that i forgot to do documentation for my OTHER live coding class. funny how the world works and i'm sure the consequences of my actions will catch up to me this thursday (i'm writing this during thanksgiving)

### anyways, here's the kicker: the SKITTERS

```
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
```

### i named it dirty because that's all it did me. i think that makes sense. whatever
### my goal with this was to make something slightly more interactive using the mouse options that we learned from the beginning - i didn't want to spice it up with guis because frankly i don't have the mental health for that at the moment. maybe i'll do it over break !
### regardless here's how it functions

### MouseX -  density control of random trigger effects. left means sparse, while right is dense
### Dust2 essentially makes random bipolar trigger impulses. for the trigger
### var step / freq is run by TIRand -> the freq is being converted from step.midicps after it gets put to Hz
#### then, the LFNoise1 randomly scales the pitch to make something more unstable the more it stays out
### Decay2 and the var click the clicky textures you hear when you bring your mouse up and to the right
### some other random layers that i honestly just glued together such as the Pulse.ar, the Hasher.ar scrambler, and then mapping the output amplitude to the MouseY value.

#### i'm so tired but i'm pretty happy with this :3 i can't wait to experiment more by myself