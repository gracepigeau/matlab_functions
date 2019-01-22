%Sphere-Reconstruction
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 5
%Grace Pigeau 10187678
%
%Purpose:   Simulate points and reconstruct a sphere
%Input:     sphere centre (3x1 vector)
%           sphere radius (scalar)
%           number of points to generate (scalar)
%           max distance (scalar)
%Output:    sphere centre (3x1 vector)
%           sphere radius (scalar)
%           average distance (scalar)
%           standard deviation (scalar)

function [newCentre, newRadius, avg, stdev] = SphereReconstruction(ctr, radius, n, maxoff)

    %generate an array of zeros to hold the points around the sphere
    randpoints = zeros(3,n);
    %generate an array of zeros to hold the distances from the points to
    %the sphere
    errors = zeros(1,n);
    
    figure
    hold on
    title('Sphere-Reconstruction Original')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    
    graphSphere(ctr, radius)
    
    %create a while loop which runs until n points have been generated
    for ix = 1:n
        
        %set the maximum and minimum values for the radius
        rmin = radius - maxoff;
        rmax = radius + maxoff;
        %randomly generate a new radius within the max and min confines
        newradius = (rmax-rmin).*rand + rmin;
        
        %set the maximum and minimum values for the azimuth angle
        azmin = -180;
        azmax = 180;
        %randomly generate an azimuth angle
        newazangle = (azmax-azmin).*rand + azmin;
        
        %set the maximum and minimum values for the polar angle
        pmin = 0;
        pmax = 90;
        %randomly generate a polar angle
        newpolarangle = (pmax-pmin).*rand + pmin;
        
        %calculate the components of a random point by transforming 
        %the spherical coordinates (angles) to cartesian coordinates
        x = newradius .* cosd(newpolarangle) .* cosd(newazangle);
        y = newradius .* cosd(newpolarangle) .* sind(newazangle);
        z = newradius .* sind(newpolarangle);
        
        %combine x, y, and z to create the new point
        randpoint = [x;y;z];
        
        %transform the point generated so it is on the surface of the
        %sphere by adding the centre point
        randpoint = randpoint + ctr;
        
        scatter3(randpoint(1,1), randpoint(2,1), randpoint(3,1), 'black', 'fill') 
        
        %add the random points to the point matrix
        randpoints(:,ix) = randpoint;
        
    end %end while
    
    %create A matrix 
    randpointsT = randpoints.';
    neg2randpointsT = (-2) * randpointsT;
    colOnes = ones(n,1);
    A = [neg2randpointsT colOnes];

    %create b vector
    b = zeros(n,1);
    for i = (1:n)
        colrandpoints = randpoints(:,i);
        negcolrandpoints = (-1) * colrandpoints;
        dotCol = dot(negcolrandpoints,colrandpoints);
        b(i,1) = dotCol;
    end

    %solve for x using QR decomposition
    [Q,R] = qr(A,0);
    y = (Q.') * b;
    
    %call the back substitute to get the centre point
    x = backsub(R,y);
    newCentre = round(x(1:3,:),10);
    
    %calculate the radius of the circle using sigma
    sigma = x(4,:);
    newRadius = sqrt(dot(newCentre,newCentre) - sigma);
    
    %create a while loop which runs through all n points 
    for ix = 1:n
            
        %calculate the distance from the point to the surface of the sphere
        dist = abs(norm(newCentre-randpoints(:,ix)) - newRadius);

        %add the distance to the error matrix
        errors(:,ix) = round(dist,10);
    end
    
    %calculate the average distance from the points to the original sphere
    avg = mean(errors);
    
    %calculate the average distance of the points from the original sphere
    stdev = std(errors);
    hold off
    
    figure
    hold on
    title('Sphere-Reconstruction Reconstructed')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    %graphSphere(newCentre, newRadius)
    graphSphere((ctr+[.1;.1;.1]), radius-2)
    hold off
    
        
        
    