function [sipc]=scaleContour_v3(DATA,xscale,yscale)
xlim=xscale;
ylim=yscale;
    freq=DATA;
    time=[1:length(freq)]';

    freq1=scaledata(freq,0,ylim);
    time1=scaledata(time,0,xlim);
    sipc=[time1 freq1];
    %R.scale=spic;