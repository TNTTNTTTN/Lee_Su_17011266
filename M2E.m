function E = M2E(M, e)
%M2E Summary of this function goes here
%   Detailed explanation goes here
Enew = M+e*sin(M);
Eold = Enew + 0.1;
while (abs(Enew - Eold) > 0.0001)
    Eold = Enew;
    Enew = M + e*sin(Eold);
    disp(Enew)
end 
E = Enew;
end

