%Intersect-N-Lines
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 3
%Grace Pigeau 10187678
%
%Purpose:   Compute the symbolic (approx.) intersection of N lines
%Input:     number of lines (scalar)
%           N lines (N 3x1 vectors)
%Output:    intersection (3x1 vector)
%           average distance (scalar)
%           standard deviation (scalar)

function [intersect, avgdist, stddev] = IntersectNLines(varargin)
    %this function uses MATLABs built in varargin which can take a variable
    %number of parameters as an input in a cell array

    %take the first parameter from varargin which is the number of lines
    numlines = varargin{1};
    
    %the number of points is twice the number of lines
    numpoints = numlines*2;
    
    %calculate how many different pairs of lines the intersection will need
    %to be found for (numlines choose 2)
    numpairs = (numlines * (numlines-1)) / 2;
    
    %initialize a matrix which will store the intersection points for every
    %pair of lines
    allintersections = zeros(3,numpairs);
    
    %set the number of intersections found so far to zero
    pairssofar = 0;
    
    %starting at the first line, cycle through every line until the second
    %last (skip 2 because 1 line is two points)
    for ix = 2:2:(numpoints-1)
        
        %starting at the line immediately following the first line, cycle
        %through every line until the end (skip 2 because 1 line is two points)
        for jx = (ix+2):2:numpoints
            
            %find the intersection point of the line specified by ix
            %points and jx points
            [tempintersect, ~] = IntersectTwoLines(varargin{ix}, varargin{ix+1}, varargin{jx}, varargin{jx+1});
            
            %if the two lines selected are parallel
            if isempty(tempintersect) == 1
                
                %remove the column which would hold that intersection from the intersections matrix 
                allintersections = [allintersections(:,1:pairssofar) allintersections(:,pairssofar+2:end)];
            
            else
                
                %keep track of the number of intersections found
                pairssofar = pairssofar + 1;

                %add the intersection point to the matrix
                %using the pairssofar variable as an index
                allintersections(:,pairssofar) = tempintersect;
                
            end %end if 
        end %end for jx
    end %end for ix
    
    %if there are no intersections because all lines were parallel
    if isempty(allintersections) == 1
        
        %set all the function outputs to null and tell the user what
        %happened
        intersect = [];
        avgdist = 0;
        stddev = 0;
        disp('All input lines are parallel')
        
    else
        
        %find the average point (centre of gravity) for the matrix containing
        %the intersection points
        intersect = mean(allintersections, 2);
        
        %initialize a matrix to hold the distances from lines to the intersect
        distmatrix = zeros(1,numlines);
        %initialize a column counter
        currline = 1;   

        %find the distance from every line to the intersection points and store
        %them in a matrix
        for ix = 2:2:(numpoints)
            temperror = DistanceOfLineAndPoint(intersect, varargin{ix}, varargin{ix+1});
            distmatrix(1,currline) = temperror;
            currline = currline + 1;
        end %end for

        %calculate the average distance from the intersection to the lines
        %and round to ten decimal points
        avgdist = round(mean(distmatrix), 10);

        %calculate the standard deviation of the distance from the intersection
        %to the lines and round to 10 decimal points
        stddev = round(std(distmatrix), 10);
        
    end %end if
    
    
    

    
        
        
        
    
    