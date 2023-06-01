clear
clc
load('nav.mat');
error = 0.1;
mu = 3.986004418*10^5; % [km^3/sec^2]
time = datetime(nav.GPS.toc);
jtime = juliandate(time);
stime = siderealTime(jtime);
timestep = 10*60; % [second], 10 minute
M = nav.GPS.M0 + sqrt(mu/nav.GPS.a/1000) * timestep;
% R = solveRangeInPerifocalFrame(nav.GPS.a/1000, nav.GPS.e, )