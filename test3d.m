clear;
clc;
close all;

import claster.*

cm = claster();

% %-----------------------------
% %         SOME FUNC
% %-----------------------------

x = -2:0.3:2;
y = x';
z = x .* exp(-x.^2 - y.^2);

for i = 1:length(x)
    for j = 1:length(y)
        cm.addExample([x(i), y(j)], z(i,j));
    end
end



cm.train(0.0001);
cm.plotRules();

zt = [];
for i = 1:length(x)
    row = [];
    for j = 1:length(y)
        zt(i,j) = cm.exec([x(i), y(j)]);
    end
end

figure("Name", "А это кто?")
surf(x, y, zt)
figure("Name", "Это я")
surf(x, y, z)

eMkv = (z-zt).^2;               % квадрат ошибки аппрокс.в узловых точках
SeMkv = sum(sum(eMkv));         % сумма квадратов ошибок по всем точкам
NeM = numel(zt);                % общее количество контрольных точек

RMSE_M = sqrt(SeMkv/NeM);

disp(['  RMSE = ',  num2str(RMSE_M)])
F = rmse(z, zt, "all");
disp(F)

% i = 1;
% j =1;
% 
% disp(['X: ', num2str(x(i))]);
% disp(['Y: ', num2str(y(j))]);
% disp(['Z: ', num2str(z(i,j))]);
% disp(['ZT: ', num2str(zt(i, j))]);
% 
% disp('-----------------')
% disp(['W: ', num2str(cm.weights(1))]);
% disp('=====================')
% disp('----x-----')
% disp(['l: ', num2str(cm.functions(i,1).l)]);
% disp(['c: ', num2str(cm.functions(i,1).c)]);
% disp(['h: ', num2str(cm.functions(i,1).h)]);
% disp('----y-----')
% disp(['l: ', num2str(cm.functions(i,2).l)]);
% disp(['c: ', num2str(cm.functions(i,2).c)]);
% disp(['h: ', num2str(cm.functions(i,2).h)]);
   

