clc;
clear;
close all;

% --- DC motor parameters (from handout) ---
J = 0.01; % kg*m^2
b = 0.1; % N*m*s
K = 0.01; % torque/back-EMF constant
R = 1; % Ohm
L = 0.5; % H

s = tf('s');
TF = K / ((J*s + b)*(L*s + R) + K^2); % Voltage -> angular velocity

% === Controller gains (replace with your tuned values) ===
% PI gains
Kp_PI = 23.665;
Ki_PI = 43.66192;
Kd_PI = 0;

% PD gains
Kp_PD = 530.43375;
Ki_PD = 0;
Kd_PD = 91.85;

% PID gains
Kp_PID = 594.048;
Ki_PID = 1971.592;
Kd_PID = 47.6;

% Controllers
C_PI  = pid(Kp_PI, Ki_PI, Kd_PI);
C_PD  = pid(Kp_PD, Ki_PD, Kd_PD);
C_PID = pid(Kp_PID, Ki_PID, Kd_PID);

% Closed-loop systems (unity feedback)
CL_PI  = feedback(C_PI*TF, 1);
CL_PD  = feedback(C_PD*TF, 1);
CL_PID = feedback(C_PID*TF, 1);

% --- Figure: Step responses (separate figures) ---
tfinal = 3; % seconds

figure(1);
step(CL_PI, tfinal);
grid on;
title('Step Response - PI');

figure(2);
step(CL_PD, tfinal);
grid on;
title('Step Response - PD');

figure(3);
step(CL_PID, tfinal);
grid on;
title('Step Response - PID');

% --- Root loci (separate figures) ---
figure(4);
rlocus(C_PI*TF);
grid on;
title('Root Locus - PI');

figure(5);
rlocus(C_PD*TF);
grid on;
title('Root Locus - PD');

figure(6);
rlocus(C_PID*TF);
grid on;
title('Root Locus - PID');

% --- Performance numbers ---
S_PI  = stepinfo(CL_PI);
S_PD  = stepinfo(CL_PD);
S_PID = stepinfo(CL_PID);

disp('Step info - PI:');
disp(S_PI);
disp('Step info - PD:');
disp(S_PD);
disp('Step info - PID:');
disp(S_PID);