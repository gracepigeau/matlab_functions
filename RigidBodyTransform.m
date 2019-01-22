%Rigid-Body-Transform
%CISC 330 - Computer Integrated Surgery
%Assignment 1 Question 8
%Grace Pigeau 10187678
%
%Purpose:   Determine the transformation applied to move a set of three
%           markers between two positions
%Input:     fiducial markers (four 3x1 vectors) 
%Output:    transformation (4x4 matrix)
%           average feducial localization error (scalar)
%           average feducial registration error (scalar)
%           centre target registration error (scalar)
%Citations:
%           Lines 24-25: Geoff Hayes, Sept. 2014
%           https://www.mathworks.com/matlabcentral/answers/154626-convert-negative-zero-of-matrix-into-zero
    
function [transform, AvgFLE, AvgFRE, CtrTRE] = RigidBodyTransform(marker1a, marker2a, marker3a, marker1b, marker2b, marker3b)
    
    %find the orthogonal vector base and centre point for both sets of markers
    [vcentre, v1, v2, v3] = OrthonormalCoordinateSystem(marker1a, marker2a, marker3a);
    [ecentre, e1, e2, e3] = OrthonormalCoordinateSystem(marker1b, marker2b, marker3b);
    
    %use matlab built in function to get the transformation matrix from
    %vector base v to e
    %this function assumes the two vector bases are at the same location
    [~, ~, transf] = procrustes([e1 e2 e3],[v1 v2 v3]);
    
    %extract the rotation matrix from the transformation matrix
    %only want the rotation matrix because no scaling occurs and transf is
    %created by assuming the vector basis are in the same spot
    rotate = transf.T;
    %pad the rotation matrix to make it 4x4
    rotatem = [rotate(1,:) 0; rotate(2,:) 0; rotate(3,:) 0; 0 0 0 1];
    
    %the translation vector is what must be added to markers at location a 
    %to shift them to location b
    vcentrerotated = rotate*vcentre;
    translate = (ecentre-vcentrerotated);
    %pad the translation vector to create a 4x4 translation matrix
    translatem = [1 0 0 translate(1,1); 0 1 0 translate(2,1); 0 0 1 translate(3,1); 0 0 0 1];
    
    %the transformation matrix from point a to point b if the
    %transformation matrix multiplied by the rotation matrix
    transform = translatem * rotatem;
    
    %remove any negative zeros from the transformation matrix
    tol = 1.e-6;
    transform(transform<0 & transform>-tol) = 0;
    
    %calculated the result of the transformation matrix applied to all of
    %the original points
    marker1b_calc = (transform*[marker1a;1]);
    marker2b_calc = (transform*[marker2a;1]);
    marker3b_calc = (transform*[marker3a;1]);
    
    %initialize a matrix to hold the distances between the points at
    %calculted b and the input of b
    markerFRE = zeros(1,3);
    
    %find the distance between the point at location b and transformed a
    %point and add to the matrix
    markerFRE(1,1) = DistBtwnPoints(marker1b, marker1b_calc(1:3,1));
    markerFRE(1,2) = DistBtwnPoints(marker2b, marker2b_calc(1:3,1));
    markerFRE(1,3) = DistBtwnPoints(marker3b, marker3b_calc(1:3,1));
    
    %find the average of the distances and rounnd to 10 decimal places
    AvgFRE = round(mean(markerFRE), 10);
    
    %calculate the centre of gravity of the transformed points
    ecentre_calc = (marker1b_calc + marker2b_calc + marker3b_calc) / 3;
    
    %calculate the distance of the inputted centre of gravity to the newly
    %calculated centre of gravity of the transformed points and round
    CtrTRE = sqrt((ecentre(1,1) - ecentre_calc(1,1))^2 + (ecentre(2,1) - ecentre_calc(2,1))^2 + (ecentre(3,1) - ecentre_calc(3,1))^2);
    CtrTRE = round(CtrTRE, 10);
    
    %calcuate the length of each side of both inputted triangles then find
    %the difference between the line lengths of the triangle at position a
    %and the triangle at position b
    a12 = DistBtwnPoints(marker1a, marker2a);
    b12 = DistBtwnPoints(marker1b, marker2b);
    diff12 = abs(a12-b12);
    a13 = DistBtwnPoints(marker1a, marker3a);
    b13 = DistBtwnPoints(marker1b, marker3b);
    diff13 = abs(a13-b13);
    a23 = DistBtwnPoints(marker2a, marker3a);
    b23 = DistBtwnPoints(marker2b, marker3b);
    diff23 = abs(a23-b23);
    
    %the average FLE is the average difference between the line lengths of
    %the two input triangles
    AvgFLE = (diff12 + diff13 + diff23) / 3;
   