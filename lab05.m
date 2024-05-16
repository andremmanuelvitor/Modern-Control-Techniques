pkg load control;
clear all;
close all;
clc;

% o sistema nunca vai deixar de ser continuo, discreto é só a percepção que a gnt passa a fazer
% manter pelo menos 5 amostras no tempo de subida

ta = 1;

a1 = [0 1; 0 -1];
b1 = [0; 1];
c1 = [-2 1];

g1s = ss(a1, b1, c1);
g1z = c2d(g1s, ta); %por padrao faz 'zoh'

##step(g1s, 10);
##hold on;
##step(g1z, 10, 'r');

%modelo da G1
a1 = [0 1; 0 -1];
b1 = [0; 1];
c1 = [1 0];

%modelo da G2
a2 = [0 1; 1 0];
b2 = [0; 1];
c2 = [2 1];

%modelo da G3
a3 = [0 1; 0 -1];
b3 = [0; 1];
c3 = [-2 1];

s1 = -4+i*5.458;
s2 = -4-i*5.458;

s1 = s1/10;
s2 = s2/10;

k1 = acker(a1, b1, [s1 s2]);
k2 = acker(a2, b1, [s1 s2]);
k3 = acker(a3, b1, [s1 s2]);

f1 = -inv(c1*inv(a1-b1*k1)*b1);
f2 = -inv(c2*inv(a2-b1*k2)*b1);
f3 = -inv(c3*inv(a3-b1*k3)*b1);

t1 = ss(a1-b1*k1, b1*f1, c1);
t2 = ss(a2-b1*k2, b1*f2, c2);
t3 = ss(a3-b1*k3, b1*f3, c3);

##figure;
##bode(t1);
##figure;
##bode(t2);
##figure;
##bode(t3);

t1z = c2d(t1, ta);
t2z = c2d(t2, ta);
t3z = c2d(t3, ta);

figure;
step(t1, 30);
hold on;
step(t1z, 30, 'r');

figure;
step(t2, 30);
hold on;
step(t2z, 30, 'r');

figure;
step(t3, 30);
hold on;
step(t3z, 30, 'r');
