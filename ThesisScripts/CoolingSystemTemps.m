function [x,y] = CoolingSystemTemps()
% Data pair 48
% From description:
% Information for pairs0048:
% 
% x: Indoor temperature 
% 
% y: Outdoor temperature
% 
% source:
% Hipel and Mcleod (1994): 
% Time series modelling of water resources and environmental systems
% www.stats.uwo.ca/faculty/mcleod/epubs/mhsets/readme-mhsets.html.
% 
% ground truth:
% y-->x

basedir = 'PairsForTesting/pairs/';
fprefix = 'pair';
ftype = '.txt';

% snowfall data
ftemp = sprintf('%s%s%04d%s',basedir,fprefix,48,ftype);
SF = dlmread(ftemp);

% unpack data
x = SF(:,1)';
y = SF(:,2)';
