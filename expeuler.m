function expeuler(mu,c1,c2,h)
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
    
    z(:,i+1) = z(:,i) + h*zdot(mu,z(:,i));
    
end
figure(1)
plot(t,z(1,:))

figure(2)
plot(z(1,:),z(2,:))




end