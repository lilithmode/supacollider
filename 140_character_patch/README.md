# introducing the endless lilithcopter

#### the whole concept of this patch is that i wanted to play around with more samples / audio samples, i hope to get something funny / at least something working in terms of a beat repeat. 

#### shoutout [this website](https://supercollider.github.io/sc-140.html) for giving me the inspiration i needed for this. especially Nathanel Virgo's patch

#### the first iteration is tough. i don't know why it's not counting my file when i tried to replace certain aspects of it and modify it. it's pretty cool to scrub but i just want something a bit more rudimentary. 

```b=Buffer.read(s,"hl.wav");play{t=Impulse.kr(5);PlayBuf.ar(1,b,1,t,Demand.kr(t,0,Dseq(1e3*[103,41,162,15,141,52,124,190],4)))!2}```

#### what the heck WHY ISN'T IT FINDING MY FILE. IT'S LITERALLY THE SAME AS BEFORE AND TAKEN FROM THE REFERENCE.

#### ok according to some forum posts and asking some friends there apparently IS  a way to get this to work? so "+/+" and "thisProcess.nowExecutingPath.dirname" makes it so it finds the file locally? the only thing is that i have to modify it further. i don't want nuance now. i want a helicopter. 

#### THE DAMN BUFFER DATA WHYYYY WHYYY

#### ok i just had to move hl.wav to the same folder. sorry. thank you past codealongs

#### i kinda don't want to use an exit function, i just want a drone of some sort. wait i can actually take a couple things out i think. sample 13 of my buffer has the hi at the perfect area, i think it's because of demand.kr? oh man i gotta read up the documentation again...

#### ohhh ok i think i know how to modify it

```Buffer.read(s,thisProcess.nowExecutingPath.dirname +/+ "hl.wav",action:{|b|play{t=Impulse.kr(8);PlayBuf.ar(2,b,1,t,Demand.kr(t,0,Dseq([13],4)))}})```

#### ok so i didn't need that big of a sequence if i'm only playing one sample. i think i'm only 7 characters ahead? i need to find a way to optimize it but it's 2:30 now in the morning and i need to sleep lol

#### I think i feel better about the programming here but it's definitely a lot trying to really fully understand what these other things do.

#### thank you [resources](https://scsynth.org/c/resources/5) from the supercollider forums. i need to dive in again

