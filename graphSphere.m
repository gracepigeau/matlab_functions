function [] = graphSphere(centre, radius)
    [x,y,z] = sphere();
    surf(radius*(x+centre(1)),radius*(y+centre(2)),radius*(z+centre(3)));