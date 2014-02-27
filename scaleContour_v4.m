function [sipc]=scaleContour_v4(freq,time,ymin,ymax,xmin,xmax)
    freq1=scaledata(freq,ymin,ymax);
    time1=scaledata(time,xmin,xmax);
    sipc=[time1 freq1];
    %R.scale=spic;