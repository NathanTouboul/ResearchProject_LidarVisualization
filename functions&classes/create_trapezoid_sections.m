function [sections, w1, w2] = create_trapezoid_sections(pose_vehicle, step, nb_sections, L1, L2, sigma_pose_vehicle, sigma_theta)

% create_trapezoid_sections generates the set of coordinates necessary
% create our selected area of detection
%   for each sections: 4 points A, B, C, D with x and y coordinates
% S1: xa, ya, xb, yb, xc, yc, xd, yd

sections = zeros(nb_sections, 8);

sigma_x = sigma_pose_vehicle(1, 1);
sigma_y = sigma_pose_vehicle(1, 2);

w1 = 2 * (sigma_x + (L1 + sigma_y) * sigma_theta) ; 
w2 = 2 * (sigma_x + (L1 + L2 +sigma_y) * sigma_theta) ; 

for n = 1:nb_sections

    sections(n, 1) = pose_vehicle(1, 1) + L1; % xa = xv + L1
    sections(n, 3) = pose_vehicle(1, 1) + L1 + L2; % xb = xv + L1 + L2
    sections(n, 5) = pose_vehicle(1, 1) + L1; % xc = xv + L1
    sections(n, 7) = pose_vehicle(1, 1) + L1 + L2; % xc = xv + L1

    alt = (n - 1) * step;
    sections(n, 2) = alt + pose_vehicle(1, 2) - w1 / 2; % ya = yv - w1 / 2
    sections(n, 4) = alt + pose_vehicle(1, 2) - w2 / 2; % yb = yv - w2 / 2
    sections(n, 6) = alt + pose_vehicle(1, 2) + w1 / 2; % yc = yv + w1 / 2
    sections(n, 8) = alt + pose_vehicle(1, 2) + w2 / 2; % yd = yv + w2 / 2

end


end

