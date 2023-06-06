clear
clc
load('nav.mat');
mu = 3.986004418*10^5; % [km^3/sec^2]
GCS = [0, 0, 0];
wgs84 = wgs84Ellipsoid('kilometer');
t0 = datetime(nav.GPS.toc);
timestep = 10*60; % [second], 10 minute
enudataset = [];
geodataset = [];
for i = 0:24*6
    M = rem(nav.GPS.M0 + sqrt(mu/((nav.GPS.a/1000)^3)) * timestep*i, 2*pi);
    nu = E2T(M2E(M, nav.GPS.e), nav.GPS.e)*180/pi;
    disp(nu);
    R = solveRangeInPerifocalFrame(nav.GPS.a/1000, nav.GPS.e, nu);
    % V = solveVelocityInPerifocalFrame(nav.GPS.a/1000, nav.GPS.e, nu);
    R_eci = PQW2ECI(nav.GPS.omega*180/pi, nav.GPS.i*180/pi, nav.GPS.OMEGA*180/pi)*R;
    R_ecef = ECI2ECEF_DCM(t0+duration(0, 10, 0)*i)*R_eci;
    %R_ecef = eci2ecef(t0+duration(0, 10, 0)*i, R_eci);
    R_enu = zeros(1,3);
    R_geo = zeros(1,3);
    [R_enu(1), R_enu(2), R_enu(3)] = ecef2enu(R_ecef(1), R_ecef(2), R_ecef(3), GCS(1), GCS(2), GCS(3), wgs84);
    [R_geo(1), R_geo(2), R_geo(3)] = ecef2geodetic(wgs84, R_ecef(1), R_ecef(2), R_ecef(3));
    enudataset = [enudataset; R_enu];
    geodataset = [geodataset; R_geo];
end
az = azimuth(enudataset);
az(az<0) = az(az<0) + 360;
el = elevation(enudataset, 10);