clear; clc; close all;
%dbstop if error

addpath('functions&classes')

% Initialization parameters
parameters()


%% COMPUTATION - LOOP OVER ALL TIMESTEPS
flag_sections = false;

for t = 2:length(timesteps)

    %  - motion vehicle -- considered perfect knowledge until first
    %  landmmark
    pose_vehicle(t, :) = motion_vehicle(pose_vehicle(t-1, :), speed_vehicle, delta_t); 

    % - lidar shooting -- every angle
    lasers(t, :) = lidar_shooting(pose_vehicle(t, :), range_lidar_detection, bearing); 
    

    % Detection landmarks
    [flag_detection, lasers(t, :), detections] = detection(lasers(t, :), noisy_landmarks, detections, t);
    
    if ismember(t, detections) && flag_sections == false
        % create selected sections of detections
        nb_sections = 10 ;
        [sections, w] = create_trapezoid_sections(pose_vehicle(t, :), step_sections,nb_sections, L1, L2, sigma_pose_vehicle, sigma_theta_vehicle); 
        flag_sections = true;
    end
    
end

%% FIGURES - LOOP OVER SPECIFIC TIMESTEPS
 
plotting(coord_map, gps_available_map, sidewalks, timesteps, landmarks, noisy_landmarks, pose_vehicle, lasers, detections, sections);
