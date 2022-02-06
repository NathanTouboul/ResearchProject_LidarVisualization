%% Parameters

%% Experiment
t_end = 100; % sec
delta_t = 0.1 ; % sec -- depends on the rate of the lidar
timesteps = linspace(0, t_end, t_end / delta_t); 

%% Map
coord_map = [[0, 8] ; [0, 100]];  % m - x axis, y axis
sidewalk_right = coord_map ; 

% Width of Sidewalk: L2
L2 = 1;
width_sidewalk = L2 ;
sidewalk_right(1, 1) = sidewalk_right(1, 2) - width_sidewalk; 

sidewalk_left = coord_map ; 
sidewalk_left(1, 2) = sidewalk_left(1, 1) + width_sidewalk ; 

sidewalks = cat(2, sidewalk_left, sidewalk_right);

% Landmarks coordinates
landmarks = double([[7.5, 5.0] 
                    [7.5, 10.0] 
                    [7.5, 20.0]
                    [7.5, 30.0]
                    [7.5, 35.0]
                    [7.5, 45.0]
                    [7.5, 50.0]]) ;
                
% Noisy Landmarks
noisy_landmarks = landmarks;
                
% GPS covered map 
gps_available_map = coord_map;
gps_available_map(2, :) = gps_available_map(2, :) / 10; 

%% Vehicle
speed_vehicle = 1 ; % m/s

% Initialization vector vehicle coordinates - perfect kmowledge of our
% position at t = 0

pose_vehicle = zeros(t_end * delta_t, 2) ; 

% Initial distance between vehicle and start of sidewalk: L1

L1 = 5; % meters
distance_from_sidewalk_right = L1;
pose_vehicle(1, 1) = sidewalk_right(1, 1) - distance_from_sidewalk_right;
pose_vehicle(1, 2) = 0;

%% Lidar

degree_lidar_detection = 0; % degrees - 0 deg being the direction
range_lidar_detection = 100 ; % m - range of the lidar 
bearing = degree_lidar_detection * pi / 30 ;

lasers = zeros(t_end * delta_t, 4) ;
lasers(1, 1:2) = pose_vehicle(1, :);
lasers(1, 3) = lasers(1, 1) + range_lidar_detection * cos(bearing) ;
lasers(1, 4) = lasers(1, 2) + range_lidar_detection * sin(bearing) ;


%% Uncertainties - Sigma

% Vehicle
sigma_pose_x_vehicle = 0.01; % meters
sigma_pose_y_vehicle = 0.02; % meters

sigma_yaw_vehicle =  0.0666135718051935; % deg

% Lidar
sigma_lidar_resolution = 0.2; % deg
sigma_divergence =  0.1;  % deg

% Completes
sigma_pose_vehicle = 3 *[sigma_pose_x_vehicle, sigma_pose_y_vehicle]; 
sigma_theta_vehicle = 3 *deg2rad(sigma_yaw_vehicle + sigma_lidar_resolution + sigma_divergence);

% Sections
step_sections = 5; %meters

% Timestep of detection
detections = zeros(); 
