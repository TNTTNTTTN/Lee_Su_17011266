function el = elevation(ENU, el_mask)
R = diag(sqrt(diag(ENU*ENU')));
U = diag(ENU*[0;0;1]);
el = asind(diag(U/R)');
el(el <= el_mask) = NaN;
end

