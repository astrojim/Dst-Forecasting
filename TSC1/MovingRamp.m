function Vf = MovingRamp(AngleTS,tstep_units)
% The idea is to create a time series of the velocity of a block
% sliding down a frictionless ramp at varying angles with the Earth.
%
% AngleTS - time series of angles a each time step unit
% tstep_units - the seconds in each time step (e.g. 0.1, 0.5, 10, etc)
%
% For example, if the angle of ramp changes 0.1571 radians every half second
% starting at 0 radians, going to pi/4 radians, and then returning to 0
% radians, then you'd have tstep_units = 0.5 and 
% AngleTS =
% [0,0.1571,0.3142,0.4713,0.6284,0.7854,0.6283,0.4712,0.3141,0.1570,0]
% or AngleTS = [0:(pi/20):pi/4 (pi/4-pi/20):-(pi/20):0]

g = 9.8; % [m/s^2]
tvec = length(AngleTS).*tstep_units; % [s]
trigvec = sin(AngleTS); % radians
Vf = 2*g.*tvec.*trigvec.*trigvec;