function [P1,P2]=DeuxPoints(ro,theta,H,W)

a = cos(theta);
b = sin(theta);
x0 = ro*a;
y0 = ro*b;

x1 = (x0 + W*(-b));
y1 = (y0 + H*(a));

x2 = (x0 - W*(-b));
y2 = (y0 - H*(a));

P1 = [x1,y1];
P2 = [x2,y2];

end
