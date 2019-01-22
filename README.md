# Matlab Functions
A library of mathematical functions implemented in matlab

# Motivation
Project is/was created for CISC 330 at Queen's University for Professor Fichtinger

# Use
This project contains 21 matlab files 8 main files, 8 testing files, and 5 helper functions

# Functions
## 1. DistanceOfLineAndPoint

Function which finds the Euclidean distance between a line and a point.
  
## 2. IntersectTwoLines

Function which calculates the symbolic intersection of two lines. Each line as defined at two points.

## 3. IntersectNLines

Function which computes the symbolic intersection of a specified number of lines. Each line is defined as two points. 

## 4. IntersectLineEllipsoid

Function which computes the intersection (if any) of a line and ellipsoid. The line is defined as two points, and the ellipsoid as a centre point and three principal axes. 

## 5. SphereReconstruction

This function reconstructs a sphere from N points which are created by randomly displacing points on a given sphere. The sphere is defined as a centre point and radius. The points were generated on the sphere using the Polar Coordinate system. The randomly generated points are a no further from the surface of the Northern hemisphere of a sphere than a specified maximum distance.  

## 6. LineReconstruction

This function reconstructs a line from N points which are created by randomly displacing points on a given sphere. The line is defined as two points. New points were generated along the line by randomizing the scalar t in the line equation. The randomly generated points are a no further from the line than a specified maximum distance. 

## 7. OthonormalCoordinateSystem

This function computes an orthonormal coordinate system from three points. The coordinate system is defined by an orthonormal vector base and a centre point. 

## 8. RigidBodyTransform

This function computes the transformation matrix responsible for moving the set of fiducial markers from one location to another. The transformation matrix is a 4x4 matrix which is a combination of a translation and rotation matrix. The error metric is as the average fiducial localization error (FLE), the average fiducial registration error (FRE), and target registration error of the centre point (cTRE). 
