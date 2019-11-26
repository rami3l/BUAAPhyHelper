% Modified version of https://github.com/wtdcode/BUAAPhyhelper/blob/master/1031/3/main.m

clear;
clc;

format long

X = load('data');
const = load('const');

%{

X = [
  % Put x1 - x10 here...
  ;
  % and x31 - x40 here.
];

% f1, f2 (in kHz), the temperature t in C (usually 24)
const = [40.000 40.000 24];

%}

f1 = const(1);
f2 = const(2);
t = const(3);

f = (f1+f2)/2

x_ = (1/(30*10))*sum(X(2,:)-X(1,:))

lambda = 2 * x_

c = f*lambda 

c0 = 331.45.*sqrt(1+t/273.15)

eta = abs(c - c0)/c0

u_a_lambda = sqrt(
  sum(
    (
      (X(2,:)-X(1,:))/30*2-lambda
    ).^2
  )/(10*9)
)

u_b1_lambda = 0.005/sqrt(3)

u_b2_lambda = 0.1/(10*sqrt(3))

u_lambda = sqrt(u_a_lambda.^2 + u_b1_lambda.^2 + u_b2_lambda.^2)

delta_f = abs(f1-f2)/2

u_f = delta_f/sqrt(3)

u_c_div_by_c = sqrt( (u_lambda/lambda).^2 + (u_f/f).^2)

u_c = u_c_div_by_c*c
