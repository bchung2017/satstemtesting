%% Heat Transfer Homework 3
% Chris Mignano; Yuval Philipson; Brian Chung
%comment number 1

%% ME342 Homework 3 - SETUP
clc;
clear all;
close all;

s = tf('s'); %Laplace Domain

%Constants: 
c_1 = 0.42; % kJ/kg/K
c_2 = 0.384; % kJ/kg/K
c_3 = 0.42; % kJ/kg/K
t_final = 5; %s
dt = 0.01; %s
time = (0:dt:t_final).';
x1 = 0.002; %meters
x2 = 0.003; %meters
x3 = 0.002; %meters
l = 0.3; %meters
w = 0.5; %meters
A = l*w; %sq meters
V_1 = A*x1 ;%m^3
V_2 = A*x2 ;%m^3
V_3 = A*x3 ;%m^3
rho_1 = 8000; %kg/m^3
rho_2 = 8960; %kg/m^3
rho_3 = 8000; %kg/m^3
m_1 = V_1*rho_1; %kg
m_2 = V_2*rho_2; %kg
m_3 = V_3*rho_3; %kg
k1 = 0.017; %kW/m/K
k2 = 0.372; %kW/m/K
k3 = 0.017; %kW/m/K

R1 = x1/k1/A; %K/kW
R2 = x2/k2/A; %K/kW
R3 = x3/k3/A; %K/kW
C1 = c_1*m_1; %kJ/K
C2 = c_2*m_2; %kJ/K
C3 = c_3*m_3; %kJ/K
T_L = (400+273.15); %K
t01 = (400+273.15); %K
t02 = (400+273.15); %K
t03 = (400+273.15); %K
T_R = (100+273.15); %K


F = [(T_L-t01)/s;
    (t01-t02)/s;
    (t02-t03)/s;
    (t03-T_R)/s];

Z = [(1/2*R1+1/C1/s),                            (-1/C1/s),                                    0,                0;
           (-1/C1/s),  (1/C1/s)+(1/2*R1)+(1/2*R2)+(1/C2/s),                            (-1/C2/s),                0;
                   0,                            (-1/C2/s),  (1/C2/s)+(1/2*R2)+(1/2*R3)+(1/C3/s),        (-1/C3/s);
                   0,                                    0,                            (-1/C3/s), (1/2*R3+1/C1/s)];

Q = Z\F

figure(1)
T1 = T_L/s-.5*R1*Q(1);
temp1 = impulse(T1, time); %Impulse response of temperature function
subplot(2,1,1)
plot(time,temp1,'DisplayName',['Temperature over time'])
title('Temperature of Iron Block Over Time');
xlabel('Time (s)');
ylabel('Temperature (°C)');
legend

q = impulse(Q,time); 
subplot(2,1,2)
plot(time,q,'DisplayName',['Heat Transfer over time'])
title('Heat Transfer from Iron Block Over Time');
xlabel('Time (s)');
ylabel('Heat Transfer: q (W/m/K)');
legend



    
    
    