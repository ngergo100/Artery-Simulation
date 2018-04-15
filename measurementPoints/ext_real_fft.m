% A real_fft f�ggv�ny egy val�s �rt�k� jel (signal) diszkr�t Fourier
% transzform�ltj�t sz�molja ki a Matlab fft parancs�nak seg�ts�g�vel.

% Param�terek:
%      t:  mintav�teli id�pontok (�lland� mintav�teli frekvencia sz�ks�ges!)
% signal:  a m�rt (val�s) mennyis�g �rt�ke a mintav�teli helyeken

%  freqs:  A felbont�sban szerepl� frekvenci�k n�vekv� sorrendben
%   amps:  A fenti frekvenci�khoz tartoz� amplit�d�k
% phases:  Szint�n a fenti frekvenci�khoz tartoz� f�ziseltol�sok �rt�kei.
%  coefs:  A diszkr�t fourier transzform�lthoz tartoz� komplex egy�tthat�k.


% Az eredeti jel �gy szinetiz�lhat� (a gyakorlatban az ifft hat�konyabb):
% signal = zeros(size(t));
% for k=1:size(freqs,1)
%     signal = signal + amps(k) * cos(freqs(k)*2*pi*t + phases(k));
% end;

function [freqs, amps, phases, coefs] = ext_real_fft( t, signal )

timestep = t(2)-t(1);
N = length(signal);
N_half = ceil((N+1)/2);


% for i = 1:N_half
%     freqs(i,1) = 1/timestep * (i-1)/N;
% end;
freqs(1:N_half,1) = 1/timestep * (0:N_half-1)/N; % 1/timestep = mintav�telez�si frekvencia

coefs = fft(signal);

amps(1:N_half,1) = 2/N*abs( coefs(1:N_half) );
amps(1) = amps(1)/2;
if (mod(N,2)==0) amps(N_half)=amps(N_half)/2; end;
phases(1:N_half,1) = angle(coefs(1:N_half));
