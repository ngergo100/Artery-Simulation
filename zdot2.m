function ret = zdot2(A,D,E,h0,r0,pi,po,z)

ret = [z(2);...
       A*((pi-po)-z(1)-z(2))];

end