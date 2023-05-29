clear;
clc;
close all;

x = (0:0.1:10)';
y = sin(2*x)./exp(x/5);

% genOpt = genfisOptions('GridPartition');
% genOpt.NumMembershipFunctions = 10;
% genOpt.InputMembershipFunctionType = 'gaussmf';
% inFIS = genfis(x,y, genOpt);
% 
% opt = anfisOptions('InitialFIS',inFIS);
% opt.DisplayANFISInformation = 0;
% opt.DisplayErrorValues = 0;
% opt.DisplayStepSize = 0;
% opt.DisplayFinalResults = 0;
% 
% outFIS = anfis([x y],opt);
% 
% plot(x,y,x,evalfis(outFIS,x))
% legend('Training Data','ANFIS Output')

options = genfisOptions('GridPartition');
options.NumMembershipFunctions = 5;
fisin = genfis(x,y,options);
[in,out,rule] = getTunableSettings(fisin);

opt = tunefisOptions("Method","anfis");
fisout = tunefis(fisin,[in;out],x,y,opt);

plot(x,y,x,evalfis(fisout,x))
legend('Training Data','ANFIS Output')
