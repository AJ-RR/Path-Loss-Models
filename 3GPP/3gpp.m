%3GPP Path Loss model.
clear all;
%Effective environment height
he = 1;
ht = 25;
transmitter_pos = [0,0,75+ht];
h_t = ht - he;
hr = 2;
receiver_pos = [0,50,4+hr];
h_r = hr - he;

%defining the distances (in metres)
d_3d = norm(transmitter_pos - receiver_pos);
d_2d = sqrt(sum((transmitter_pos(1,2) - receiver_pos(1,2)).^2));
disp(d_3d);

%Carrier frequency in GHz
fc = 10:4:30;

c = physconst('LightSpeed');

%breakpoint distance
d_p = (4 * h_t * h_r * (10^9)/c).* fc;
L = [];

%Path Loss without shadowing
for i = 1:length(fc) 
    if d_2d < d_p(i) 
        L = [L,28.0 + 22 * log10(d_3d) + 20 * log10(fc(i))];
    else
        L = [L,28.0 + 40 * log10(d_3d) + 20 * log10(fc(i)) - 9 * log10((d_p(i))^2 + (ht - hr)^2)];
    end
    
end


%plotting the pathloss
figure(1);
scatter(fc,L,'filled');
title('3GPP Path Loss');
xlabel('frequency (GHz)');
ylabel('Path Loss (dB)');
ylim([70,120]);
grid on;
hold on;

[rec_power,gain,L] = pathLossShadowing(fc,d_2d,d_3d,d_p);
scatter(fc,L,'filled');
disp(rec_power);
disp(gain);

receiver_pos = [0,100,4+hr];

%defining the distances (in metres)
d_3d = norm(transmitter_pos - receiver_pos);
disp(d_3d);
d_2d = sqrt(sum((transmitter_pos(1,2) - receiver_pos(1,2)).^2));
d_p = (4 * h_t * h_r * (10^9)/c).* fc;

[rec_power,gain,L] = pathLossShadowing(fc,d_2d,d_3d,d_p);
figure(2);
scatter(fc,L,'filled');
title('3GPP Path Loss');
xlabel('fc (GHz)');
ylabel('Path Loss (dB)');
grid on;

%Path Loss with shadowing
function [rec_power,gain,L] = pathLossShadowing(fc,d_2d,d_3d,d_p)

syms pr_toSolve Gt;
gain = [];
L = [];
rec_power = [];
pt = 10^((47 - 30)/10);
pr = 10^((20 - 30)/10);

for i = 1:length(fc)
    
    if d_2d < d_p(i) 
        
        psi = normrnd(0,4);
        
        Pr = solve(10*log10(pt/pr_toSolve) == 28.0 + 22 * log10(d_3d) + 20 * log10(fc(i)) - psi,pr_toSolve);
        rec_power = [rec_power,Pr];
        
        G = solve(10*log10(pt/pr) == 28.0 + 22 * log10(d_3d) + 20 * log10(fc(i)) - 10*log10(Gt) - psi,Gt);
        gain = [gain,G];
        
        L = [L,28.0 + 22 * log10(d_3d) + 20 * log10(fc(i)) - psi ];
    
    else
        psi = normrnd(0,4);
        
        Pr = solve(10*log10(pt/pr_toSolve) == 28.0 + 22 * log10(d_3d) + 20 * log10(fc(i)) - psi,pr_toSolve);
        rec_power = [rec_power,Pr];
        
        G = solve(10*log10(pt/pr) == 28.0 + 22 * log10(d_3d) + 20 * log10(fc(i)) - 10*log10(Gt) - psi,Gt);
        gain = [gain,G];
        L = [L,28.0 + 40 * log10(d_3d) + 20 * log10(fc(i)) - 9 * log10((d_p(i))^2 + (ht - hr)^2)- psi];
    
    end
    
end

rec_power = double(rec_power);
rec_power = 10*log10(rec_power) + 30;

gain = double(gain);
gain = 10*log10(gain);

end