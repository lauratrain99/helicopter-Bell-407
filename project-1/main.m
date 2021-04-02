clear; clc; close all;

% This file contains all the calls for the optimization analyses

%% Add paths
addpath aerodynamics/
addpath conversions/
addpath params/
addpath power/
addpath DoE/

%% Run the 6 optimization analyses
run constant_chord.m
run chord_all.m
run twist_all.m
run optimization_linear_all_3_blades.m
run optimization_linear_all_4_blades.m
run optimization_linear_all_5_blades.m

