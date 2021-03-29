%% plot aerodynamics of NACA 0012,0016,0020
close all
clc
alpha = linspace(0,20,100);

%% Lift Coefficient----------------

slope = [5.63,6.05,4.51];
Cl = zeros(length(slope),length(alpha));

for i = 1:length(slope)
    Cl(i,:) = slope(i) * deg2rad(alpha);
end

figure(1)
plot(alpha, Cl(1,:), 'r', alpha, Cl(2,:), 'b', alpha, Cl(3,:), 'g', 'LineWidth',1)
title('Section lift coefficient vs AoA');
xlabel('$\alpha [^{\circ}]$','fontSize', 15, 'interpreter','latex');
ylabel('$C_l$','fontSize', 15,'interpreter','latex');
grid minor
legend({'NACA0012','NACA0016','NACA0020'},'interpreter','latex','fontSize',12);
legend('location','best')
saveas((1),'lift_coeff.png')


%% Drag Coefficient-------------
% CC = K*slope^2.....Then Cd = Cd0+ CC*alpha^2

Cd0 = [0.0061,0.0076,0.0090];
CC = [0.538,0.302,0.184];
Cd = zeros(length(slope),length(alpha));

 for j = 1:length(slope)
    Cd(j,:) = Cd0(j) + CC(j)*deg2rad(alpha).^2;
 end

figure(2)
plot(alpha, Cd(1,:), 'r', alpha, Cd(2,:), 'b', alpha, Cd(3,:), 'g', 'LineWidth',1)
title('Section drag coefficient vs AoA');
xlabel('$\alpha [^{\circ}]$','fontSize', 15, 'interpreter','latex');
ylabel('$C_d$', 'interpreter','latex','fontSize', 15);
grid minor
legend({'NACA0012','NACA0016','NACA0020'},'interpreter','latex','fontSize',12);
legend('location','best')
saveas((2),'drag_coeff.png')
 