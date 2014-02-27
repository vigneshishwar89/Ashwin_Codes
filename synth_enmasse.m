function R =  Synth(queryFolder,ext,ext2)
sr=44100;
files=dir(fullfile(queryFolder,ext));
[m n]=size(files);
for j = 1 : m
    j
    [data, sr]=wavread([queryFolder '/' files(j).name '_wav']);
     f0=load([queryFolder '/'  files(j).name ext2 ]);
     string=[queryFolder '/'  files(j).name];
     run_comm(data,f0,14,0.004,0.002,string);
end