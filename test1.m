clear
clc
load('nav.mat');
error = 0.1;
mu = 3.986004418*10^5; % [km^3/sec^2]
GCS = [127, 37, 1];
wgs84 = wgs84Ellipsoid('kilometer');
t0 = datetime(nav.GPS.toc);
timestep = 10*60; % [second], 10 minute
M = rem(nav.GPS.M0 + sqrt(mu/(nav.GPS.a/1000)) * timestep, 2*pi);
nu = E2T(M2E(M, nav.GPS.e), nav.GPS.e);
R = solveRangeInPerifocalFrame(nav.GPS.a/1000, nav.GPS.e, nu);
V = solveVelocityInPerifocalFrame(nav.GPS.a/1000, nav.GPS.e, nu);
R_eci = PQW2ECI(nav.GPS.omega, nav.GPS.i, nav.GPS.OMEGA)*R;
R_ecef = ECI2ECEF_DCM(t0+duration(0, 10, 0))*R_eci;
R_enu = zeros(1,3);
[R_enu(1), R_enu(2), R_enu(3)] = ecef2enu(R_ecef(1), R_ecef(2), R_ecef(3), GCS(1), GCS(2), GCS(3), wgs84);
az = azimuth(R_enu);
el = elevation(R_enu, 10);