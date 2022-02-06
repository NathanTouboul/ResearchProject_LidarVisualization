
function lasers = lidar_shooting(pose_vehicle, range, bearing)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Lidar shooting 
    laser_start = pose_vehicle(1, :);
    laser_end = zeros(size(laser_start)) ;
    
    laser_end(1, 1) = laser_start(1, 1) + range * cos(bearing) ;
    laser_end(1, 2) = laser_start(1, 2) + range * sin(bearing) ;
    

    lasers = zeros(1, 4); 
    lasers(1, 1:2) = laser_start;
    lasers(1, 3:4) = laser_end;
end

