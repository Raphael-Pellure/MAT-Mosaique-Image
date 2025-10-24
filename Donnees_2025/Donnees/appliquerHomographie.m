% Calcul des coordonnees (xy2) des points (xy1)
% apres application d'une homographique H

function [xy2] = appliquerHomographie(H,xy1)

% Entrees :
%
% H   : matrice (3x3) de l'homographie
% xy1 :  matrice (nbPoints x 2) representant les coordonnees 
%       (colonne 1 : les x, colonne 2 : les y) 
%       des nbPoints points auxquels H est appliquee
%
% Sortie :
% xy2 : coordonnees des points apres application de l'homographie

% Nombre de points
% ... A completer ...
NbPoints = length(xy1(:,1));

% Construction des coordonnees homogenes pour appliquer l'homographie
% ... A completer ...

xy1_h = [xy1, ones(NbPoints,1)].' ;

% Application de l'homographie
% ... A completer ...

xy2_z =  H * xy1_h ; 

% On retourne les coordonnees homogenes (x,y,1)
% Pour cela, il faut diviser par z
% Attention il ne faut garder que les deux premieres coordonnees
% ... A completer ...

Z = xy2_z(3, :);
X = xy2_z(1, :) ./ Z;
Y = xy2_z(2, :) ./ Z;

xy2 = [X.', Y.'];