%Sphere-Reconstruction Test
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 5
%Grace Pigeau 10187678
%
%Purpose: Test the SphereReconstruction function

%set the input variables
C = [0;0;0];
R = 100;
N = 25;

%initialize a matrix to store the results
%first column holds the maxOff value
%second column holds the average distance
%third column holds the standard deviation
errormetric = zeros(11,3);

%reconstruct the sphere with the above centre and radius, setting the
%maximum distances of the randomly generated points to the surface of the
%sphere as values between 0 and 10
for maxOff = 0:10

    %return the error metric from the sphere reconstruction
    [centre,radius,AvgDist,StdDev] = SphereReconstruction(C, R, N, maxOff);
    
    %create a variable which holds the centre and radius for the sphere
    %when maxOff is zero to confirm that they are exactly the same as the
    %input
    if maxOff == 10
        check10centre = centre
        check10radius = radius
        check10dist = AvgDist
        check10std = StdDev
    end
    
    %add the error metric to the results matrix
    errormetric(maxOff+1,:) = [maxOff AvgDist StdDev];
end

figure
hold on
title('Sphere-Reconstruction')
xlabel('maxOff')
ylabel('Error')
plot(errormetric(:,1),errormetric(:,2))
plot(errormetric(:,1),errormetric(:,3))
legend('Average Distance', 'Standard Deviation')
hold off


