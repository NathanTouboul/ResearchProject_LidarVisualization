function [flag_detection, lasers, detections] = detection(lasers, landmarks, detections, t)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    flag_detection = false;
    
    laser_start = lasers(1, 1:2);
    laser_end = lasers(1, 3:4);
    
    vector_laser = laser_end - laser_start ;

    td_size = length(detections);

    for ld = 1:landmarks
        
        vector_landmark = landmarks(ld, :) - laser_start ;    
        
        % Check if a landmark is detected
        
        condition_colinear =  vector_laser(1, 1) * vector_landmark (1, 2) - vector_laser(1, 2) * vector_landmark (1, 1) ; 
        
       
        if abs(condition_colinear) < 0.001
            
            disp("Landmark detected"); disp(landmarks(ld, :));

            flag_detection = true; 
            
            laser_end(1, 1) = landmarks(ld, 1) ; 
            laser_end(1, 2) = landmarks(ld, 2); 
            
            lasers(1, 3:4)= [laser_end(1, 1), laser_end(1, 2)]; 
            
            detections(td_size + 1, 1) = t ; 
            
            break
        end
        
    end 
end

