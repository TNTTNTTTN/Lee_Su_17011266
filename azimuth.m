function az = azimuth(ENU)
EN = ENU*[1 0;0 1;0 0];
R = diag(diag(sqrt(EN*EN')));
N = diag(EN*[0; 1]);
az = asind(diag(N/R)');
end

