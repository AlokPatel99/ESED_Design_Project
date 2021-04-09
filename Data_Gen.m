%% ------------ ECSE-549: ESED - Project ---------- %%
% This file is used to create the data set for the training of the NN.



%% --- Creating Inputs for the equations and storing data --- %%

%Number of examples are set at N_ex
N_ex = 5000;

%constant values
fill_factor = 0.5; %fill facotr of core
uo = 4*pi*1e-7; %free space permeability 
%eta_r = 1000; %relative permeablilty; depends on the type of core materials
%i = 2.5; %constnat current
%{
%Random generation of Inductance Value
lmin = 100e-6;
lmax = 100e-3;
Lip = (lmin - lmax)*rand(1,N_ex) + lmax;
%}
%Random generation of Turns
Nmin = 5;
Nmax = 60;
Nop = randi([Nmin, Nmax],1,N_ex);
%{
%Random generation of depth of the core
dmin = 0.5;
dmax = 1.5;
dop = (dmin - dmax) + rand(1,N_ex) + dmax;
%}
%Random generation of height of the core
hmin = 2e-2;
hmax = 5e-2;
hop = (hmin - hmax) + rand(1,N_ex) + hmax;

%Random generation of widht of the core
wmin = 2e-2;
wmax = 5e-2;
wop = (wmin - wmax)*rand(1,N_ex)  + wmax;

%Random generation of cross-sectional area of the core
Acmin = 0.5e-4;
Acmax = 1e-4;
Acip = (Acmin - Acmax)*rand(1,N_ex)  + Acmax;

%Setting up other cross sectional area for the core
A_back = Acip;
A_top = Acip;
A_pole = Acip;
A_air = Acip;

%Setting up the width of core or the thickness of core from
%all direction as it is similar.
d = sqrt(Acip);
tw = d;
tc = tw;
tg = tc;

%Material of core 
% 1. corresponds to the Silicon Steal material
% 2. corresponds to the Ferrites material
mat_core = [1,2];
material = ["Silicon Steel","Ferrites"];
ur = [1000,500];

%Random generation of area to fit Inductor
Amin = 4e-4;
Amax = 30.25e-4;
Aip = (Amin - Amax)*rand(1,N_ex)  + Amax;

%Random generation of the air gap length
lgmin = 1e-3;
lgmax = 5e-3;
lgop = (lgmin - lgmax)*rand(1,N_ex) + lgmax;

%Type of the cable wire(gugae 16 to 20 are taken)
%Guage 16 cable have dia of 1.290, similarly other guage cables are listed.

guage_set = [16,17,18,19,20];
d_wire = 1e-3*[1.2903, 1.1506, 1.0236, 0.9119, 0.8128];
Acwire = pi*((d_wire/2).^2);

%Random generation of the maximum current
imin = 0;
imax = 3.7;
Imax = (imin - imax)*rand(1,N_ex) + imax;

%% --- Getting ouput from equations and storing data --- %%
% Two for loops, one with 5 different wire and other with two core material

%Other important variables for solving equations are set below
TR = zeros(1,N_ex);
L = zeros(1,N_ex);
A_space = zeros(1,N_ex); 
guage_op = zeros(1,N_ex);
Acwire_op = zeros(1,N_ex);
dw = zeros(1,N_ex);
v1 = zeros(1,N_ex);
v2 = zeros(1,N_ex);
cost_op = zeros(1,N_ex);
mat_ip = strings(0);

% Data set for the guage cable type
for i=1:N_ex
    if Imax(i)<1.5
        guage_op(i) = 20;
        Acwire_op(i) = Acwire(5);
        dw(i) = d_wire(5);
    elseif Imax(i)>=1.5 && Imax(i)<1.8
        guage_op(i) = 19;
        Acwire_op(i) = Acwire(4);
        dw(i) = d_wire(4);
    elseif Imax(i)>=1.8 && Imax(i)<2.3
        guage_op(i) = 18;
        Acwire_op(i) = Acwire(3);
        dw(i) = d_wire(3);
    elseif Imax(i)>=2.3 && Imax(i)<2.9
        guage_op(i) = 17;
        Acwire_op(i) = Acwire(2);
        dw(i) = d_wire(2);
    elseif Imax(i)>=2.9 && Imax(i)<3.7
        guage_op(i) = 16;
        Acwire_op(i) = Acwire(1);
        dw(i) = d_wire(1);
    end
end

%While loop will generate in total 5000 data set as n is set at 5000.
i = 0;          %for the index of the array
while i<N_ex             
    for g=1:length(guage_set)
        for m=1:length(mat_core)
            TR(i+1) = reluctance(hop(i+1),tc(i+1),ur(m),uo,A_back(i+1),A_top(i+1),A_pole(i+1),tw(i+1),wop(i+1),tg(i+1),A_air(i+1),lgop(i+1));
            L(i+1) = inductance(Nop(i+1),TR(i+1));
            A_space(i+1) = hop(i+1)*wop(i+1);
            %A_wire(i+1) = wire_func(Wa(i+1),fill_factor,Nop(i+1));
            v1(i+1) = volume_core(hop(i+1),dop(i+1),Acip(i+1),wop(i+1),tw(i+1),tc(i+1),tg(i+1),lgop(i+1));
            v2(i+1) = volume_coil(dw(i+1),tw(i+1),Acwire_op(i+1),Nop(i+1));
            cost_op(i+1) = cost_total(v1(i+1),v2(i+1),mat_core(m));
            mat_ip(i+1) = material(m); %material string vector
            i = i+1;
        end
    end
end

%% --- Data in Excel File --- %%

% Data variables are defined for storing the data

%Inputs for the NN
L_ip_d = L';            %Inductance
mat_ip_d = mat_ip';          %Material
A_core_ip_d = Acip';       %Area of the core crosssectional area
A_space_ip_d = A_space';      %Area of the space available to place the inductor

%Output for the NN
cost_op_d = cost_op';            %Total cost for manufacturing the inductor 
turns_op_d = Nop';           %Turns of the inductor 
L_op_d = L';            %actual inductance calculated according to the design
d_op_d = dop';            %depth of the core
w_op_d = wop';            %width of the core
h_op_d = hop';            %height of the core
A_w_cross_d = Acwire_op';       %Crosssectional area of the wire winding
Imax_ip_d = Imax';          %Maximum current capability of the core
l_g_d = lgop';             %Lenght of the airgap

%inputs write to csv

input_data = [L_ip_d, mat_ip_d, A_core_ip_d, A_space_ip_d,Imax_ip_d]; %matrix input data
T = array2table(input_data);
T.Properties.VariableNames(1:5) = {'Inductance','Material','Cross Sectional Area of Core','Area of the space','Max Current Capability'};
%T.Properties.VariableNames(1:4) = {'Inductance','Material','Cross Sectional Area of Core','Area of the space'};
writetable(T,'CCoreInputData.csv')


%output write csv
output_data = [L_op_d,l_g_d,h_op_d,w_op_d,d_op_d,turns_op_d,cost_op_d,A_w_cross_d]; %matrix output data
S = array2table(output_data);
S.Properties.VariableNames(1:8) = {'Inductance','Air Gap Length','Height','Width','Depth','Number of Turns','Cost','Wire Cross Sectional Area'};
%S.Properties.VariableNames(1:4) = {'Air Gap Length','Height','Width','Number of Turns','Cost','Wire Cross Sectional Area'};
writetable(S,'CCoreOutputData.csv')

%% --- Functions for equations --- %%
%{
function f = flux(mmf,tr)
%FLUX Summary of this function goes here
%   Detailed explanation goes here
    f = mmf/tr;
end
%}
function I = inductance(n,tr)
%INDUCTANCE Summary of this function goes here
%   Detailed explanation goes here
        I = (n^2)/tr;
end
%{
function m = mmf(i,n)
%MMF Summary of this function goes here
%   Detailed explanation goes here
    m = i*n/2;
end
%}
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
%{
function w = wire_func(wa,ku,n)
%WIRE_FUNC Summary of this function goes here
%   Detailed explanation goes here
    w = wa*ku/n;
end
%}
function v2 = volume_coil(dw,tw,Awind,N)
%VOLUME SUMMARY of this function goes here
%   Detailed explaination goes here
    dn = 2*dw + tw;
    v2 = (pi*dn*N)*Awind;
end

function c = cost_total(v1,v2,mat)
%Adding all the cost, fixed cost can be set as percantage
%of the core and winding cost
density = [7.65e3, 5e3];            %density of the core material(kg/m^3)
price = [2.12, 5];                  %price of core material($/kg)
c1 = v1*density(mat)*price(mat);
c2 = v2*8940*9.13;                  %density of copper is 8940 kg/m^3 and cost is 9.13 $/kg
c3 = 0.1*(c1+c2);                   %fixed cost of 10% of overall is considered
c = c1 + c2 + c3; 
end

%% ----- Code END ----- %%%
