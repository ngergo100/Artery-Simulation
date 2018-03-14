function ret = zdot1(mu,z)

ret = [z(2);...
       mu*(2-z(1)^2)*z(2)-4*z(1)];

end

