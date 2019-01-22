%Intersect-Two-Lines
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 2
%Grace Pigeau 10187678
%
%Purpose:   Compute the symbolic (approx.) intersection of two lines
%Input:     line one (two 3x1 vectors)
%           line two (two 3x1 vectors)
%Output:    intersection (3x1 vector)
%           error metric (scalar)

function [intersect, error] = IntersectTwoLines(line1point1, line1point2, line2point1, line2point2)
    
    %find the normalized direction vector for both lines
    line1vector = (line1point1 - line1point2) / norm(line1point1 - line1point2);
    line2vector = (line2point1 - line2point2) / norm(line2point1 - line2point2);
    
    %if the direction vectors are parallel there is no solution
    if cross(line1vector, line2vector) == 0
        disp('Line vectors are parallel, no solution')
        intersect = [];
        error = NaN;
    else
        %use cross product to find the line perpendicular to 
        %both direction vectors
        line3vector = cross(line1vector, line2vector);

        %find the vector between the first point from both lines
        diff = line1point1 - line2point1;

        %create a matrix which contains the vectors for all three lines
        vectormatrix = [(-1)*line1vector line2vector line3vector];

        %calculate the t values for all three lines
        %this solves the three unknowns and solves all three linear equations
        tvector = vectormatrix \ diff;

        %substitute the corresponding t values into the equation for line 1&2
        %to find a new point on each line
        line1newpoint = line1point1 + tvector(1,1) * line1vector;
        line2newpoint = line2point1 + tvector(2,1) * line2vector;

        %find the average of these two points
        %this point is the closest to an intersection possible
        intersect = (line1newpoint + line2newpoint) / 2;

        %calculate the error metric as
        %the distance from line 1 to the intersection point
        error = DistanceOfLineAndPoint(intersect, line1point1, line1point2);
    end
    