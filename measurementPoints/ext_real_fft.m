% A real_fft függvény egy valós értékû jel (signal) diszkrét Fourier
% transzformáltját számolja ki a Matlab fft parancsának segítségével.

% Paraméterek:
%      t:  mintavételi idõpontok (Állandó mintavételi frekvencia szükséges!)
% signal:  a mért (valós) mennyiség értéke a mintavételi helyeken

%  freqs:  A felbontásban szereplõ frekvenciák növekvõ sorrendben
%   amps:  A fenti frekvenciákhoz tartozó amplitúdók
% phases:  Szintén a fenti frekvenciákhoz tartozó fáziseltolások értékei.
%  coefs:  A diszkrét fourier transzformálthoz tartozó komplex együtthatók.


% Az eredeti jel így szinetizálható (a gyakorlatban az ifft hatékonyabb):
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
freqs(1:N_half,1) = 1/timestep * (0:N_half-1)/N; % 1/timestep = mintavételezési frekvencia

coefs = fft(signal);

amps(1:N_half,1) = 2/N*abs( coefs(1:N_half) );
amps(1) = amps(1)/2;
if (mod(N,2)==0) amps(N_half)=amps(N_half)/2; end;
phases(1:N_half,1) = angle(coefs(1:N_half));
