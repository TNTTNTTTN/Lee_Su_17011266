function DCM = ECI2ECEF_DCM(time)
jd = juliandate(time);
psi = siderealTime(jd);
DCM = DCMZ(psi)';
end

function MAT = DCMZ(psi)
MAT = [cosd(psi) -sind(psi) 0; sind(psi) cosd(psi) 0; 0 0 1];
end
