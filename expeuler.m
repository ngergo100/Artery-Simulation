function expeuler(c1,c2,h)
%% Inputs
y0 = c1;
ydot0 = c2;

%% Create the grid
t0 = 0;
t(1) = t0;
T = 20;
N = (T-t0)/h;

%% Create the system
z(1,1) = y0;
z(2,1) = ydot0;

for i=1:N
    t(i+1) = t(i) + h;
    
    pi=fpi(t(i));
    po=fpo(t(i));
    
    if z(1,i) > 0
        z(:,i+1) = z(:,i) + h*zdot1(pi,po,z(:,i));
    elseif z(1,i) <= 0
        z(:,i+1) = z(:,i) + h*zdot2(pi,po,z(:,i));
    end
    
end

figure(1)
plot(t,z(1,:))

figure(2)
plot(z(1,:),z(2,:))

end