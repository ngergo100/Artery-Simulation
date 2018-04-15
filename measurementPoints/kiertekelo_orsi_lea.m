clear all
close all

Data1=importdata('20170504_ff6_laza.dat');
Data2=importdata('20170504_ff6_fesz.dat');

%a laza karral m�rt adatok beolvas�sa
t1=Data1(:,1);
delta_t=t1(2)-t1(1);
p_mandzsetta1=Data1(:,2);
p_mic1=Data1(:,3);

%-----------a sz�munkra �rdekes tartom�ny kiv�g�sa (150 �s 70 Hgmm k�z�tt)------
k1=1;
for i=1:length(t1)
    if p_mandzsetta1(i)*750.061561303 < 150 
        if p_mandzsetta1(i)*750.061561303 > 70
            CP1(k1)= p_mandzsetta1(i)*750.061561303 ; %Cuff Pressure
            KS1(k1)= p_mic1(i);   %Korotkov Sound
            k1=k1+1;
        end
    end
end


%ellen�rz� nyomtat�s----------

figure(1)
plot(KS1)


%--------a hang jel sz�r�se �s a cs�csok megkeres�se-----------
filtKS1 = sgolayfilt(KS1,6,51);
[pks1,locs1] = findpeaks(filtKS1,'MinPeakHeight',0.0015);

%--------�bra rajzol�sa--------------
figure(2)
subplot(2,1,1)
plot( t1(1:length(filtKS1)),filtKS1,'-')
xlabel('t [s]');
ylabel('Sound [V]');
grid on

subplot(2,1,2)
plot(t1(1:1:length(CP1)), CP1)
xlabel('t [s]');
ylabel('Pressure [mmHg]');
ylim([70 150])
grid on
%--------sytole, diastole ki�r�sa------
tsys1=locs1(1)*delta_t;
tdias1=locs1(end)*delta_t;

systole1=CP1(locs1(1))
diastole1=CP1(locs1(end))

%a feszes karral m�rt adatok beolvas�sa

t2=Data2(:,1);
p_mandzsetta2=Data2(:,2);
p_mic2=Data2(:,3);

%-----------a sz�munkra �rdekes tartom�ny kiv�g�sa (150 �s 70 Hgmm k�z�tt)------
k2=1;
for i=1:length(t2)
    if p_mandzsetta2(i)*750.061561303 < 150 
        if p_mandzsetta2(i)*750.061561303 > 70
            CP2(k2)= p_mandzsetta2(i)*750.061561303 ; %Cuff Pressure
            KS2(k2)= p_mic2(i);   %Korotkov Sound
            k2=k2+1;
        end
    end
end
%ellen�rz� nyomtat�s----------

figure(3)
plot(KS2)


%--------a hang jel sz�r�se �s a cs�csok megkeres�se-----------
filtKS2 = sgolayfilt(KS2,7,71);
[pks2,locs2] = findpeaks(filtKS2,'MinPeakHeight',0.003);

%--------�bra rajzol�sa--------------
figure(4)
subplot(2,1,1)
plot( t2(1:length(filtKS2)),filtKS2,'-')
xlabel('t [s]');
ylabel('Sound [V]');
grid on

subplot(2,1,2)
plot(t2(1:1:length(CP2)), CP2)
xlabel('t [s]');
ylabel('Pressure [mmHg]');
ylim([70 150])
grid on
%--------sytole, diastole ki�r�sa------
tsys2=locs2(1)*delta_t;
tdias2=locs2(end)*delta_t;

systole2=CP2(locs2(1))
diastole2=CP2(locs2(end))

%------------mind a n�gy kirajzol�sa--------

figure(5)
subplot(2,2,2)
plot( t2(1:length(filtKS2)),filtKS2,'-')
title('Fesz�tett kar');
xlabel('t [s]');
ylabel('Sound [V]');
grid on

subplot(2,2,4)
plot(t2(1:1:length(CP2)), CP2,'-', tsys2,systole2,'*', tdias2,diastole2,'*')
xlabel('t [s]');
ylabel('Pressure [mmHg]');
ylim([70 150])
grid on

subplot(2,2,1)
plot( t1(1:length(filtKS1)),filtKS1,'-')
xlabel('t [s]');
ylabel('Sound [V]');
title('Laz�n tartott kar');
grid on

subplot(2,2,3)
plot(t1(1:1:length(CP1)), CP1,'-', tsys1,systole1,'*', tdias1,diastole1,'*')
xlabel('t [s]');
ylabel('Pressure [mmHg]');
ylim([70 150])
grid on
%-----------------------------------------------------------


addpath('E:\dokumentumok\oktat�s\�F\Orsi+Lea')
n=2048; %min(length(filtKS1),length(filtKS2))

[f1, amps1]=ext_real_fft(t1(1:n), KS1(1:n));
[f2, amps2]=ext_real_fft(t2(1:n), KS2(1:n));
figure(6)

subplot(2,1,1)
plot(f1,amps1)
xlabel('f [Hz]')
ylabel('A [V]')
title('Laz�n tartott kar');
xlim([0 500])
grid on

subplot(2,1,2)
plot(f2,amps2)
xlabel('f [Hz]')
ylabel('A [V]')
title('Fesz�tett kar');
xlim([0 500])
grid on


