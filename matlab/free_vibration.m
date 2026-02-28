%% 1st PROJECT 1 DOF Mass-Spring-Damper System: Free,Step and Harmonic Excitations
% Case A: Free Vibration 
% Damping coefficient = 0.2
% System: Industrial anti-vibration mount

clc
clear all
close all

% System Parameters
m = 10;                                    % mass [kg]
k = 160;                                   % stiffness [N/m]

% Damping ratio 
zeta_under = 0.2;                          % underdamped ratio [/]

% Damping <oefficient calculation
c_under = round(2*zeta_under*sqrt(k*m));   % underdamped coefficient [Ns/m]

% Simulink model naming
model = 'MKC_open_loop';

% Assigning damping coefficient value
c=c_under;                                 % underdamped coefficient [Ns/m]

% Initial conditions
x0= 0.1;                                   % initial displacement [m]
v0 = 0;                                    % initial velocity [m/s]

% Forces
F_step = 0;                                % Step force [N]
Amplitude = 0;                             % Harmonic amplitude [N]
omega = 0;                                 % frequency [rad/s]

% Time
step=0;                                    % step time [s]
time_sim=8;                                % simulation time [s]

% Simulation esecution
out = sim(model);
time=out.tout;                             % time array [s]
displacement=out.displacement;             % displacement array [m]
velocity=out.velocity;                     % velocity array [m/s]
acceleration=out.acceleration;             % acceleration array [m/s²]

%%plot section
figure
hold on
set(gcf,'Units','normalized','Position',[0.1 0.1 0.4 0.8]) 

% plot: Displacement [cm] vs time
subplot(3,1,1); 
grid on
plot(time, displacement*100,'LineWidth',1.8); 
ylim([-8,15])
ylabel({'x','[cm]'});
title('Displacement (x_0 = 10 cm)')

% plot: Velocity [cm/s] vs time
subplot(3,1,2);
grid on
plot(time, velocity*100,'r','LineWidth',1.8); 
ylim([-50,40])
ylabel({'v','[cm/s]'});
title('Velocity (v_0 = 0 cm/s)')

% plot: Acceleration [m/s²] vs time
subplot(3,1,3); 
grid on
plot(time, acceleration,'k','LineWidth',1.8); 
ylabel({'a','[m/s$^2$]'},'Interpreter','latex');
ylim([-2.8,1.9])
xlabel('Time [s]');
title('Acceleration')
sgtitle(    {'Project #1: Open-Loop Mass-Spring-Damp System ',...
             'Case A: Free Vibrations' ...
             'Damping ratio ζ = 0.2'},...
             'FontSize', 12,...
             'FontWeight', 'bold');

