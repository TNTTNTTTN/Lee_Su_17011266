function ROT = PQW2ECI(arg_prg, inc_angle, RAAN)
ROT = DCMZ(RAAN)*DCMX(inc_angle)*DCMZ(arg_prg);
end

function MAT = DCMX(phi)
MAT = [1 0 0; 0 cosd(phi) -sind(phi); 0 sind(phi) cos(phi)];
end

function MAT = DCMY(theta)
MAT = [cosd(theta) 0 sind(theta); 0 1 0; -sind(theta) 0 cosd(theta)];
end 

function MAT = DCMZ(psi)
MAT = [cosd(psi) -sind(psi) 0; sind(psi) cosd(psi) 0; 0 0 1];
end
