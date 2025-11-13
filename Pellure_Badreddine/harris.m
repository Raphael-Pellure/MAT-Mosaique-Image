function [XY,R]=harris(Im,TailleFenetre,NbPoints,k);
%[XY,Res]=harris(Im,TailleFenetre,NbPoints,k);
%
% Im -> image
% TailleFenetre -> taille (impaire) de la fenetre du voisinage
%                  valeurs conseillees : entre 9 et 25
% NbPoints -> nombre de points desires
% k -> poids utilise dans le calcul de la reponse R, k dans [0.04,0.06]
% XY -> Matrice de taille NbPointsx2 contenant 
%         respectivement les abscisses et les oordonnees des points 
%         d'interets extraits
%      ATTENTION : La fonction de Harris ne doit pas retourner des points sur les bords 
% R -> Image des reponses par le detecteur de Harris

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nota bene : les coordonnees utilisees sont x=j (numero de colonne) et y=i (numero de ligne). %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Verification et correction eventuelle des parametres donnes
if nargin < 4, k=0.05;      end;
if nargin < 3, NbPoints=50;      end;
if nargin < 2, TailleFenetre=9;  end;

% (1.1) Calcul des dérivées images suivant les lignes et les colonnes 
%       en utilisant la fonction gradient
Im = double(Im);
%%% A COMPLETER %%%
[Gy, Gx] = gradient(Im);   % Gy (lignes), Gx (colonnes)
Ii = Gy;                  
Ij = Gx;  

% (1.2) Calcul du filtre de lissage gaussien
% Calcul de sigma en fonction de la taille de la fenetre  
sig = (TailleFenetre - 1)/4;
% Utilisation de fspecial
%%% A COMPLETER %%%
L = fspecial('gaussian',TailleFenetre,sig) ;

% (1.3) Calcul de la reponse R
% Calcul des elements A, B et C puis calcul de la reponse suivant l'equation (1)
% Utiliser conv2 avec l'option 'same' pour appliquer le filtre de lissage L
%%% A COMPLETER %%%

A = conv2(Ii.^2,L,"same");
B = conv2(Ij.^2,L,"same");
C = conv2(Ii.*Ij,L,"same");

% Initialiser les matrices M et R
[n, m] = size(A); % Supposons que A est de taille n x m


R = zeros(n, m); % Initialiser R

% Remplir M et calculer R
for i = 1:n
    for j = 1:m
        M = [A(i,j), C(i,j); C(i,j), B(i,j)];
        R(i,j) = det(M) - k * (trace(M)^2);
    end
end

% R = (A.*B - C.^2) - k*(A + B).^2;

% disp(R);

% (2.1) Suppression des non-maxima locaux suivant l'equation (2)
% ATTENTION : il faut gérer le cas particulier des bords
% 1) Il est impossible de calculer le maximum local car une partie du voisinage n'existe pas
% 2) Il faut leur attribuer la valeur minimale afin qu'il ne soit pas selectionne par la suite

%%% A COMPLETER %%%
n2=floor(TailleFenetre/2);

[l,c]=size(Im);
Res=zeros(l,c);

R(1:n2, :) = -inf; % Set border values to negative infinity
R(:, 1:n2) = -inf; 

R((l-n2+1):l, :) = -inf; 
R(:, (c-n2+1):c) = -inf;

for i=(n2+1):(l-n2)
  for j=(n2+1):(c-n2)
    window = R(i-n2:i+n2, j-n2:j+n2);
    rmax = max(window(:));

    if R(i,j) == rmax 
        Res(i,j) = R(i,j);
    else
        Res(i,j) = 0;
    end;

  end;
end;

% (2.2) Selection des NbPoints en fonction de "NbPoints" reponses les plus fortes
% Tri des reponses : utiliser sort en LINEARISANT Res au préalable
%%% A COMPLETER %%%
%disp(Res);
[s,is] = sort(Res(:), "descend");
%disp(s);
%disp(is);

% Selection des indices de NbPoints de plus fortes reponses
%%% A COMPLETER %%%
valid = is(1:NbPoints);
%disp(valid);

% Calcul des indices dans l'image 
% Utiliser ind2sub, attention a l'ordre pour recuperer les coordonnees
%%% A COMPLE	TER %%%
[Y,X]= ind2sub(size(Res), valid);

%%% A COMPLETER %%%
XY = [X(:), Y(:)];
%disp(XY);
