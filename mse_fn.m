function [mse] = mse_fn(V1, V2)
%--------------------------------------------------------------------------
%Calculate the mean squared error between the overlapping section of 2
%curves defined by V1 and V2 and returns this value.
%
%---------------------------------Inputs-----------------------------------
%V1 = Curve 1, V1 is an ix2 matrix where: Column 1 = x values
%                                         Column 2 = y values
%V2 = Curve 2, V2 is an jx2 matrix where: Column 1 = x values
%                                         Column 2 = y values
%---------------------------------Outputs----------------------------------
%mse = The value of the mean squared error between the overlapping region
%of the 2 curves.
%
%------------------------------Dependancies--------------------------------
%No dependancies
%--------------Written by Matthew Davies & Toby Summerill------------------
%-----------------University of Manchester iGEM 2016-----------------------
%--------------------------------------------------------------------------

%Error checking on inputs
%An error will be thrown and the code will stop running if:
%       V1 or V2 is empty
%       The curves have no overlaping regions
if isempty(V1) == 1 || isempty(V2)== 1
    error('mse_fn: Inputs cannot be empty');
end
if min(V1(1,:)) >= min(V2(1,:))             %Determine the minimum value to check
    minx = min(V1(1,:));
else
    minx = min(V2(1,:));
end
if max(V1(1,:)) >= max(V2(1,:))             %Determine the maximum value to check
    maxx = max(V2(1,:));
else
    maxx = max(V1(1,:));
end
if maxx <= minx                             %Ensure there is a range being checked
    error('mse_fn: No suitable overlap range.')
end

xsample = linspace(minx,maxx, 100);         %Divide into equally spaced points
Vq1 = interp1(V1(1,:),V1(2,:),xsample);     %Interpolate values for those points
Vq2 =interp1(V2(1,:),V2(2,:),xsample);
mse = sum((Vq1-Vq2).^2)/length(Vq1);        %Mean squared error on the points



