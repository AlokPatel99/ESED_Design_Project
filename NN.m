

%%
input_to_NN = (readtable('CCoreInputData.csv'));
output_of_NN = (readtable('CCoreOutputData.csv'));
%%
input_data_to_NN = cell2mat((table2cell(input_to_NN))');
output_data_of_NN = cell2mat((table2cell(output_of_NN))');
%%

net = feedforwardnet;
%net = fitnet;
net.trainFcn = 'trainlm';

net.name = "C-Core Design Assistant Neural Network";
net.divideFcn = 'divideblock';
net.divideParam.trainRatio = 40/100;
net.divideParam.valRatio = 30/100;
net.divideParam.testRatio = 30/100;

net = train(net,input_to_NN,output_of_NN);

%%
% i = csvread('Jess Document.csv');
%i(1,:) = Inductance
%i(2,:) = Material
%i(3,:) = Cross_Sectional Area
%i(4,:) = Area of Space
%i(5,:) = Max Current Capability

input = [Inductance,Material,Cross Sectional Area of Core,Area of the space,MaxCurrentCapability];

sizing_info = net(input); %sizing information from neural network output

%output write csv
output_data = sizing_info;
S = array2table(output_data);
S.Properties.VariableNames(1:4) = {'Air Gap Length','Height','Width','Number of Turns','Cost','Wire Cross Sectional Area'};
writetable(S,'CCoreSizingData.csv')
