clc;
clear;
format long;

%%%%%% length %%%%%%
% hB / mm
% dB / mm
% hP / mm
% dP / mm

load('length');

%%%%%% others %%%%%%
% theta1 / degC
% theta2 / degC
% mP / g
% slope / (degC/s)

load('others');

hB = length(1,:) / 1000
hB_avg = mean(hB)
dB = length(2,:) / 1000
dB_avg = mean(dB)
hP = length(3,:) / 1000
hP_avg = mean(hP)
dP = length(4,:) / 1000
dP_avg = mean(dP)

theta1 = others(1)
theta2 = others(2)
mP = others(3) / 1000
slope = others(4)

c = 389;
k = mP * c * slope ...
    * (dP_avg + 4 * hP_avg) / (dP_avg + 2 * hP_avg) ...
    * hB_avg / (theta1 - theta2) ...
    * 2 / (pi * (dB_avg.^2))

%%%%%% Uncertainties %%%%%%
u_mP = 1 / sqrt(3) / 1000
ub_d_and_h = 0.02 / sqrt(3) / 1000

length_size = size(hB)(2)

ua_dP = sqrt(
    sum(
        (dP(:) - dP_avg).^2
    )/(length_size * (length_size - 1))
)

ua_hP = sqrt(
    sum(
        (hP(:) - hP_avg).^2
    )/(length_size * (length_size - 1))
)

ua_dB = sqrt(
    sum(
        (dB(:) - dB_avg).^2
    )/(length_size * (length_size - 1))
)

ua_hB = sqrt(
    sum(
        (hB(:) - hB_avg).^2
    )/(length_size * (length_size - 1))
)

u_dP = sqrt(ua_dP.^2 + ub_d_and_h.^2)
u_hP = sqrt(ua_hP.^2 + ub_d_and_h.^2)
u_dB = sqrt(ua_dB.^2 + ub_d_and_h.^2)
u_hB = sqrt(ua_hB.^2 + ub_d_and_h.^2)

u_k_over_k = sqrt(
    (u_mP / mP).^2 ...
    + (
        (1 / (dP_avg + 4 * hP_avg) - 1 / (dP_avg + 2 * hP_avg)) ...
        * u_dP
    ).^2 ...
    + (
        (4 / (dP_avg + 4 * hP_avg) - 2 / (dP_avg + 2 * hP_avg)) ...
        * u_hP
    ).^2 ...
    + (u_hB / hB_avg).^2 ...
    + (2 * u_dB / dB_avg).^2
)

u_k = u_k_over_k * k