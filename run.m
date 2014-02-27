function r = run(data,f0,lpOrder,t1,t2,string)
resynFlname=[string '_reSyn.wav'];
resFlname=[string '_res.wav'];
pitchSyn=[string '_pitchSyn.wav'];
glotSyn=[string '_glotSyn.wav'];
[lpC,res]=lpRes(data,160,80,lpOrder,1);
eng=computeEnergy(data,160,160);
psyn=createImpulse(f0,eng,160,t1,t2,0);
gsyn=createImpulse(f0,eng,160,t1,t2,1);
reSyn=lpSyn(res,160,80,lpC,12,2);
pitchDataSyn=lpSyn(psyn,160,80,lpC,12,2);
glotDataSyn=lpSyn(psyn,160,80,lpC,12,2);
wavwrite(reSyn,16000,32,resynFlname);
wavwrite(res,16000,32,resFlname);
wavwrite(psyn,16000,32,resFlname);
wavwrite(gsyn,16000,32,resFlname);
r=1;