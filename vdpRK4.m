clear
close all
clc
%% Inputs
y0 = -2.1e-3;               %% Initial position [m]
ydot0 = -0.1;               %% Initial velocity [m/s]

D = 7.38e1;                 %% Damping modulus [Pas]
E = 1.4e5;                  %% Elastic modulus [Pa]
h0 = 3e-04;                 %% Zero pressure wall thickness [m]
r0 = 2e-03;                 %% Zero pressure internal radius [m]
rho = 1000;                 %% Density of blood (water) [kg/m^3]
Rmax = 5e-2;                %% Average adult human arm radius [m]

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
p_o=10^5*p_o;
p_i=10^5*p_i;

%% Remove last elements because they are not needed
index = length(p_i);
while index >= length(t_p_i)
p_i(index)=[];
index = length(p_i);
end
index = length(p_o);
while index >= length(t_p_i)
p_o(index)=[];
index = length(p_o);
end

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

subplot(2,2,1)
plot(t,z(1,:))
title('Displacement')
xlabel('t [s]')
ylabel('x [m]')

subplot(2,2,2)
plot(t,z(2,:))
title('Velocity')
xlabel('t [s]')
ylabel('v [m/s]')

subplot(2,2,3)
plot(t,p_i)
title('Pi')
xlabel('t [s]')
ylabel('p [Pa]')

subplot(2,2,4)
plot(t,p_o)
title('Po')
xlabel('t [s]')
ylabel('p [Pa]')

print('Documentation/Pics/DispVeloRK4','-dpng')