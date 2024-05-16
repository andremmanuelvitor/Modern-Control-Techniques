pkg load control;
clear all;
close all;
clc;

t0 = tf(45.79, [1 8 45.79]);

a1 = [0 1; 0 -1];
b1 = [0; 1];
c1 = [1 0];

a2 = [0 1; 1 0];
b2 = b1;
c2 = [2 1];

a3 = [0 1; 0 -1];
b3 = b1;
c3 = [-2 1];

%G1(s)
ae1 = [a1 zeros(2,1); -c1 0];
be1 = [b1; 0]

s1 = -4+i*5.458;
s2 = -4-i*5.458;
s3 = -40;

ke1 = acker(ae1, be1, [s1, s2, s3])
k1 = ke1(1:2)
j1 = -ke1(3)

t1 = ss([a1-b1*k1 b1*j1; -c1 0], [0;0;1], [c1 0])

figure;
step(t0, 'r--');
hold on;
step(t1);

##%G2(s)
##ae2 = [a2 zeros(2,1); -c2 0];
##be2 = [b2; 0];
##
##s1 = -4+i*5.458;
##s2 = -4-i*5.458;
##s3 = -2;
##
##ke2 = acker(ae2, be2, [s1, s2, s3])
##k2 = ke2(1:2);
##j2 = -ke2(3);
##
##t2 = ss([a2-b2*k2 b2*j2; -c2 0], [0;0;1], [c2 0]);
##
##figure;
##step(t0, 'r--');
##hold on;
##step(t2);
##
##%G3(s)
##ae3 = [a3 zeros(2,1); -c3 0];
##be3 = [b3; 0];
##
##s1 = -4+i*5.458;
##s2 = -4-i*5.458;
##s3 = -2;
##
##s1 = s1/10;
##s2 = s2/10;
##
##ke3 = acker(ae3, be3, [s1, s2, s3])
##k3 = ke3(1:2);
##j3 = -ke3(3);
##
##t3 = ss([a3-b3*k3 b3*j3; -c3 0], [0;0;1], [c3 0]);
##
##t0 = tf(45.79/100, [1 8/10 45.79/100]);
##
##figure;
##step(t0, 'r--');
##hold on;
##step(t3);
