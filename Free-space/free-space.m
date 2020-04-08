fs = 1000; %Sampling rate
dt = 1/fs; %Sampling period
fc = 900000000; %900MHz
d = 1:1:1000;

lambda = physconst('LightSpeed')/fc;
L = fspl(d,lambda);

figure(1);
plot(d,L);
xlabel('Distance (m)');
ylabel('Path Loss (dB)');
title('Free Space Path Loss');
grid on;
hold on;

fc = 2 * (10^9); % 2GHz
lambda = physconst('LightSpeed')/fc;
L = fspl(d,lambda);

plot(d,L);

fc = 4 * (10^9); % 4GHz
lambda = physconst('LightSpeed')/fc;
L = fspl(d,lambda);

plot(d,L);

fc = 6 * (10^9); % 6GHz
lambda = physconst('LightSpeed')/fc;
L = fspl(d,lambda);

plot(d,L);

fc = 10 * (10^9); % 10GHz
lambda = physconst('LightSpeed')/fc;
L = fspl(d,lambda);

plot(d,L);
hold off

logd = 0:0.001:5; %defining the log of distance axis
d = 10.^logd; %distance
ht = 50; %transmitter antenna height
hr = 2; %receiver antenna height
l_reflected = sqrt( (ht+hr)^2+d.^2);
l_los = sqrt( (ht-hr)^2+d.^2);
R = -1; %reflection coefficient;
G_los = 1; 
G_gr = 1;
fc = 900 * (10^6); %900 MHz carrier frequency
lambda = physconst('LightSpeed')/fc;
phi = 2*pi*(l_reflected-l_los)/lambda;
los = sqrt(G_los)./l_los;
reflected = R*sqrt(G_gr)*exp(-j.*phi)./l_reflected;
sum = lambda.*(los+reflected)/4*pi;
power = abs(sum).^2;
norm = power(1);
power = power./norm; %normalized power
y = 10*log10(power); 

figure(2);
plot(logd,y);
grid on;
title('Power vs distance plot for 2-ray ground reflected model ');
xlabel('log(d)');
ylabel('Received Power(in dB)');

