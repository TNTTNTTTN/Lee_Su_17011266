function velocityInPQW = solveVelocityInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly)
mu = 3.986004418*10^5; % [km^3/sec^2]
p = semimajor_axis*(1-eccentricity^2);
velocityInPQW = sqrt(mu/p).*[-sind(true_anomaly); eccentricity+cosd(true_anomaly); 0];
end

