function ret = zdot(A,D,E,h0,r0,pin,pout,z)

midTerm = 0;
if z(1) > 0
    midTerm = E * h0 * z(1) / r0;
elseif z(1) <= 0
    midTerm = 4 * E * h0^3 * z(1) / (pi^2 * r0^2 * (r0 + h0 + z(1)));
end

ret = [z(2);...
       A * ( (pin - pout) * r0 - midTerm - D * h0 * z(2) / r0 )];


end

