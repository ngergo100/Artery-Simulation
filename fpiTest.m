h = 0.001;
t0 = 0;
t(1) = t0;
T = 20;
N = (T-t0)/h;
f = 1.2;                    %% Average adult heart beat frequency [Hz] (Between 1.00 and 1.67)
mmHgToPa = 133.322365;      %% Conversation constant between mmHg -> Pa
DBP = 80 * mmHgToPa;        %% Diastolic blood pressure [Pa]
PP = 40 * mmHgToPa;         %% Pulse pressure [Pa]

fpiResult(1) = fpi(DBP,PP,f,t(1));

for i=1:N
    t(i+1) = t(i) + h;
    
    fpiResult(i+1) = fpi(DBP,PP,f,t(i+1));
end

figure(1)
plot(t,fpiResult)