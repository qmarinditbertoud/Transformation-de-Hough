function Hough=SinusHoughSpace2(Hough,x,y,ro_max)   

    %Cariables nécessaires au calcul de la sinusoïde
    dro=5; %Largeur trait
    dtheta=atan(dro/ro_max); %Angle des droites (centre, pixels coin inf-gauche)
    theta_max=pi/2;
    theta_min=-pi/2;
    Ntheta=round((theta_max-theta_min)/dtheta);
    dtheta=(theta_max-theta_min)/Ntheta;
    ro_min=-ro_max;
    Nro=round((ro_max-ro_min)/dro);
    dro=(ro_max-ro_min)/Nro;
    [H,W]=size(Hough); %Récupération de la taille du tableau Hough
    
    for theta=theta_min:dtheta:theta_max
        ro=x*cos(theta)+y*sin(theta);               %On trouve ro pour un couple (x,y)
        l=ceil(1+(ro-ro_min-dro/2)/dro);            %On trouve l avec les formules du NB du sujet
        k=ceil(1+(theta-theta_min-dtheta/2)/dtheta);%On trouve k avec les formules du NB du sujet   
        if (l<=H & k<=W)
            Hough(l,k)=Hough(l,k)+1;                %On trace la sinusoide
        end   
    end
end