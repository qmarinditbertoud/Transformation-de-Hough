% Transform�e de Hough pour d�tection de points align�s sur droites

clear all
close all
clc

%% Initialisations diverses
rad2deg=180/pi;
normalisation=true;

I=rgb2gray(imread('Maison.jpg'));
t= graythresh(I);
I=imcomplement(im2bw(I,t));
[H W]=size(I);
figure(1),imagesc(I), colormap gray
title('Image de base');

ro_max=sqrt((H/2)^2 + (W/2)^2);
fprintf('\nRo_max=%f',ro_max);

%R�solution a priori
dro=5; %Largeur trait
dtheta=atan(dro/ro_max); %Angle des droites (centre, pixels coin inf-gauche)

%R�solution finale
theta_max=pi/2;
theta_min=-pi/2;
Ntheta=round((theta_max-theta_min)/dtheta);
dtheta=(theta_max-theta_min)/Ntheta;

ro_min=-ro_max;
Nro=round((ro_max-ro_min)/dro);
dro=(ro_max-ro_min)/Nro;

fprintf('\nHough space size : Nro=%d, Ntheta=%d',Nro, Ntheta);
fprintf('\nHough space resolution : dro=%f (pu), dtheta=%f (deg) \n',dro, dtheta*rad2deg);


%% Q3
Hough = zeros(Nro,Ntheta); %Initialisation du tableau de Hough � zero

%% Q4

[ind]=find(I);              %Indice des pixels non nuls de l'image
[i,j] = ind2sub([H,W],ind); %Conversion en indice ligne/colonne

%% Q5 && Q6 && Q7
x0=W/2;
y0=H/2;

for n=1:length(ind)
    %Relation liant x � j et y � i permettant la conversion de (i,j) en (x,y)
    x= j(n) - x0;
    y= -(i(n)-y0);
    
    %Fonction retournant la sinuso�de correspondant au point (x,y)
    Hough=SinusHoughSpace2(Hough,x,y,ro_max);
end

%Normalisation
if normalisation==true
    I_norm=ones([H,W]); %Matrice de 1 de la taille de l'image
    ind=find(I_norm);   %R�cup�re les indices des pixels non nuls
    [i,j] = ind2sub(size(I_norm),ind); %Conversion en indice ligne/colonne
    Hough_norm=zeros(Nro,Ntheta);

    for n=1:length(ind)
        %Relation liant x � j et y � i permettant la conversion de (i,j) en (x,y)
        x= j(n) - x0;
        y= -(i(n)-y0);

        %Fonction retournant les sinuso�des correspondant aux points (x,y)
        Hough_norm=SinusHoughSpace2(Hough_norm,x,y,ro_max);

    end
    Hough=Hough./Hough_norm;
end

%Affichage des sinuso�des
figure(2);
colormap gray;
imagesc(Hough);
title('Sinuso�des associ�es aux points (x,y)');



%% Q8 trac� des droites correspondant aux premi�res valeurs max de l'espace de Hough


%Recherche des 30 premi�res valeurs maximales de l'espace de Hough
Hough_s = zeros(Nro,Ntheta);    %Initialisation d'un tableau de 0 de taille Nro et Ntheta
for m=1:30;
    [maxval,idx]=max(Hough(:)); %Recherche de la valeurs max du tableau de Hough et stockage de la valeur et de son indice
    [row,col]=ind2sub(size(Hough),idx); %On stocke le num�ro de l'indice de la valeur max en notant ses coordonn�es en ligne/colonne
    Hough_s(row,col) = 1;       %On sauvegarde cet indice dans un nouveau tabeleau
    Hough(row,col) = 0;         %On supprime cette valeur maximum pour pouvoir trouver la valeur max suivante
end

[l,k] = find(Hough_s); %Retourne un tableau avec les colonnes et lignes pour toutes valeurs non nulles dans le tableau Hough_s 

%Fonction permettant de transformer les indices (l,k) de l'espace Hough en coordonn�es r�elles (ro,tetha)
[ro,theta]=Hough2ImSpace(l,k,dro,dtheta,ro_min,theta_min);

figure(3),imagesc(Hough_s),colormap gray

title('Hough_s : image representant les valeurs maximales de l''espace de Hough')


%Trac� des droites
for p=1:30
    %Renvoie deux points extr�mes de l'image appartenant a la droite d�finie par ro et theta
    [P1,P2] = DeuxPoints(ro(p),theta(p),H,W); 
    figure(4),hold on;
    plot([P1(1) P2(1)], [P1(2) P2(2)],'r'); 

    title('Trac� des droites d�finies par ro et theta')
end
