function ret = zdot(D,E,h0,r0,rho,Rmax,pin,pout,z)

if z(1) <= 0
    midTerm = (4 * E / pi^2) * (h0^2 / r0^2) * (h0 / (r0 + h0 + z(1))) * z(1);
else
    midTerm = E * h0 / r0 * z(1);
end

ret = [z(2);...
       (1 / (rho * r0 * Rmax)) * ( (pin - pout) * r0 - midTerm - D * h0 / r0 * z(2))];


end

