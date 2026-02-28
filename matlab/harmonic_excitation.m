%% 1st PROJECT 1 DOF Mass-Spring-Damper System: Free,Step and Harmonic Excitations
% Case C: Harmonic excitation
% Damping coefficients= 0.2 - 1 - 2
% System: Industrial anti-vibration mount

clc
clear all
close all

% System Parameters
m = 10;                                    % mass [kg]
k = 160;                                   % stiffness [N/m]

% Damping ratio [/]
zeta_under = 0.2;                          % underdamped ratio 
zeta_critical = 1;                         % critically-damped ratio
zeta_over = 2;                             % overdamped ratio

% Damping <oefficient calculation
c_under = round(2*zeta_under*sqrt(k*m));        % underdamped coefficient [Ns/m]
c_critical = round(2*zeta_critical*sqrt(k*m));  % critically-damped coefficient [Ns/m]
c_over = round(2*zeta_over*sqrt(k*m));          % overdamped coefficient [Ns/m]

% Simulink model naming
model = 'MKC_open_loop';

% Assigning damping coefficient value
c_vec=[c_under,c_critical,c_over];          % damping coefficients array

% Initial conditions
x0= 0;                                      % initial displacement [m]
v0 = 0;                                     % initial velocity [m/s]

% Forces
F_step = 0;                                 % Step force [N]
Amplitude = 5;                              % Harmonic amplitude [N]
omega_n = sqrt(k/m);                        % natural frequency [rad/s]
omega = 1.5*sqrt(k/m);                      % harmonic forcing frequency [rad/s]

% Step time
step=1;                                     % step time [s]
time_sim=8;                                 % simulation time [s]

% Preallocation of displacement,velocity and acceleration matrix
dt=0.01;                                    % delta time_sim [s]
N=time_sim/dt+1;                            % time array size [s]
x=zeros(N,3);                               % preallocation of displacement matrix
v=zeros(N,3);                               % preallocation of velocity matrix
a=zeros(N,3);                               % preallocation of acceleration matrix

% Simulation loop
for i = 1:length(c_vec)
    c = c_vec(i);
    out = sim(model);                       % Simulation execution
    x(:,i)=out.displacement;                % Displacement Data output      
    v(:,i)=out.velocity;                    % Velocity Data output
    a(:,i)=out.acceleration;                % Acceleration Data output
    
end

time=out.tout;                              % Time array Data output
Harmonic=out.force;                         % Harmonic Data output

% Resonance analysis
omega_vec=(0:0.01:8);                       % Frequency range [0.5 rad/s-8 rad/s]                           
zeta_vec=[zeta_under,zeta_critical,zeta_over];

% Preallocation of transmissibility matrix
trans=zeros(length(omega_vec),size(zeta_vec,2));

for j=1:size(zeta_vec,2);
    trans(:,j)=1./sqrt((1-(omega_vec./omega_n).^2).^2+(2*zeta_vec(j).*omega_vec./omega_n).^2)
end

%%plot section
labels={'ζ=0.2','ζ=1','ζ=2'};
figure
set(gcf,'Units','normalized','Position',[0.1 0.1 0.6 0.8])

% plot: Step Force [N] vs time
subplot(2,2,1);
hold on
grid on
plot(time, Harmonic,'LineWidth',1.2); 
xlim([0,time_sim])
ylim([-10,10])
xlabel('Time [s]');
ylabel({'F','[N]'});
title('Harmonic Force')

% plot: Displacement [cm] vs time
subplot(2,2,[3 4]);
hold on
grid on
plot(time, x(:,1)*100,'LineWidth',1.2); % posizione [cm]
plot(time, x(:,2)*100,'r','LineWidth',1.2); % posizione [cm]
plot(time, x(:,3)*100,'k','LineWidth',1.2); % posizione [cm]
xlim([0,time_sim])
ylim([-4,6])
xlabel('Time [s]');
ylabel({'x','[cm]'});
title('Displacement (x_0 = 0 cm)')
legend(labels,'Location','best');

% plot: Transmissiblity [/] vs frequency
subplot(2,2,2);
hold on
grid on
plot(omega_vec,trans(:,1),'LineWidth',1.2); 
plot(omega_vec,trans(:,2),'r','LineWidth',1);
plot(omega_vec,trans(:,3),'k','LineWidth',1);
xline(omega_n, 'k--', 'LineWidth', 1.5);         % natural frequency [rad/s] 
text(omega_n-0.65, max(trans(:,1))*0.8, '\omega_n', 'FontSize',12) 
xlim([0,omega_vec(end)])
ylim([0,3])
xlabel('\omega [rad/s]');
ylabel({'T','[/]'});
title('Transmissibility')
legend(labels,'Location','best');

%subplot(3,1,4);
%hold on
%grid on
%plot(time, v(:,1)*100,'LineWidth',1); % velocità [cm/s]
%plot(time, v(:,2)*100,'r','LineWidth',1); % velocità [cm/s]
%plot(time, v(:,3)*100,'k','LineWidth',1); % velocità [cm/s]
%xlim([0,time_sim])
%ylim([-30,35])
%xlabel('Time [s]');
%ylabel({'v','[cm/s]'});
%title('Velocity (v_0 = 0 cm/s)')
%legend(labels,'Location','best');

%subplot(3,1,5);
%hold on
%grid on
%plot(time, a(:,1),'LineWidth',1); % accelerazione in m/s²
%plot(time, a(:,2),'r','LineWidth',1); % accelerazione in m/s²
%plot(time, a(:,3),'k','LineWidth',1); % accelerazione in m/s²
%xlim([0,time_sim])
%ylim([-1.5,2])
%xlabel('Time [s]');
%ylabel({'a','[m/s$^2$]'},'Interpreter','latex');
%title('Acceleration')
%legend(labels,'Location','best');

sgtitle(    {'Project #1: Open-Loop Mass-Spring-Damp System ',...
             'Case C: Harmonic Force' ...
             'Under/Critical/Over-damped System'},...
             'FontSize', 12,...
             'FontWeight', 'bold');