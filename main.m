clear;
clc;
close all;

import claster.*

cm = claster();

% %-----------------------------
% %         SOME FUNC
% %-----------------------------

x = (0:0.4:100)';
y = sin(2*x)./exp(x/5);

for i = 1:length(x)
    cm.addExample(x(i), y(i));
end



yc = [];
for i = 1: length(x)
    yc = [yc; cm.eval(x(i))];
end

figure(1)
plot(x, y, '-b', x, yc, '-r');

eMkv = (y-yc).^2;               % квадрат ошибки аппрокс.в узловых точкаx
NeM = numel(yc);                % общее количество контрольных точек
RMSE = sqrt(sum(eMkv)/NeM);       % среднеквадратичное значение ошибки

disp(['RMSE = ',  num2str(RMSE)])

iteration = 1;
while RMSE > 1e-8
    pause(1);
    disp('-------------------------------')
    disp(['ITERATION: ', num2str(iteration)]);
    cm.norm();
    yc = [];
    for i = 1: length(x)
        yc = [yc; cm.eval(x(i))];
    end

    figure(1)
    plot(x, y, '-b', x, yc, '-r');

    eMkv = (y-yc).^2;               % квадрат ошибки аппрокс.в узловых точкаx
    NeM = numel(yc);                % общее количество контрольных точек
    RMSE = sqrt(sum(eMkv)/NeM);       % среднеквадратичное значение ошибки
    disp(['RMSE = ',  num2str(RMSE)]);
    iteration = iteration + 1;
end

% hold on
% plot(x, yc);


% figure(2)
% xt = 0:0.1:10;
% for i = 1:length(cm.functions)
%     yt = [];
%     for j = 1:length(xt)
%         yt = [yt, cm.functions(i, 1).eval(xt(j))];
%     end
%     
%     plot(xt, yt, '-');
%     hold on;
% end

% for i = 1:length(x)
%     
%     disp(['-----', num2str(i), '-----']);
%     disp(['x: ', num2str(cm.examplesX(i,1))]);
%     disp(['l: ', num2str(cm.functions(i,1).l)]);
%     disp(['c: ', num2str(cm.functions(i,1).c)]);
%     disp(['h: ', num2str(cm.functions(i,1).h)]);
%     disp(['w: ', num2str(cm.weights(i))]);
%    
% end





%-----------------------------
%         SOME FUNC 2
%-----------------------------

% x = (0:0.1:10)';
% y = 10*sin(x);
% 
% for i = 1:length(x)
%     cm.addExample(x(i), y(i));
% end
% 
% 
% 
% 
% yc = [];
% for i = 1: length(x)
%     yc = [yc, cm.eval(x(i))];
% end
% 
% plot(x, y);
% hold on
% plot(x, yc);
% 
% for i = 1:length(x)
%     
%     disp(['-----', num2str(i), '-----']);
%     disp(['l: ', num2str(cm.functions(i,1).l)]);
%     disp(['c: ', num2str(cm.functions(i,1).c)]);
%     disp(['h: ', num2str(cm.functions(i,1).h)]);
%     disp(['w: ', num2str(cm.weights(i))]);
%    
% end

%-----------------------------
%           X-SQUARE
%-----------------------------

% x = (0:0.1:10)';
% xt = (0:0.1:10)';
% y = x.^2;
% 
% for i = 1:length(x)
%     cm.addExample(x(i), y(i));
%     cm.norm();
% end
% 
% 
% 
% yc = [];
% for i = 1: length(xt)
%     yc = [yc, cm.eval(xt(i))];
% end
% 
% plot(x, y);
% hold on
% plot(xt, yc);
% 
% for i = 1:length(x)
%     
%     disp(['-----', num2str(i), '-----']);
%     disp(['l: ', num2str(cm.functions(i,1).l)]);
%     disp(['c: ', num2str(cm.functions(i,1).c)]);
%     disp(['h: ', num2str(cm.functions(i,1).h)]);
%     disp(['w: ', num2str(cm.weights(i))]);
%    
% end

%-----------------------------
%           LINEAR
%-----------------------------


% cm.addExample(1, 5);
% cm.norm();
% cm.addExample(2, 4);
% cm.norm();
% cm.addExample(4, 2);
% cm.norm();
% 
% cm.exec(3)




