%% ----------------- ECSE-549: ESED - Project ----------------- %%
% This file is used for training and validation of the NN.
% NN trained for the C-Core Inductor design.

%% --- Getting the data for training --- %%

input_to_NN = (readtable('CCoreInputData.csv'));
output_of_NN = (readtable('CCoreOutputData.csv'));

%% --- Converting the data to the variable --- %%

input_data_to_NN = cell2mat((table2cell(input_to_NN))');
output_data_of_NN = cell2mat((table2cell(output_of_NN))');

%% --- Training the NN --- %%

net = feedforwardnet;
%net = feedforwardnet([25,10]);
%net = fitnet;
net.trainFcn = 'trainlm';
%net.trainFcn = 'trainbr';

net.name = "C-Core Design Assistant Neural Network";
net.divideFcn = 'divideblock';
net.divideParam.trainRatio = 40/100;
net.divideParam.valRatio = 30/100;
net.divideParam.testRatio = 30/100;

net = train(net,input_to_NN,output_of_NN);

%% --- Read from JESS and giving its Output --- %%

jess_input_to_NN = (readtable('JessData.csv')); 
jess_input_data_to_NN = cell2mat((table2cell(input_to_NN))');

%input = [Inductance,Material,Cross Sectional Area of Core,Area of the space,MaxCurrentCapability]; 
sizing_info = net(jess_input_data_to_NN); %sizing information from neural network output

%output write csv
output_data = sizing_info;
S = array2table(output_data);
S.Properties.VariableNames(1:8) = {'Inductance','Air Gap Length','Height','Width','Depth','Number of Turns','Cost','Wire Cross Sectional Area'};
writetable(S,'CCoreSizingData.csv')

%% ---- Code Ends --- %%
