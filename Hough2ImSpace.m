function [ro,theta]=Hough2ImSpace(l,k,dro,dtheta,ro_min,theta_min)

theta = theta_min + dtheta/2 + (k-1).*dtheta;%Formule donnant theta en fonction de k, l, thetamin et dtheta (cf. NB q.6 enoncé TP)
ro = ro_min+dro/2+(l-1).*dro;   %Formule donnant ro en fonction de k, l, ro_min et dro

end