%set three points which will be the intial location of the feducial markers
marker1a = [1;2;0]; 
marker2a = [6;2;3];
marker3a = [2;5;0];


figure
hold on
title('Rigid-Body-Transform Translation & Rotation')
xlabel('X')
ylabel('Y')
zlabel('Z')
scatter3(marker1a(1,1),marker1a(2,1),marker1a(3,1), 'red')
scatter3(marker2a(1,1),marker2a(2,1),marker2a(3,1), 'red')
scatter3(marker3a(1,1),marker3a(2,1),marker3a(3,1), 'red')
scatter3(2,3,1, 'blue')
scatter3(7,3,4, 'blue')
scatter3(3,6,1, 'blue')
hold off

%find the minimum side of the triangle created by the first set of markers
minside = min([DistBtwnPoints(marker1a, marker2a) DistBtwnPoints(marker1a, marker3a) DistBtwnPoints(marker2a, marker3a)]);

%translation matrix to be used in ground truths
t = [1 0 0 1; 0 1 0 1; 0 0 1 1; 0 0 0 1];
%rotation matrix to be used in ground truths
r = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
%transformation matrix to be used in ground truths
f = t*r

%creates a matrix to hold all the results
%first column holds the FLE
%second column holds the calculated FLE
%third column holds the average FRE
%fourth column holds the centre target error
resultsFLE = zeros(15,4);

rowcount = 1;
%cycle through the different percent values 0,5,10,15,20
for ix = 0:5:20
    
    %generate the FLE as the specified persent of the min side
    FLE = (ix/100)*minside;
    
    %initialize a matrix to hold the FLE displacement vectors
    FLEvectors = zeros(3,12);
    
    %create twelve randomly generate, normalized vectors
    for jx = 1:12
        FLEvector = rand(3,1);
        FLEvectornorm = FLEvector / norm(FLEvector);
        FLEvectors(:,jx) = FLEvectornorm;
    end
    
    %displace each marker at location a
    marker1a = marker1a + FLE*FLEvectors(:,1);
    marker2a = marker2a + FLE*FLEvectors(:,2);
    marker3a = marker3a + FLE*FLEvectors(:,3);

    %Ground Truth One: translation
    marker1b_1 = t*[marker1a;1];
    marker1b_1 = marker1b_1(1:3,1) + FLE*FLEvectors(:,4);
    marker2b_1 = t*[marker2a;1];
    marker2b_1 = marker2b_1(1:3,1) + FLE*FLEvectors(:,5);
    marker3b_1 = t*[marker3a;1];
    marker3b_1 = marker3b_1(1:3,1) + FLE*FLEvectors(:,6);

    [transform_1, AvgFLE_1, AvgFRE_1, CtrTRE_1] = RigidBodyTransform(marker1a, marker2a, marker3a, marker1b_1, marker2b_1, marker3b_1); 
    
    %Ground Truth Two: rotation
    marker1b_2 = r*[marker1a;1];
    marker1b_2 = marker1b_2(1:3,1) + FLE*FLEvectors(:,7);
    marker2b_2 = r*[marker2a;1];
    marker2b_2 = marker2b_2(1:3,1) + FLE*FLEvectors(:,8);
    marker3b_2 = r*[marker3a;1];
    marker3b_2 = marker3b_2(1:3,1) + FLE*FLEvectors(:,9);

    [transform_2, AvgFLE_2, AvgFRE_2, CtrTRE_2] = RigidBodyTransform(marker1a, marker2a, marker3a, marker1b_2, marker2b_2, marker3b_2);

    %Ground Truth Three: translation and rotation
    marker1b_3 = f*[marker1a;1];
    marker1b_3 = marker1b_3(1:3,1) + FLE*FLEvectors(:,10);
    marker2b_3 = f*[marker2a;1];
    marker2b_3 = marker2b_3(1:3,1) + FLE*FLEvectors(:,11);
    marker3b_3 = f*[marker3a;1];
    marker3b_3 = marker3b_3(1:3,1) + FLE*FLEvectors(:,12);

    [transform_3, AvgFLE_3, AvgFRE_3, CtrTRE_3] = RigidBodyTransform(marker1a, marker2a, marker3a, marker1b_3, marker2b_3, marker3b_3);

    %store the results of the three ground truths with the given FLE in the
    %results matrix and increment the row counter
    resultsFLE(rowcount,:) = [FLE AvgFLE_1 AvgFRE_1 CtrTRE_1]; 
    resultsFLE(rowcount+1,:) = [FLE AvgFLE_2 AvgFRE_2 CtrTRE_2]; 
    resultsFLE(rowcount+2,:) = [FLE AvgFLE_3 AvgFRE_3 CtrTRE_3]; 
    rowcount = rowcount + 3;
    
end

figure
hold on
title('Rigid-Body-Transform Translation')
xlabel('FLE')
ylabel('Error')
plot([resultsFLE(1,1);resultsFLE(4,1);resultsFLE(7,1);resultsFLE(10,1);resultsFLE(13,1)], [resultsFLE(1,2);resultsFLE(4,2);resultsFLE(7,2);resultsFLE(10,2);resultsFLE(13,2)])
plot([resultsFLE(1,1);resultsFLE(4,1);resultsFLE(7,1);resultsFLE(10,1);resultsFLE(13,1)], [resultsFLE(1,3);resultsFLE(4,3);resultsFLE(7,3);resultsFLE(10,3);resultsFLE(13,3)])
plot([resultsFLE(1,1);resultsFLE(4,1);resultsFLE(7,1);resultsFLE(10,1);resultsFLE(13,1)], [resultsFLE(1,4);resultsFLE(4,4);resultsFLE(7,4);resultsFLE(10,4);resultsFLE(13,4)])
legend('Average FLE', 'Average FRE', 'Target Error')
hold off

figure
hold on
title('Rigid-Body-Transform Rotation')
xlabel('FLE')
ylabel('Error')
plot([resultsFLE(2,1);resultsFLE(5,1);resultsFLE(8,1);resultsFLE(11,1);resultsFLE(14,1)], [resultsFLE(2,2);resultsFLE(5,2);resultsFLE(8,2);resultsFLE(11,2);resultsFLE(14,2)])
plot([resultsFLE(2,1);resultsFLE(5,1);resultsFLE(8,1);resultsFLE(11,1);resultsFLE(14,1)], [resultsFLE(2,3);resultsFLE(5,3);resultsFLE(8,3);resultsFLE(11,3);resultsFLE(14,3)])
plot([resultsFLE(2,1);resultsFLE(5,1);resultsFLE(8,1);resultsFLE(11,1);resultsFLE(14,1)], [resultsFLE(2,4);resultsFLE(5,4);resultsFLE(8,4);resultsFLE(11,4);resultsFLE(14,4)])
legend('Average FLE', 'Average FRE', 'Target Error')
hold off
    
figure
hold on
title('Rigid-Body-Transform Translation & Rotation')
xlabel('FLE')
ylabel('Error')
plot([resultsFLE(3,1);resultsFLE(6,1);resultsFLE(9,1);resultsFLE(12,1);resultsFLE(15,1)], [resultsFLE(3,2);resultsFLE(6,2);resultsFLE(9,2);resultsFLE(12,2);resultsFLE(15,2)])
plot([resultsFLE(3,1);resultsFLE(6,1);resultsFLE(9,1);resultsFLE(12,1);resultsFLE(15,1)], [resultsFLE(3,3);resultsFLE(6,3);resultsFLE(9,3);resultsFLE(12,3);resultsFLE(15,3)])
plot([resultsFLE(3,1);resultsFLE(6,1);resultsFLE(9,1);resultsFLE(12,1);resultsFLE(15,1)], [resultsFLE(3,4);resultsFLE(6,4);resultsFLE(9,4);resultsFLE(12,4);resultsFLE(15,4)])
legend('Average FLE', 'Average FRE', 'Target Error')
hold off

