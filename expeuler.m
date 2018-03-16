function expeuler(c1,c2,h)
%% Inputs
y0 = c1;                    %% Initial position [m]
ydot0 = c2;                 %% Initial velocity [m/s]

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
t(1) = t0;
T = 20;
N = (T-t0)/h;

%% Create the system
z(1,1) = y0;
z(2,1) = ydot0;

for i=1:N
    t(i+1) = t(i) + h;
    
    pi=fpi(DBP,PP,f,t(i));
    po=fpo(ST,DR,t(i));
    
    if z(1,i) > 0
        z(:,i + 1) = z(:,i) + h * zdot1(A,D,E,h0,r0,pi,po,z(:,i));
    elseif z(1,i) <= 0
        z(:,i + 1) = z(:,i) + h * zdot2(A,D,E,h0,r0,pi,po,z(:,i));
    end
    
end

figure(1)
plot(t,z(1,:))

figure(2)
plot(t,z(2,:))

end