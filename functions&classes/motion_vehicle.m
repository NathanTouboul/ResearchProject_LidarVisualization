function pose_vehicle = motion_vehicle(previous_pose_vehicle, speed, delta_t)
    pose_vehicle(1, 1) = previous_pose_vehicle(1, 1); 
    pose_vehicle(1, 2) = previous_pose_vehicle(1, 2) + speed * delta_t ; 
end 