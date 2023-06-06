function E = M2E(M, e)
Eold = M;
Enew = M+e*sin(M);
while (abs(Enew - Eold) > 0.0001)
    Eold = Enew;
    Enew = M + e*sin(Eold);
end 
E = Enew;
end

