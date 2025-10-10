# introducing the endless lilithcopter

#### the whole concept of this patch is that i wanted to play around with more samples / audio samples, i hope to get something funny / at least something working in terms of a beat repeat. 

#### shoutout (this website)[https://supercollider.github.io/sc-140.html] for giving me the inspiration i needed for this. especially Nathanel Virgo's patch

#### the first iteration is tough. i don't know why it's not counting my file when i tried to replace certain aspects of it and modify it. it's pretty cool to scrub but i just want something a bit more rudimentary. 

```b=Buffer.read(s,"hl.wav");play{t=Impulse.kr(5);PlayBuf.ar(1,b,1,t,Demand.kr(t,0,Dseq(1e3*[103,41,162,15,141,52,124,190],4)))!2}```