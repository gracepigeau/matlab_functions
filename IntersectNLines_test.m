%Intersect-N-Lines Test
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 3
%Grace Pigeau 10187678
%
%Purpose: Test the IntersectNLines function

%Test Case 1:
%Ground Truth with 5 lines where all lines intersect
line1point1a = [1;1;0];
line1point2a = [4;0;-5];
line2point1a = [1;1;0];
line2point2a = [-1;5;0];
line3point1a = [1;1;0];
line3point2a = [2;-4;2];
line4point1a = [1;1;0];
line4point2a = [2;2;2];
line5point1a = [1;1;0];
line5point2a = [7;8;9];
[Intersecta, AvgDista, StdDeva] = IntersectNLines(5, line1point1a, line1point2a, line2point1a, line2point2a, line3point1a, line3point2a, line4point1a, line4point2a, line5point1a, line5point2a);

figure
hold on
title('Intersect-N-Lines Test 1')
xlabel('X')
ylabel('Y')
zlabel('Z')
plotLine(line1point1a, line1point2a)
plotLine(line2point1a, line2point2a)
plotLine(line3point1a, line3point2a)
plotLine(line4point1a, line4point2a)
plotLine(line5point1a, line5point2a)
hold off

%Test Case 2:
%Ground Truth with 4 lines where all lines are parallel
line1point1b = [0;0;0];
line1point2b = [1;1;1];
line2point1b = [3;0;0];
line2point2b = [4;1;1];
line3point1b = [3;0;1];
line3point2b = [4;1;2];
line4point1b = [-1;0;-1];
line4point2b = [0;1;0];
[Intersectb, AvgDistb, StdDevb] = IntersectNLines(4, line1point1b, line1point2b, line2point1b, line2point2b, line3point1b, line3point2b, line4point1b, line4point2b)

figure
hold on
title('Intersect-N-Lines Test 2')
xlabel('X')
ylabel('Y')
zlabel('Z')
plotLine(line1point1b, line1point2b)
plotLine(line2point1b, line2point2b)
plotLine(line3point1b, line3point2b)
plotLine(line4point1b, line4point2b)
hold off

%Test Case 3-13:
%Ground Truth where 2-10 lines are randomly generated 3 times

%initialize a matrix to hold the results for this test
%first column holds the number of lines
%second column holds the average error
%third column holds the standard deviation
results = zeros(9, 3);

%holds the intersection values
intersections = zeros(3,27);

%initialize a row counter
rowcounter = 1;
colcounter = 1;
%cycle through the number of points
for ix = 4:2:20
    
    AvgDist = 0;
    StdDev = 0;
    
    %create 3 example for each number of points
    for jx = 1:3
        
        %generate a matrix to contain the specified number or randomly
        %generated points
        points = rand(3,ix);
        
        %run the function, passing in the specified number of points
        if ix == 4
            [inter, A, S] = IntersectNLines(ix/2, points(:,1), points(:,2), points(:,3), points(:,4));
        elseif ix == 6
            [inter, A, S] = IntersectNLines(ix/2,points(:,1), points(:,2), points(:,3), points(:,4), points(:,5), points(:,6));
        elseif ix == 8
            [inter, A, S] = IntersectNLines(ix/2,points(:,1), points(:,2), points(:,3), points(:,4), points(:,5), points(:,6), points(:,7), points(:,8));
        elseif ix == 10
            [inter, A, S] = IntersectNLines(ix/2,points(:,1), points(:,2), points(:,3), points(:,4), points(:,5), points(:,6), points(:,7), points(:,8), points(:,9), points(:,10));
        elseif ix == 12
            [inter, A, S] = IntersectNLines(ix/2,points(:,1), points(:,2), points(:,3), points(:,4), points(:,5), points(:,6), points(:,7), points(:,8), points(:,9), points(:,10), points(:,11), points(:,12));
        elseif ix == 14
            [inter, A, S] = IntersectNLines(ix/2,points(:,1), points(:,2), points(:,3), points(:,4), points(:,5), points(:,6), points(:,7), points(:,8), points(:,9), points(:,10), points(:,11), points(:,12), points(:,13), points(:,14));
        elseif ix == 16
            [inter, A, S] = IntersectNLines(ix/2,points(:,1), points(:,2), points(:,3), points(:,4), points(:,5), points(:,6), points(:,7), points(:,8), points(:,9), points(:,10), points(:,11), points(:,12), points(:,13), points(:,14), points(:,15), points(:,16));
        elseif ix == 18
            [inter, A, S] = IntersectNLines(ix/2,points(:,1), points(:,2), points(:,3), points(:,4), points(:,5), points(:,6), points(:,7), points(:,8), points(:,9), points(:,10), points(:,11), points(:,12), points(:,13), points(:,14), points(:,15), points(:,16), points(:,17), points(:,18));
        else
            [inter, A, S] = IntersectNLines(ix/2,points(:,1), points(:,2), points(:,3), points(:,4), points(:,5), points(:,6), points(:,7), points(:,8), points(:,9), points(:,10), points(:,11), points(:,12), points(:,13), points(:,14), points(:,15), points(:,16), points(:,17), points(:,18), points(:,19), points(:,20));
        end %end if
        
        intersections(:,colcounter) = inter;
        
        colcounter = colcounter + 1;
        
        AvgDist = AvgDist + A;
        StdDev = StdDev + S;
        
    end %end for jx   
    
    avA = AvgDist / 3;
    avS = StdDev / 3;
    
    %add the average error metric from the function to the results matrix
    results(rowcounter,:) = [ix/2 avA avS];
    
    %increment the row counter
    rowcounter = rowcounter + 1;
    
end %end for ix
    
figure
hold on
title('Intersect-N-Lines Test 3')
xlabel('Number of Lines')
ylabel('Error')
plot(results(:,1),results(:,2))
plot(results(:,1),results(:,3))
legend('Average Distance','Standard Deviation')
hold off
        
        