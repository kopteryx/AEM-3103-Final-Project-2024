%	Example 1.3-1 Paper Airplane Flight Path
%	Copyright 2005 by Robert Stengel
%	August 23, 2005
    close all;
    clear;
    clc;

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
    V_3     =   7.5;
    % Corresponding Velocity, m/s

    Alpha	=	CL / CLa; % Corresponding Angle of Attack, rad
	
%	a) Equilibrium Glide at Maximum Lift/Drag Ratio
	H		=	2;			% Initial Height, m
	R		=	0;			% Initial Range, m
	to		=	0;			% Initial Time, sec
	tf		=	6;			% Final Time, sec
	tspan	=	[to tf];
	x0		=	[V_1;Gam_1;H;R];
	[ta,xa]	=	ode23('EqMotion',tspan,x0);
    x1		=	[V_1;Gam_2;H;R];
	[ua,ya]	=	ode23('EqMotion',tspan,x1);
    x2		=	[V_1;Gam_3;H;R];
	[va,za]	=	ode23('EqMotion',tspan,x2);	
    y1      =   [V_2;Gam_1;H;R];
    [ub,yb]	=	ode23('EqMotion',tspan,y1);
    y2      =   [V_3;Gam_1;H;R];
    [uc,yc]	=	ode23('EqMotion',tspan,y2);
    figure
    subplot(2,1,1)
    hold on
    plot(xa(:,4),xa(:,3),'k')
    plot(ya(:,4),ya(:,3),'r')
    plot(za(:,4),za(:,4),'g')
    title('Height vs Range for varying Gamma')
	xlabel('Range, m'), ylabel('Height, m'), grid
    legend(sprintf("γ_1 (Gam_1=%g)", Gam_1),...
       sprintf("γ_2 (Gam_2=%g)", Gam_2),...
       sprintf("γ_3 (Gam_3=%g)", Gam_3));  
    subplot(2,1,2)
    hold on
    plot(xa(:,4),xa(:,3),'k')
    plot(yb(:,4),yb(:,3),'r')
    plot(yc(:,4),yc(:,4),'g')
    title('Height vs Range for varying velocity')
	xlabel('Range, m'), ylabel('Height, m'), grid
    legend(sprintf("Velocity_1 (V_1=%g)", V_1),...
       sprintf("Velocity_2 (V_2=%g)", V_2),...
       sprintf("Velocity_3 (V_3=%g)", V_3));   
%	b) Oscillating Glide due to Zero Initial Flight Path Angle
	xo		=	[V_1;0;H;R];
	[tb,xb]	=	ode23('EqMotion',tspan,xo);

%	c) Effect of Increased Initial Velocity
	xo		=	[1.5*V_1;0;H;R];
	[tc,xc]	=	ode23('EqMotion',tspan,xo);

%	d) Effect of Further Increase in Initial Velocity
	xo		=	[3*V_1;0;H;R];
	[td,xd]	=	ode23('EqMotion',tspan,xo);
	figure
	plot(xa(:,4),xa(:,3),xb(:,4),xb(:,3),xc(:,4),xc(:,3),xd(:,4),xd(:,3))
	xlabel('Range, m'), ylabel('Height, m'), grid

	figure
	subplot(2,2,1)
	plot(ta,xa(:,1),tb,xb(:,1),tc,xc(:,1),td,xd(:,1))
	xlabel('Time, s'), ylabel('Velocity, m/s'), grid
	subplot(2,2,2)
	plot(ta,xa(:,2),tb,xb(:,2),tc,xc(:,2),td,xd(:,2))
	xlabel('Time, s'), ylabel('Flight Path Angle, rad'), grid
	subplot(2,2,3)
	plot(ta,xa(:,3),tb,xb(:,3),tc,xc(:,3),td,xd(:,3))
	xlabel('Time, s'), ylabel('Altitude, m'), grid
	subplot(2,2,4)
	plot(ta,xa(:,4),tb,xb(:,4),tc,xc(:,4),td,xd(:,4))
	xlabel('Time, s'), ylabel('Range, m'), grid



