clear
close all
clc
%% Inputs
y0 = 0;                 %% Initial position [m]
ydot0 = 0.01;               %% Initial velocity [m/s]

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

%% Load real pi and po
dataSourceName='processed/20170504_no2_fesz-processed-';
t_p_o_name=strcat(dataSourceName,'t_p_o.mat');
p_o_name=strcat(dataSourceName,'p_o.mat');
t_p_i_name=strcat(dataSourceName,'t_p_i.mat');
p_i_name=strcat(dataSourceName,'p_i.mat');
load(t_p_o_name);
load(p_o_name);
load(t_p_i_name);
load(p_i_name);

%% Convert [Bar] to [Pa]
p_o=10^4*p_o;
p_i=10^4*p_i;

%% Create the grid
h=t_p_i(2)-t_p_i(1);        %% Time step [s]
h_o=t_p_o(2)-t_p_o(1);      %% FYI
if h ~= h_o
    warning('This is no good :D')
end
disp('Step is')
disp(h)
t0 = 0;
T = t_p_i(end);
N = (T-t0)/h;
t = zeros(1,N);
t(1) = t0;

%% Create the system
z(1,1) = y0;
z(2,1) = ydot0;

%% Calculate the solution
for i=1:N-1
    t(i+1) = t(i)+h;
    
    pin = p_i(i);
    pout = p_o(i);
    
    Z1 = z(:,i);
    Z2 = z(:,i) + (h/2) * zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z1);
    Z3 = z(:,i) + (h/2) * zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z2);
    Z4 = z(:,i) +   h   * zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z3);
    
    z(:,i+1) = z(:,i) + (h/6) * (zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z1)+... 
                                 2*zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z2)+...
                                 2*zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z3)+...
                                 zdot(D,E,h0,r0,rho,Rmax,pin,pout,Z4));
    
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