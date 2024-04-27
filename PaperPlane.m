%	Example 1.3-1 Paper Airplane Flight Path
%	Copyright 2005 by Robert Stengel
%	August 23, 2005
close all; clear; clc;

global CL CD S m g rho	
S		=	0.017;			% Reference Area, m^2
AR		=	0.86;			% Wing Aspect Ratio
e		=	0.9;			% Oswald Efficiency Factor;
m		=	0.003;			% Mass, kg
g		=	9.8;			% Gravitational acceleration, m/s^2
rho		=	1.225;			% Air density at Sea Level, kg/m^3	
CLa		=	3.141592 * AR/(1 + sqrt(1 + (AR / 2)^2));
						% Lift-Coefficient Slope, per rad
CDo		=	0.02;			% Zero-Lift Drag Coefficient
epsilon	=	1 / (3.141592 * e * AR);% Induced Drag Factor	
CL		=	sqrt(CDo / epsilon);	% CL for Maximum Lift/Drag Ratio
CD		=	CDo + epsilon * CL^2;	% Corresponding CD
LDmax	=	CL / CD;			% Maximum Lift/Drag Ratio
Gam_1	=	-atan(1 / LDmax);	% Corresponding Flight Path Angle, rad
Gam_2   =   -.5;
Gam_3   =   .4;
V_1		=	sqrt(2 * m * g /(rho * S * (CL * cos(Gam_1) - CD * sin(Gam_1))));
V_2     =   2;
V_3     =   7.5; % Corresponding Velocity, m/s
Alpha	=	CL / CLa; % Corresponding Angle of Attack, rad

H		=	2;			% Initial Height, m
R       =	0;			% Initial Range, m
R_max   =   25;
to		=	0;			% Initial Time, sec
tf		=	6;			% Final Time, sec
tspan	=	[to tf];

%% Implementation of height vs range for changing variables.
x0		=	[V_1;Gam_1;H;R];
[ta,xa]	=	ode23('EqMotion',tspan,x0);
x1		=	[V_1;Gam_2;H;R];
[tb,xb]	=	ode23('EqMotion',tspan,x1);
x2		=	[V_1;Gam_3;H;R];
[tc,xc]	=	ode23('EqMotion',tspan,x2);	
y1      =   [V_2;Gam_1;H;R];
[ta2,xa2]	=	ode23('EqMotion',tspan,y1);
y2      =   [V_3;Gam_1;H;R];
[tb2,xb2]	=	ode23('EqMotion',tspan,y2);

% Plotting the data and making it pretty
figure; subplot(2,1,1); hold on;
plot(xa(:,4),xa(:,3),'k',xb(:,4),xb(:,3),'r',xc(:,4),xc(:,3),'g')
title('Height Vs. Range For Varying Gammas')
xlabel('Range, m'), ylabel('Height, m'), grid
legend(sprintf("γ_1 (Gam_1=%g)", Gam_1),...
   sprintf("γ_2 (Gam_2=%g)", Gam_2),...
   sprintf("γ_3 (Gam_3=%g)", Gam_3));  

subplot(2,1,2); hold on;
plot(xa(:,4),xa(:,3),'k',xa2(:,4),xa2(:,3),'r',xb2(:,4),xb2(:,3),'g')
title('Height Vs. Range For Varying Velocities')
xlabel('Range, m'), ylabel('Height, m'), grid
legend(sprintf("Velocity_1 (V_1=%g)", V_1),...
   sprintf("Velocity_2 (V_2=%g)", V_2),...
   sprintf("Velocity_3 (V_3=%g)", V_3));   

%% 100 Iterations with random numbers for time and range
figure; hold on;
t_range=linspace(.1,6,100);
for i=1: 100 
    V_rand = V_2 + (V_3-V_2)*rand(1);
    Gam_rand = Gam_2 + (Gam_3-Gam_2)*rand(1);

    xo = [V_rand;Gam_rand;H;R];
    [t_rand,x_rand]	=	ode23('EqMotion',t_range,xo);

    plot(x_rand(:,4),x_rand(:,3));
    title('Height v. Range With 100 Iterations of Random Perameters');
    xlabel('Range, m'), ylabel('Height, m'), grid

end

%% Applying a polyfit to the data
p1=polyfit(t_rand,x_rand(:,4),5);
f1=polyval(p1,t_rand);
p2=polyfit(t_rand,x_rand(:,3),5);
f2=polyval(p2,t_rand);

% Time derivatives for average height and range
figure; hold on;
subplot(2,1,1)
plot(t_rand,f1,'c')
title('Time vs Range Curve Fit')
xlabel('Time, s'), ylabel('Range, m'), grid
subplot(2,1,2)
plot(t_rand,f2,'m')
title('Time vs Height Curve Fit')
xlabel('Time, s'), ylabel('Height, m'), grid

% Time derivatives
dhdt=diff(f1)./diff(t_rand);
drdt=diff(f2)./diff(t_rand);

figure; hold on
subplot(2,1,1)
plot(t_rand(2:end),drdt,'c');
title('dr vs dt')
xlabel('Time, s'), ylabel('Range, m'), grid
hold on;
subplot(2,1,2)
plot(t_rand(2:end),dhdt,'m');
title('dh vs dt')
xlabel('Time, s'), ylabel('Height, m'), grid    

%% GIF for 2D trajectory (Range v. Height)
gif_filename = 'glider_trajectory.gif';

y_max = [V_3;Gam_3;H;R];
[t_max,x_max] =	ode23('EqMotion',tspan,y_max);

figure; hold on; grid on;
line_nominal = animatedline('Color','k');
line_max = animatedline('Color','g');
axis([0,25,-2,4]);
xlabel('Range, m'); ylabel('Height, m'); 
title('Glider 2D Trajectory: Nominal and Upper Bound Values');
legend(sprintf('Max Bounds: V = %.2f m/s, \\gamma = %.2f rad', V_3, Gam_3), sprintf('Nominal: V = %.2f m/s, \\gamma = %.2f rad', V_1, Gam_1));

% Read in glider image
glider_img = 'Glider Solidworks Screenshot.png';   
[inPlot,~,alpha] = imread(glider_img); 
inPlot = flipud(inPlot); 
alpha = flipud(alpha);
imgsize = [4 1];

% Gets current coordinates for the image 
glider_x1 = [-0.5 0.5]*imgsize(1) + x_max(1,3);
glider_y1 = [-0.5 0.5]*imgsize(2) + x_max(1,4);
p1 = image(glider_x1,glider_y1,inPlot);
p1.AlphaData = alpha; 

glider_x2 = [-0.5 0.5]*imgsize(1) + xa(1,3);
glider_y2 = [-0.5 0.5]*imgsize(2) + xa(1,4);
p2 = image(glider_x2,glider_y2,inPlot);
p2.AlphaData = alpha; 

% Plot the trajectory point by point for nominal velocity & gamma
for i = 1:length(x_max)
    addpoints(line_nominal,x_max(i,4),x_max(i,3));
    p1.XData = [-0.5 0.5]*imgsize(1) + x_max(i,4);
    p1.YData = [-0.5 0.5]*imgsize(2) + x_max(i,3);

    if i <= length(xa)
        addpoints(line_max,xa(i,4), xa(i,3));
        p2.XData = [-0.5 0.5]*imgsize(1) + xa(i,4);
        p2.YData = [-0.5 0.5]*imgsize(2) + xa(i,3);
    end

    drawnow;
    pause(0.075);
    exportgraphics(gca,'glider_trajectory.gif','Append',true);
end
