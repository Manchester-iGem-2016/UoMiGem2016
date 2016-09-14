function [mse] = mse_fn(V1, V2)
%Calculates the mean squared error between curve based on overlapping sections to use for comparison.
    %Needs a minimum of 2 points for each vector but the more the better.
    %Vector needs to be in the form V(1,:) = x, V(2,:) = y

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
    error('No suitable overlap range.')
end

xsample = linspace(minx,maxx, 100);         %Divide into equally spaced points
Vq1 = interp1(V1(1,:),V1(2,:),xsample);     %Interpolate values for those points
Vq2 =interp1(V2(1,:),V2(2,:),xsample);
mse = sum((Vq1-Vq2).^2)/length(Vq1);        %Mean squared error on the points



