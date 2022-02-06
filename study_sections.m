clear; clc; close all;
%dbstop if error

addpath('functions&classes')

% Initialization parameters
parameters()

% Sections case
section_case = 'Trapezoid'; % 'Trapezoid' or 'rectangular'

% Variying L1 
L1s = linspace(1, 5, 10);

widths_1 = zeros(length(L1s), 1);
widths_2 = zeros(length(L1s), 1);


for p = 1:length(L1s)
    
    pause(0.1)
    
    L1 = L1s(p);
    distance_from_sidewalk_right = L1;
    pose_vehicle(1, 1) = sidewalk_right(1, 1) - distance_from_sidewalk_right;
    pose_vehicle(1, 2) = 5;
    L2 = 1;


    % Sections
    nb_sections = 1;
    
    if section_case == "Trapezoid" 
        [sections, w1, w2] = create_trapezoid_sections(pose_vehicle(1, :), step_sections, nb_sections, L1, L2, sigma_pose_vehicle, sigma_theta_vehicle); 
    widths_1(p, 1) = w1;
    else
        [sections, w2] = create_rectangular_sections(pose_vehicle(1, :), step_sections, nb_sections, L1, L2, sigma_pose_vehicle, sigma_theta_vehicle); 
    end
    
    widths_2(p, 1) = w2;

    % plot first sections
    s = 1;
    figure(1); grid on; 
    ax1 = subplot(1, 1, 1); hold on;

    title(ax1, "Section of detections")

   
    
    plot(ax1, sections(s, 1:2:3), sections(s, 2:2:4), 'b') 
    plot(ax1, sections(s, 5:2:7), sections(s, 6:2:8), 'b') 
    plot(ax1, sections(s, 1:4:5), sections(s, 2:4:6), 'r') 
    plot(ax1, sections(s, 3:4:7), sections(s, 4:4:8), 'r') 

   

end



% Plot circle landmark
r = 0.102/2 ;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + 7.5;
yunit = r * sin(th) + 5;
h = plot(ax1, xunit, yunit);
%% plot evolving width 


figure(2); grid on; 
ax2 = subplot(1, 1, 1); hold on; 
title(ax2, "Widths vs initial distance from sidewalk")

xlim(ax2, [min(L1s) - 0.5, max(L1s) + 0.5])
ylim(ax2, [min(widths_2) - 0.05, max(widths_2) + 0.05])

if section_case == "Trapezoid" 
    plot(ax2, L1s, widths_1)
    plot(ax2, L1s, widths_2)
    legend(ax2, "Width section near vehicle",  "Width section far vehicle")
else
    plot(ax2, L1s, widths_2)
    legend(ax2, "Width section")
end

%% 
% w = 0.1007 , 0.2543
% d = 0.0635, 0.102 

w = 0.2543;

r = 0.102 / 2 ; 
a = 2 * r / w;






