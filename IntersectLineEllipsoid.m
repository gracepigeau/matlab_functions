%Intersect-Line-and-Ellipsoid
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 4
%Grace Pigeau 10187678
%
%Purpose:   Determine the point(s) if any where a line intersects an ellipsoid
%Input:     line (two 3x1 vectors)
%           ellipsoid centre point (3x1 vector)
%           ellipsoid principal axes (three scalars)
%Output:    N intersections (scalar)
%           intersection point1 (3x1 vector)
%           intersection point2 (3x1 vector)
%Citations:
%           Line 38: Roger Stafford, Sept. 2013
%           https://www.mathworks.com/matlabcentral/answers/87495-real-roots-of-a-polynomial

function [numint, intersect1, intersect2] = IntersectLineEllipsoid(point1, point2, ctr, a, b, c)

    %get the direction vector for the line described by points 1 and 2
    V = point2 - point1;
    
    %seperate the direction vector into x,y, and z components
    Vx = V(1,1);
    Vy = V(2,1);
    Vz = V(3,1);
    
    %create equations for the x,y, and z components of point1 - the centre
    %of the ellipse
    Nx = point1(1,1) - ctr(1,1);
    Ny = point1(2,1) - ctr(2,1);
    Nz = point1(3,1) - ctr(3,1);
    
    %Mathematically but not coded:
    %Substitute the x,y, and z components of the line equation into the
    %equation for an ellipse and expand and simplify to create a quadratic
    %equation in t. 
    
    %Based on expanded formula rearrange defined variables to create scalar
    %A, B, and C variables which can be substituted into the quadratic
    %equation
    Aeq = Vx^2 * a^(-2) + Vy^2 * b^(-2) + Vz^2 * c^(-2);
    Beq = 2 * (Nx * Vx * a^(-2) + Ny * Vy * b^(-2) + Nz * Vz * c^(-2));
    Ceq = Nx^2 * a^(-2) + Ny^2 * b^(-2) + Nz * c^(-2) - 1;
    
    %calculate the determinant of the quadratic equation
    deter = Beq^2 - 4 * Aeq * Ceq;
    
    %find the solution to the quadratic equation using Aeq, Beq, and Ceq
    tvals = roots([Aeq Beq Ceq]);
    
    %if the determinant is negative there are no real solutions
    if deter < 0
        numint = 0;
        intersect1 = [];
        intersect2 = [];
        
    %if the determinant is positive there are two real solutions
    %calculate these by subing in both values of t to the line equation
    %defined by the original two points
    elseif deter > 0
        numint = 2;
        intersect1 = point1 + tvals(1,1) * V;
        intersect2 = point1 + tvals(2,1) * V;
        
    %if the determinant is zero there is one real solution
    %calculate this by subing in the real value in t to the line equation
    %defined by the original two points
    else
        numint = 1;
        tvals = tvals(imag(tvals)==0);
        intersect1 = point1 + tvals(1,1) * V;
        intersect2 = [];
    end 
    