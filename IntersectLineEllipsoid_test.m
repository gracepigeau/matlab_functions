%Intersect-Line-and-Ellipsoid Test
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 4
%Grace Pigeau 10187678
%
%Purpose: Test the IntersectLineEllipsoid function

%Test Case 1:
%Ground Truth where the line never intersects the ellipse
point1a = [0;0;0];
point2a = [1;0;0];
ctra = [-5;-50;-5];
axis1a = 1;
axis2a = 1;
axis3a = 1;
[numa, int1a, int2a] = IntersectLineEllipsoid(point1a, point2a, ctra, axis1a, axis2a, axis3a);

[xa, ya, za] = ellipsoid(ctra(1,1),ctra(2,1),ctra(3,1),axis1a,axis2a,axis3a);

figure
hold on
title('Intersect-Line-and-Ellipsoid Test 1')
xlabel('X')
ylabel('Y')
zlabel('Z')
surf(xa, ya, za)
plotLine(point1a, point2a)
hold off

%Test Case 2:
%Ground Truth where the line intersects the ellipse at two points
point1b = [0;0;0];
point2b = [0;1;0];
ctrb = [0;0;0];
axis1b = 1;
axis2b = 2;
axis3b = 3;
[numb, int1b, int2b] = IntersectLineEllipsoid(point1b, point2b, ctrb, axis1b, axis2b, axis3b);

[xb, yb, zb] = ellipsoid(ctrb(1,1),ctrb(2,1),ctrb(3,1),axis1b,axis2b,axis3b);

figure
hold on
title('Intersect-Line-and-Ellipsoid Test 2')
xlabel('X')
ylabel('Y')
zlabel('Z')
surf(xb, yb, zb)
plotLine(5*point1b, -5*point2b)
hold off

%Test Case 3:
%Ground Truth where the line insects the ellipse at one point (tangent)
point1c = [1;1;0];
point2c = [1;0;0];
ctrc = [0;0;0];
axis1c = 1;
axis2c = 1;
axis3c = 1;
[numc, int1c, int2c] = IntersectLineEllipsoid(point1c, point2c, ctrc, axis1c, axis2c, axis3c)

[xc, yc, zc] = ellipsoid(ctrc(1,1),ctrc(2,1),ctrc(3,1),axis1c,axis2c,axis3c);

figure
hold on
title('Intersect-Line-and-Ellipsoid Test 2')
xlabel('X')
ylabel('Y')
zlabel('Z')
surf(xc, yc, zc)
plotLine(point1c,point2c)
hold off

