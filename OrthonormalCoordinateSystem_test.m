%Orthonormal-Coordinate-System Test
%CISC 330 - Computer Integrated Surgery 
%Assignment 1 Question 7
%Grace Pigeau 10187678
%
%Purpose: Test the OrthonormalCoordinateSystem

%Test Case 1:
%General, easy-to-visualize 
A1 = [0;0;0];
B1 = [1;0;0];
C1 = [0;1;0];
[c1, x1, y1, z1] = OrthonormalCoordinateSystem(A1,B1,C1);

figure
hold on
title('Orthonormal-Coordinate-System Test 1')
xlabel('X')
ylabel('Y')
zlabel('Z')
plotPoint(A1)
plotPoint(B1)
plotPoint(C1)
plotLine(c1, x1)
plotLine(c1, y1)
plotLine(c1, z1)
hold off

%Test Case 2:
%General, easy-to-visualize 
A2 = [-3;-3;1];
B2 = [1;-3;1];
C2 = [-3;3;1];

[c2, x2, y2, z2] = OrthonormalCoordinateSystem(A2,B2,C2)

figure
hold on
title('Orthonormal-Coordinate-System Test 2')
xlabel('X')
ylabel('Y')
zlabel('Z')
plotPoint(A2)
plotPoint(B2)
plotPoint(C2)
plotLine(c2, x2)
plotLine(c2, y2)
plotLine(c2, z2)
hold off