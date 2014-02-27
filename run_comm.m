function r = run_comm(data,f0,lpOrder,t1,t2,string)
resynFlname=[string '_reSyn.wav'];
resFlname=[string '_res.wav'];
pitchSyn=[string '_pitchSyn.wav'];
glotSyn=[string '_glotSyn.wav'];
[lpC,res]=lpRes(data,882,441,lpOrder,1);
 eng=computeEnergy(data,441,441);
 eng=0.7*ones(length(eng),1);
 size(eng)
 size(f0)
 
  %psyn=createImpulse(f0,eng,441,t1,t2,0);
  gsyn=createImpulse(f0,eng,441,t1,t2,1);
%  size(psyn);
%  size(lpC);
  %reSyn=lpSyn(res,882,441,lpC,lpOrder,2);
  %pitchDataSyn=lpSyn(psyn,882,441,lpC,lpOrder,2);
  glotDataSyn=lpSyn(gsyn,882,441,lpC,lpOrder,2);
  %wavwrite(reSyn,44100,resynFlname);
 % wavwrite(res,16000,resFlname);
 % %plot(pitchDataSyn)
  %wavwrite(pitchDataSyn/(2*max(pitchDataSyn)),44100,pitchSyn);
  wavwrite(glotDataSyn/(1.02*max(glotDataSyn)),44100,glotSyn);
r=lpC;
r=1