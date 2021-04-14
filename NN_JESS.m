%% ------------------ ECSE-549: ESED - Project ------------------ %%
% This file is used for running of the NN, by input from the JESS and
% storing that in another excel file for the feedback.
% The c_core_net_Final.mat is the pretrained NN that is used to get the 
% inductor design parameters as the ouputs.
% In the Excel File named as NN_Input.csv we have the inputs for the NN,
% and the resulting outputs are stored in the NN_Output.csv

%% --- Code Starts --- %%

%CALLING Pretrained NN for getting results
load('c_core_net_Final.mat')              

%Calling the inputs for the NN
data = readmatrix('NN_Input.csv'); 
data(1) = 1e-3*data(1);                   %Converting the Inductance in H from mH

%Running the NN for the given Inputs
output = sim(net,data');                                %Testing the NN for the test data set

%Storing the results in variables to save it in the csv file
L = 1e3*data(1);               %Kept in mH
lg = output(1);
h = output(2);
w = output(3);
d = output(4);
N = output(5);
C = output(6);
Aw = output(7);

output = [L,lg,h,w,d,round(N),C,Aw];                %matrix output data
S = array2table(output);
S.Properties.VariableNames(1:8) = {'Inductance','Air Gap Length','Height','Width','Depth','Number of Turns','Cost','Wire Cross Sectional Area'};
writetable(S,'NN_Output.csv')

%% --- Code Ends --- %%