function rangeInPQW = solveRangeInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly)
p = semimajor_axis*(1-eccentricity^2);
r = p/(1+eccentricity*cosd(true_anomaly));
rangeInPQW = r.*[cosd(true_anomaly); sind(true_anomaly); 0];
end

