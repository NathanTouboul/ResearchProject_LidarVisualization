clear; clc; close all;
%dbstop if error

addpath('functions&classes')

% Initialization parameters
parameters()

% Sections case
section_case = 'rectangular'; % 'Trapezoid' or 'rectangular'

% Variying L1 
L1s = linspace(1, 5, 10);

widths_1 = zeros(length(L1s), 1);
widths_2 = zeros(length(L1s), 1);

