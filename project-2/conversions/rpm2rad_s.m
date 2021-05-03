function [w_rad_s] = rpm2rad_s(w_rpm)
% rpm2rad_s transforms an angular velocity from rpm t o rad/s
%
% INPUTS
%                   w_rpm, angular velocity [rpm]
%
% OUTPUTS
%                 w_rad_s, angular velocity [rad/s]
%    
%%
        w_rad_s = w_rpm*2*pi/60;
    
end
