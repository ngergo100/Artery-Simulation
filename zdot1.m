function ret = zdot1(A,D,E,h0,r0,pi,po,z)

ret = [z(2);...
       A * ( (pi-po)*r0 - E*h0*z(1)/r0 - D*h0*z(2)/r0)];

end

