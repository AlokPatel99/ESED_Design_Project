function R = reluctance(h,tc,ur,uo,A_back,A_top,A_pole,tw,w,tg,A_air,lg)
%RELUCTANCE Summary of this function goes here
%   Detailed explanation goes here
    TLCR = (tc/(2*ur*A_back*uo)) + (tw/2*A_top*ur*uo) ; %top-left core reluctance 
    TCR = (w - tw - tg)/(A_top*ur*uo); %top core releuctance
    TRCR = (tg/2*A_top*ur*uo) + (tc/2*A_pole*ur*uo);%top right core reluctance 
    PR = (h-lg-2*tc)/(2*A_pole*ur*uo); %pole reluctance
    AGR = lg/(2*A_air*uo); %air gap reluctance
    BR = (h-2*tc)/(2*ur*A_back*uo); %back reluctance
    R = TLCR + TCR + TRCR + PR + AGR + BR;  %total reluctance
end

