function z = expeuler(h)
%% Inputs
y0 = -2e-3;                 %% Initial position [m]
ydot0 = 0.05;               %% Initial velocity [m/s]

D = 7.38e2;                 %% Damping modulus [Pa]
E = 1.4e5;                  %% Elastic modulus [Pa]
h0 = 2e-03;                 %% Zero pressure wall thickness [m]
r0 = 3e-04;                 %% Zero pressure internal radius [m]
rho = 1000;                 %% Density of the blood (water) [kg/m^3]
Rmax = 5e-2;                %% Average adult human arm radius [m]
f = 1.2;                    %% Average adult heart beat frequency [Hz] (Between 1.00 and 1.67)
mmHgToPa = 133.322365;      %% Conversation constant between mmHg -> Pa
DBP = 80 * mmHgToPa;        %% Diastolic blood pressure [Pa]
PP = 40 * mmHgToPa;         %% Pulse pressure [Pa]
ST = 130 * mmHgToPa;        %% Start of ramp [Pa]
DR = 3 * mmHgToPa;          %% Deflation rate [Pa]

A = 1/(rho * r0 * Rmax);    %% Computed helper constant [m/kg]

%% Create the grid
t0 = 0;
T = 20;
N = (T-t0)/h;
t = zeros(1,N);
t(1) = t0;

%% Create the system
z(1,1) = y0;
z(2,1) = ydot0;

for i=1:N
    t(i+1) = t(i) + h;
    
    pin = fpi(DBP,PP,f,t(i));
    pout = fpo(ST,DR,t(i));
    
    z(:,i + 1) = z(:,i) + h * zdot(A,D,E,h0,r0,pin,pout,z(:,i));
    z(:,i + 1)
    
end

figure(1)
plot(t,z(1,:))

figure(2)
plot(t,z(2,:))

end