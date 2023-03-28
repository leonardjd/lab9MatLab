% Calculate line throught points
%      delta pixel coordinates
%       X2         X1   
pts = [60         219;
       105        191;
       111        170;
       119        162;
       123        157;
       127        156];
D = [12;24;36;48;60;72];
%Linear m 2091.17,  y intercept -0.53

% pts = [83.44	209.36;
%         110.81    185.50
%         110.46    163.43
%         105.49    145.55
%         130.91    163.13
%         130.04    157.01
% ];
% D = [24;36;48;60;72;84];


%        X2      X1
% pts = [106.45     195.35;
%         126.49    185.42;
%         131.44    175.23;
%         135.56    170.26;
%         137.48    166.22;
%         143.17    167.73
% ];
%Distance in inches
%D = [24;36;48;60;72;84];

pts = pts(:,2) - pts(:,1)  

dP = [pts  ones(size(pts,1),1)];   %Linear
dPP = [ones(size(pts,1),1)  pts  ones(size(pts,1),1)]; %Quad
for(i=1:size(dP,1))
    dP(i,1) = 1/dP(i,1);
    dPP(i,2) = dP(i,1);
    dPP(i,1) = dP(i,1)*dP(i,1);
end
dP
dPP
par1 = dP\D;                %slope and y intercept
par2 = dPP\D;               %quadratic, slope, and y intercept
m = par1(1);
b = par1(2);
fprintf(1,'Linear m %5.2f,  y intercept %5.2f\n',m,b);
Dcalc = m*dP(:,1) + b*ones(size(D))
%Plot Dcalc vs dP and D vs dP
figure(1);
plot(dP(:,1),D);
hold on;
plot(dP(:,1),Dcalc);
hold off;
title('Robot #Home Linear');
xlabel('1 / Pixel Separation');
ylabel('Distance (inches)');
legend('Measured','Calculated','Location','Southeast');
figure(2);
plot(dP(:,1), D);
title('Robot #Home');
xlabel('1 / Pixel Separation');
ylabel('Pixel Separation');

a = par2(1);            %quadratic
m2 = par2(2);           %slope
b2 = par2(3);           %y intercept
fprintf(1,'Quadratic a %5.3f  m %5.2f,  y intercept %5.2f\n',a,m2,b2);
D2calc = a*dPP(:,1) + m2*dPP(:,2) + b2*ones(size(D))

figure(3);
plot(dP(:,1),D);
hold on;
plot(dP(:,1),D2calc);
hold off;
title('Robot #Home Quadratic');
xlabel('1 / Pixel Separation');
ylabel('Distance (inches)');
legend('Measured','Calculated','Location','Southeast');