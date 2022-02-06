function ax1 = plotting(coord_map, gps_available_map, sidewalks, timesteps, landmarks, noisy_landmarks, pose_vehicle, lasers, detections, sections)


%PLOTTING Summary of this function goes here
%   Detailed explanation goes here

figure(1); grid on; 
ax1 = subplot(1, 1, 1); hold on;

xlim(ax1, coord_map(1, :))
ylim(ax1, coord_map(2, :) / 4)

% GPS availbable space
corner = zeros(1, 2);
corner(1, 1) = gps_available_map(1, 1);
corner(1, 2) = gps_available_map(2, 1);
width = gps_available_map(1, 2) - gps_available_map(1, 1) ;
height = gps_available_map(2, 2) - gps_available_map(2, 1) ;

pos = [corner(2), corner(2), width, height] ;

rectangle(ax1, 'Position', pos, 'FaceColor',[0 .5 .5 .1], 'LineStyle', 'none')


% Sidewalks 
sidewalk_left = sidewalks(:, 1:2) ;
sidewalk_right = sidewalks(:, 3:4);

plot(ax1, [sidewalk_right(1, 1), sidewalk_right(1, 1)], [coord_map(2, 1), coord_map(2, 2)], '-b')
plot(ax1, [sidewalk_right(1, 2), sidewalk_right(1, 2)], [coord_map(2, 1), coord_map(2, 2)], '-b')

plot(ax1, [sidewalk_left(1, 1), sidewalk_left(1, 1)], [coord_map(2, 1), coord_map(2, 2)], '-b')
plot(ax1, [sidewalk_left(1, 2), sidewalk_left(1, 2)], [coord_map(2, 1), coord_map(2, 2)], '-b')



% Plotting the true and noisy landmarks
for ldm = 1:size(landmarks)
    ld_obj = plot(ax1, landmarks(ldm, 1), landmarks(ldm, 2), 'g.','MarkerSize', 20);
    ld_noisy_obj = plot(ax1, noisy_landmarks(ldm, 1), noisy_landmarks(ldm, 2), 'rp','MarkerSize', 5);


end

% Vehicle object
vehicle_obj = plot(ax1, pose_vehicle(1, 1), pose_vehicle(1, 2), '-s','MarkerSize',20);

% Lidar object
laser_start = lasers(1, 1:2);
laser_end = lasers(1, 3:4);
laser_obj = plot(ax1, [laser_start(1, 1), laser_end(1, 1)], [laser_start(1, 2), laser_end(1, 2)], '--r') ;

for t = 2:1: length(timesteps)
    
    pause(0.05)

    % Plotting Vehicle 
    vehicle_obj.XData = pose_vehicle(t, 1) ;
    vehicle_obj.YData = pose_vehicle(t, 2) ;

    % Plotting Laser 
    laser_obj.XData = [lasers(t, 1), lasers(t, 3)] ;
    laser_obj.YData = [lasers(t, 2), lasers(t, 4)] ;
    

    if ismember(t, detections)

        % plotting sections when first detection arises
        if t == detections(2, 1)
            for s = 1:length(sections)
                plot(ax1, sections(s, 1:2:3), sections(s, 2:2:4), 'r') 
                plot(ax1, sections(s, 5:2:7), sections(s, 6:2:8), 'r') 
                plot(ax1, sections(s, 1:4:5), sections(s, 2:4:6), 'r') 
                plot(ax1, sections(s, 3:4:7), sections(s, 4:4:8), 'r') 

            end
        end
        
        laser_obj.LineStyle = '-.'; 
        pause(1)
    else
        laser_obj.LineStyle = '-'; 
    end 
    

end

