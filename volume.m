function v = volume(h,d,A_core,w,tw,tc,tg,lg)
%VOLUME Summary of this function goes here
%   Detailed explanation goes here
    v = h*d*A_core + 2*(w-tw)*tc*A_core + (h-2*tc - lg)*tg*A_core;
end

