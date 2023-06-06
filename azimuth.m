function az = azimuth(ENU)
EN = ENU*[1 0;0 1;0 0];
R = diag(diag(sqrt(EN*EN')));
N = diag(EN*[0; 1]);
E = EN*[1;0];
az = acosd(diag(N/R)');
az(E<0) = -az(E<0)+360;
end

