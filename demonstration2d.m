% Created by Yakimenko G.K.

clear;
clc;
close all;

%--------------------------------------------------------------------------
%           Approximation 2D function demonstration
%--------------------------------------------------------------------------
% SET THE FUNCTION ARGUMENTS:

x = (0:2:10)';

% SET FUNCTION:

y = sin(2*x)./exp(x/5);

% SET OPTIONS:

accuracy = 0.0001; % required accuracy of approximation
ps = 1; % pause in sec between iterations
printRules = true; % print trained model rules

%==========================================================================
% _____________________________SRC CODE____________________________________

import claster.*

cm = claster();

for i = 1:length(x)
    cm.addExample(x(i), y(i));
end

yc = [];
for i = 1: length(x)
    yc = [yc; cm.eval(x(i))];
end

figure(1);

plot(x, y, '-b', x, yc, '-r');
title("Function training graph");
legend({'Original function','Claster model'},'Location','southwest')
xlabel('x');
ylabel('y');

RMSES = [];
RMSE = rmse(y, yc, "all");
RMSES(length(RMSES)+1) = RMSE;

disp(['RMSE = ',  num2str(RMSE)]);

iteration = 1;
while RMSE > accuracy
    pause(ps);
    disp('-------------------------------')
    disp(['ITERATION: ', num2str(iteration)]);
    cm.norm();
    yc = [];
    for i = 1: length(x)
        yc = [yc; cm.exec(x(i))];
    end

    figure(1);
    plot(x, y, '-b', x, yc, '-r');
    title("Function training graph");
    legend({'Original function','Claster model'},'Location','southwest')
    xlabel('x');
    ylabel('y');

    RMSE = rmse(y, yc, "all");
    RMSES(length(RMSES)+1) = RMSE;
    disp(['RMSE = ',  num2str(RMSE)]);
    iteration = iteration + 1;
end

if printRules
    figure(3);
    cm.plotRules();
end

RMSE_I = 1:1:length(RMSES);
figure(2);
plot(RMSE_I, RMSES);
title("RMSE graph");
xlabel('Iteration');
ylabel('RMSE');