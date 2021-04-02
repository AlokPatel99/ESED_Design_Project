%% ------------ ECSE-549: ESED - Project ---------- %%
% This file is used to create the data set for the training of the NN.



%% --- Creating Inputs for the equations and storing data --- %%

%constant values
fill_factor = 0.5; %fill facotr of core
uo = 4*pi*1e-7; %free space permeability 
%eta_r = 1000; %relative permeablilty; depends on the type of core materials
i = 2.5; %constnat current

%Random generation of Inductance Value
lmin = 100e-6;
lmax = 100e-3;
Lip = (lmin - lmax)*rand(1,5000) + lmax;

%Random generation of Turns
Nmin = 5;
Nmax = 60;
Nop = randi([Nmin, Nmax],1,5000);

%Random generation of depth of the core
dmin = 0.5;
dmax = 1.5;
dop = (dmin - dmax) + rand(1,5000) + dmax;

%Random generation of height of the core
hmin = 2;
hmax = 5;
hop = (hmin - hmax) + rand(1,5000) + hmax;

%Random generation of widht of the core
wmin = 2;
wmax = 5;
wop = (wmin - wmax)*rand(1,5000)  + wmax;

%Random generation of cross-sectional area of the core
Acmin = 0.5;
Acmax = 2;
Acip = (Acmin - Acmax)*rand(1,5000)  + Acmax;

%Material of core 
% 1. corresponds to the Silicon Steal material
% 2. corresponds to the Ferrites material
mat_core = [1,2];

%Random generation of area to fit Inductor
Amin = 4;
Amax = 30.25;
Aip = (Amin - Amax)*rand(1,5000)  + Amax;

%Random generation of the air gap length
lgmin = 1e-3;
lgmax = 5e-3;
lgop = (lgmin - lgmax)*rand(1,5000) + lgmax;

%Type of the cable wire(gugae 16 to 20 are taken)
%Guage 16 cable have dia of 1.290, similarly other guage cables are listed.

guage_set = [16,17,18,19,20];
d_wire = 1e-3*[1.2903, 1.1506, 1.0236, 0.9119];
Acwire = pi*((d_wire/2).^2);

%% --- Getting ouput from equations and storing data --- %%


%% --- Data in Excel File --- %%



%% --- Functions for equations --- %%

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

function v1 = volume_core(h,d,A_core,w,tw,tc,tg,lg)
%VOLUME Summary of this function goes here
%   Detailed explanation goes here
    v1 = h*d*A_core + 2*(w - tw)*tc*A_core + (h - 2*tc - lg)*tg*A_core;
end

function w = wire_func(wa,ku,n)
%WIRE_FUNC Summary of this function goes here
%   Detailed explanation goes here
    w = wa*ku/n;
end

function v2 = volume_coil(dw,tw,Awind,N)
%VOLUME SUMMARY of this function goes here
%   Detailed explaination goes here
    dn = 2*dw + tw;
    v2 = (pi*dn*N)*Awind;
end

function c = cost_total()
%Adding all the cost, fixed cost can be set as percantage
%of the core and winding cost

%c = c1 + c2 + c3 
end

%% ----- Code END ----- %%%
