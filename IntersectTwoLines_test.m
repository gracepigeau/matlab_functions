%Intersect-Two-Lines Test
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 2
%Grace Pigeau 10187678
%
%Purpose: Test the IntersectTwoLines function

%Test Case 1:
%Ground Truth where the two lines intersect at the origin
line1point1a = [0;0;0];
line1point2a = [4;0;0];
line2point1a = [0;0;0];
line2point2a = [0;5;0];
[intersecta, errora] = IntersectTwoLines(line1point1a, line1point2a, line2point1a, line2point2a);

figure
hold on
title('Intersect-Two-Lines Test 1')
xlabel('X')
ylabel('Y')
zlabel('Z')
plotLine(line1point1a, line1point2a)
plotLine(line2point1a, line2point2a)
hold off

%Test Case 2:
%Ground Truth where the two lines do not intersect
line1point1b = [0;0;-1];
line1point2b = [4;0;-1];
line2point1b = [0;0;1];
line2point2b = [0;5;1];
[intersectb, errorb] = IntersectTwoLines(line1point1b, line1point2b, line2point1b, line2point2b);

figure
hold on
title('Intersect-Two-Lines Test 2')
xlabel('X')
ylabel('Y')
zlabel('Z')
plotLine(line1point1b, line1point2b)
plotLine(line2point1b, line2point2b)
hold off

%Test Case 3:
%Ground Truth where the two lines are parallel
line1point1c = [0;0;0];
line1point2c = [1;1;1];
line2point1c = [3;0;0];
line2point2c = [4;1;1];
[intersectc, errorc] = IntersectTwoLines(line1point1c, line1point2c, line2point1c, line2point2c)

figure
hold on
title('Intersect-Two-Lines Test 3')
xlabel('X')
ylabel('Y')
zlabel('Z')
plotLine(line1point1c, line1point2c)
plotLine(line2point1c, line2point2c)
hold off
