function R=getResults(resultFile,waveForm,outpath)
s=textread(resultFile,'%s','delimiter','\n');
s=char(s);
%feat=load(wavfeatfile);
[Y,FS,Nbits]=wavread(waveForm);

%path1=['/home/shrey/Projects/motif_match/Data/DataLCSS/Test/Kamboji_fullPitch/'];
%waveForm=[path1 waveFile];
zc=zeros(length(s),1);
for i=1:length(s)
    if(s(i,:)==' ')
        zc(i)=1;
    end
end
ind=find(zc);
k=1;
stind=1;
for i=1:length(ind)
    a=s((k:ind(i)),:);
    a=str2num(a);
    a(:,2)=a(:,2)+(701-534);
    res(i).val=a;
    k=ind(i)+1;
    ind(i);
end

result_dir_name =  'Results_motif_wav';
mkdir([outpath result_dir_name]);
for i=1:length(res)
    tstart=441.*(res(i).val(1,2));
    tend=441.*(res(i).val(end,2));
    outF=[outpath result_dir_name '/' 'match' num2str(i) '.wav']; 
    %system(['ch_wave' path1 'DKP_Kamboji1_Fold15.wav' '-start' tstart '-end' tend  '-o' outF])
    %length(Y)
    %tend
    wavwrite(Y(tstart:tend),44100,outF)
end
    
    
