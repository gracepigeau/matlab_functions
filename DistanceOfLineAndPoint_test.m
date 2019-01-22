%Distance-of-Line-and-Point Test
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 1
%Grace Pigeau 10187678
%
%Purpose: Test the DistanceOfLineAndPoint function

%Test Case 1:
%Ground Truth where line is horizontal and point is off the line
pointa = [0;5;0];
linepoint1a = [0;1;0];
linepoint2a = [3;1;0];
dista = DistanceOfLineAndPoint(pointa, linepoint1a, linepoint2a);

%Test Case 2:
%Ground Truth where point is on the line
pointb = [3;3;3];
linepoint1b = [5;5;5];
linepoint2b = [2;2;2];
distb = DistanceOfLineAndPoint(pointb, linepoint1b, linepoint2b)

figure
hold on
title('Distance-of-Line-and-Point Test 1')
xlabel('X')
ylabel('Y')
zlabel('Z')
plotLine(linepoint1a, linepoint2a)
plotPoint(pointa)
hold off
figure
hold on
title('Distance-of-Line-and-Point Test 2')
xlabel('X')
ylabel('Y')
zlabel('Z')
plotLine(linepoint1b, linepoint2b)
plotPoint(pointb)
hold off


