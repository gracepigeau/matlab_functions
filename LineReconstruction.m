%Line-Reconstruction
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 6
%Grace Pigeau 10187678
%
%Purpose:   Simulate points and reconstruct a line
%Input:     line (two 3x1 vectors)
%           number of points to generate (scalar)
%           max distance (scalar)
%Output:    line (two 3x1 vectors)
%           average distance (scalar)
%           standard deviation (scalar)
%Citations:
%           Line 67-69: Matt J, June 2013
%           https://www.mathworks.com/matlabcentral/answers/78363-3d-line-of-best-fit

function [newPoint, newVector, avg, stdev] = LineReconstruction(point1, point2, n, maxoff)

    figure
    hold on
    title('Line-Reconstruction')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    
    plot3([point1(1,1);point2(1,1)],[point1(2,1);point2(2,1)],[point1(3,1);point2(3,1)], 'red')
    
    %create the direction vector of the line passed into the function
    vector = point2 - point1;
    
    %initialize two matrices with zeros to hold the randomly generated
    %points, and the distances from these points to the new line
    randpoints = zeros(3,n);
    distances = zeros(1,n);
    
    %create a for loop to create n randomly generated points
    for ix = 1:n
        
        %generate a vector with x,y,z as random numbers in range -1 to 1
        vmin = -1;
        vmax = 1;
        v =(vmax-vmin).*rand(3,1) + vmin;
        
        %generate a random value between 0 and 1 for t
        t = rand;
        
        %generate a random point on the line
        temppoint = point1 + t*vector;
        
        %find the vector perpendicular to the original line direction
        %vector and the randomly generated vector v
        vcross = cross(vector,v);

        %make vcross a unit vector
        vcross = vcross / norm(vcross);
        
        %randomly generate a number between the negative max offset and
        %positive max offset which will be the distance from the line to
        %the randomly generated point
        offmin = (-1)*maxoff;
        offmax = maxoff;
        dist = (offmax-offmin).*rand + offmin;
        
        %offset the randomly generated point from the line
        randpoint = temppoint + dist * vcross;
        
        scatter3(randpoint(1,1), randpoint(2,1), randpoint(3,1), 'black', 'fill') 
        
        %add the offset point to a matrix
        randpoints(:,ix) = randpoint;

    end %end for
    
    %find a point on the new line by averaging all the points
    newPoint = mean(randpoints, 2);
    
    %reconstruct a line based on the randomly generated points and their
    %average point and get the direction vector from the reconstructed line
    tempvar = bsxfun(@minus, randpoints.', newPoint.');
    [~,~,vReconstructed] = svd(tempvar, 0);
    newVector = vReconstructed(:,1);
    newVector = newVector/norm(newVector);
    
    %scatter3(newPoint(1,1), newPoint(2,1), newPoint(3,1), 'blue')

    %generate two points on the reconstructed line near the points from the
    %original line
    newPoint1 = newPoint + (norm(vector)/(-2))*newVector;
    newPoint2 = newPoint + (norm(vector)/2)*newVector;
    
    plotLine(newPoint1, newPoint2)
    
    %find the distance from each randomly generated point to the
    %reconstructed line and store in a matrix
    for kx = 1:n
        diff = DistanceOfLineAndPoint(randpoints(:,kx), newPoint1, newPoint2);
        distances(:,ix) = diff;
    end
    
    %find the error metric:
    %average and standard deviation of the distances from the randomly
    %generated points to the reconstructed line
    avg = round(mean(distances), 10);
    stdev = round(std(distances), 10);
    
    hold off
            
    