clear;
clc;
close all;

% import navigationSystem.*
% 
% ns = navigationSystem();
% 
% ns.addExampleMG(10, 0, 1, 1);
% ns.addExampleMG(0, 0, 0, 0);
% 
% ns.addExampleOA(1, 0, 0, 1, 0);
% ns.addExampleOA(0, 1, 0, -1, -1);
% ns.addExampleOA(0, 0, 1, 0, 1);
% 
% ns.train(0.00001);



import claster.*

cm = claster();

% %-----------------------------
% %         SOME FUNC
% %-----------------------------

x = (0:0.2:10)';
y = x.^2;

for i = 1:length(x)
    cm.addExample(x(i), y(i));
end

cm.train(0.001);

yc = [];
for i = 1: length(x)
    yc = [yc; cm.exec(x(i))];
end

figure(1)
plot(x, y, '-b', x, yc, '-r');


genOpt = genfisOptions('GridPartition');
genOpt.NumMembershipFunctions = 5;
genOpt.InputMembershipFunctionType = 'trimf';
inFIS = genfis(x,y,genOpt);

opt = anfisOptions('InitialFIS',inFIS);
opt.DisplayANFISInformation = 0;
opt.DisplayErrorValues = 0;
opt.DisplayStepSize = 0;
opt.DisplayFinalResults = 0;

outFIS = anfis([x y],opt);

figure(3);
plot(x,y,x,evalfis(outFIS,x));
legend('Training Data','ANFIS Output');

