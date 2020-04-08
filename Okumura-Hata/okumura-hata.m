% Okumura-Hata model

d = 1:0.001:10; %distance in metres
ht = 40; %transmitting antenna height
hr = 3; %receiving antenna height
%MHz
fc1 = 900 * (1);
fc2 = 1 * (10^3);
fc3 = 1.5 * (10^3);

%correction factor for large cities
ahr = 3.2*(log10(11.75*hr)).^2 - 4.97; 

Lurban1 = 69.55 + 26.16*log10(fc1) + (44.9 - 6.55*log10(ht))*log10(d) - 13.82*log10(ht) - ahr;
Lurban2 = 69.55 + 26.16*log10(fc2) + (44.9 - 6.55*log10(ht))*log10(d) - 13.82*log10(ht) - ahr;
Lurban3 = 69.55 + 26.16*log10(fc3) + (44.9 - 6.55*log10(ht))*log10(d) - 13.82*log10(ht) - ahr;

figure(1);
plot(d,Lurban1);
title('Path Loss of Okumura-Hata model');
xlabel('d (km)');
ylabel('Path Loss (dB)');
grid on;
hold on;

plot(d,Lurban2);
plot(d,Lurban3);

%COST 231 extension
cm = 3; %metropolitan city
%MHz
fc1 = 1.6 * (10^3);
fc2 = 1.8 * (10^3);
fc3 = 2 * (10^3);

Lurban1 = 46.3 + 33.9*log10(fc1) + (44.9 - 6.55*log10(ht))*log10(d) - 13.82*log10(ht) - ahr + cm;
Lurban2 = 46.3 + 33.9*log10(fc2) + (44.9 - 6.55*log10(ht))*log10(d) - 13.82*log10(ht) - ahr + cm;
Lurban3 = 46.3 + 33.9*log10(fc3) + (44.9 - 6.55*log10(ht))*log10(d) - 13.82*log10(ht) - ahr + cm;

figure(2);
plot(d,Lurban1);
title('Path loss for COST 321');
xlabel('d (km)');
ylabel('Path Loss (dB)');
grid on;
hold on;

plot(d,Lurban2);
plot(d,Lurban3);

cm = 0; %medium sized city

Lurban1 = 46.3 + 33.9*log10(fc1) + (44.9 - 6.55*log10(ht))*log10(d) - 13.82*log10(ht) - ahr + cm;
Lurban2 = 46.3 + 33.9*log10(fc2) + (44.9 - 6.55*log10(ht))*log10(d) - 13.82*log10(ht) - ahr + cm;
Lurban3 = 46.3 + 33.9*log10(fc3) + (44.9 - 6.55*log10(ht))*log10(d) - 13.82*log10(ht) - ahr + cm;

figure(3);
plot(d,Lurban1);
title('Path loss for COST 321');
xlabel('d (km)');
ylabel('Path Loss (dB)');
grid on;
hold on;

plot(d,Lurban2);
plot(d,Lurban3);
