%% ------------ ECSE-549: ESED - Project ---------- %%
% This file is used to train and test the NN.

%Note: 
%1) For the crosssectional area of the copper, we will check the area
%   and accordingly set the guage and store as o/p.
%2) For input, if the the space is greater than 30.25 cm^2, then can take
%   the random from range or the max one. 

%%
input_to_NN = (readtable('CCoreInputData.csv'))';
output_of_NN = (readtable('CCoreOutputData.csv'))';

net = feedforwardnet;
%net = fitnet;
net.trainFcn = 'trainlm';

net.name = "C-Core Design Assistant Neural Network";
net.divideFcn = 'divideblock';
net.divideParam.trainRatio = 40/100;
net.divideParam.valRatio = 30/100;
net.divideParam.testRatio = 30/100;
net = configure(net,input_to_NN,output_of_NN);

net = train(net,input_to_NN,output_of_NN);




%% ----- Code END ----- %%%
