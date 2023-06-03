clear;
clc;
close all;

import claster.*

cm = claster();

% %-----------------------------
% %         SOME FUNC
% %-----------------------------

x = (0:0.1:10)';
y = sin(2*x)./exp(x/5);

for i = 1:length(x)
    cm.addExample(x(i), y(i));
end

cm.train(0.0001);

yc = [];
for i = 1: length(x)
    yc = [yc; cm.exec(x(i))];
end

figure(1)
plot(x, y, '-b', x, yc, '-r');

