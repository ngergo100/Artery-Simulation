close all
clear 
h = 0.001;
t0 = 0;
t(1) = t0;
T = 20;
N = (T-t0)/h;
f = 1.2;
mmHgToPa = 133.322365;
ST = 130 * mmHgToPa;
DR = 3 * mmHgToPa;

fpoResult(1) = fpo(ST,DR,t(1));

for i=1:N
    t(i+1) = t(i) + h;
    
    fpoResult(i+1) = fpo(ST,DR,t(i+1));
end

figure(1)
plot(t,fpoResult)