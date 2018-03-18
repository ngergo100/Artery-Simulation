%% Inputs
h = 0.001;                  %% Time step [s]
y0 = -2e-3;                 %% Initial position [m]
ydot0 = 0.05;               %% Initial velocity [m/s]

D = 7.38e1;                 %% Damping modulus [Pas]
E = 1.4e5;                  %% Elastic modulus [Pa]
h0 = 3e-04;                 %% Zero pressure wall thickness [m]
r0 = 2e-03;                 %% Zero pressure internal radius [m]
rho = 1000;                 %% Density of blood (water) [kg/m^3]
Rmax = 5e-2;                %% Average adult human arm radius [m]
f = 1.2;                    %% Average adult heart beat frequency [Hz] (Between 1.00 and 1.67)
mmHgToPa = 133.322365;      %% Conversation constant between mmHg -> Pa
DBP = 80 * mmHgToPa;        %% Diastolic blood pressure [Pa]
PP = 40 * mmHgToPa;         %% Pulse pressure [Pa]
ST = 130 * mmHgToPa;        %% Start of ramp [Pa]
DR = 3 * mmHgToPa;          %% Deflation rate [Pa]

%% Create the grid
t0 = 0;
T = 20;
N = (T-t0)/h;
t = zeros(1,N);
t(1) = t0;

%% Create the system
z(1,1) = y0;
z(2,1) = ydot0;

%% Calculate the solution
for i=1:N-1
    t(i+1) = t(i)+h;
    
    pin = fpi(DBP,PP,f,t(i));
    pout = fpo(ST,DR,t(i));
    
    Z1 = z(:,i);
    Z2 = z(:,i) + (h/2) * zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z1);
    Z3 = z(:,i) + (h/2) * zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z2);
    Z4 = z(:,i) +   h   * zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z3);
    
    z(:,i+1) = z(:,i) + (h/6) * (zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z1)   + 2*zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z2)+...
                                 2*zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z3) + zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z4));
    
end
%% Plotting the results

subplot(1,2,1)
plot(t,z(1,:))
title('Displacement')
xlabel('t [s]')
ylabel('x [m]')

subplot(1,2,2)
plot(t,z(2,:))
title('Velocity')
xlabel('t [s]')
ylabel('v [m/s]')

print('Documentation/Pics/DispVeloRK4','-dpng')