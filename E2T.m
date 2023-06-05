function T = E2T(E, e)
%E2T Summary of this function goes here
%   Detailed explanation goes here
a = (sqrt(1-e^2)*sin(E)) / (1-e*cos(E));
b = (cos(E)-e) / (1-e*cos(E));
T = atan2(a,b);
end

