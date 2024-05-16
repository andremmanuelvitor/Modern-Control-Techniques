pkg load control;
clear all;
#close all;
clc;

ta = 0.1;

as = [0 1; 1 0];
bs = [0;1];
cs = [2 1];

gs = ss(as, bs, cs);
gz = c2d(gs, ta);

[az, bz, cz, dz, tz] = ssdata(gz);

%G1(s)
aes = [as zeros(2,1); -cs 0]; 
bes = [bs; 0];

aez = [az zeros(2,1); -cz 1]; 
bez = [bz; 0];

s1 = -4+i*5.458;
s2 = -4-i*5.458;
s3 = -2;

z1 = exp(s1*ta);
z2 = exp(s2*ta);
z3 = exp(s3*ta);

kes = acker(aes, bes, [s1 s2 s3]);
ks = kes(1:2);
js = -kes(3);

kez = acker(aez, bez, [z1 z2 z3]);
kz = kez(1:2);
jz = -kez(3);

ys = ss([as-bs*ks bs*js; -cs 0], [0;0;1], [cs 0]);
us = ss([as-bs*ks bs*js; -cs 0], [0;0;1], [-ks js]);

yp = ss([az-bz*kz bz*jz; -cz 1], [0;0;1], [cz 0], 0, ta);
up = ss([az-bz*kz bz*jz; -cz 1], [0;0;1], [-kz jz], 0, ta);

yc = ss([az-bz*kz bz*jz; -cz 1], [bz*jz;1], [cz 0], 0, ta);
uc = ss([az-bz*kz bz*jz; -cz 1], [bz*jz;1], [-kz jz], jz, ta);

yt = ss([az-bz*kz bz*jz; -cz 1], [bz*jz/2;1], [cz 0], 0, ta);
ut = ss([az-bz*kz bz*jz; -cz 1], [bz*jz/2;1], [-kz jz], jz/2, ta);

figure;
subplot(2, 1, 1);
step(ys, 2);
hold on;
step(yp, 2, 'r');
hold on;
step(yc, 2, 'g');
hold on;
step(yt, 2, 'k');
ylabel('saída');
subplot(2, 1, 2);
step(us, 2);
hold on;
step(up, 2, 'r');
hold on;
step(uc, 2, 'g');
hold on;
step(ut, 2, 'k');
ylabel('entrada');