%% ------------ ECSE-549: ESED - Project ---------- %%
% This file is used to create the data set for the training of the NN.


%% --- Functions for equations --- %%

%constant values
fill_factor = 0.5; %fill facotr of core
uo = 4*pi*1e-7; %free space permeability
%eta_r = 1000; %relative permeablilty; depends on the type of core materials
i = 2.5; %constnat current

function f = flux(mmf,tr)
%FLUX Summary of this function goes here
%   Detailed explanation goes here
    f = mmf/tr;
end

function I = inductance(n,tr)
%INDUCTANCE Summary of this function goes here
%   Detailed explanation goes here
        I = (n^2)/tr;
end

function m = mmf(i,n)
%MMF Summary of this function goes here
%   Detailed explanation goes here
    m = i*n/2;
end

function R = reluctance(h,tc,ur,uo,A_back,A_top,A_pole,tw,w,tg,A_air,lg)
%RELUCTANCE Summary of this function goes here
%   Detailed explanation goes here
    TLCR = (tc / (2*ur*A_back*uo)) + (tw / 2*A_top*ur*uo) ; %top-left core reluctance 
    TCR = (w - tw - tg)/(A_top*ur*uo); %top core releuctance
    TRCR = (tg / 2*A_top*ur*uo) + (tc / 2*A_pole*ur*uo);%top right core reluctance 
    PR = (h - lg - 2*tc)/(2*A_pole*ur*uo); %pole reluctance
    AGR = lg/(2*A_air*uo); %air gap reluctance
    BCR = (h - 2*tc)/(2*ur*A_back*uo); %back reluctance
    R = TLCR + TCR + TRCR + PR + AGR + BCR;  %total reluctance
end

function v = volume_core(h,d,A_core,w,tw,tc,tg,lg)
%VOLUME Summary of this function goes here
%   Detailed explanation goes here
    v = h*d*A_core + 2*(w - tw)*tc*A_core + (h - 2*tc - lg)*tg*A_core;
end

function w = wire_func(wa,ku,n)
%WIRE_FUNC Summary of this function goes here
%   Detailed explanation goes here
    w = wa*ku/n;
end

%% --- Creating Inputs for the equations and storing data --- %%




%% --- Getting ouput from equations and storing data --- %%


%% --- Data in Excel File --- %%


%% ----- Code END ----- %%%
