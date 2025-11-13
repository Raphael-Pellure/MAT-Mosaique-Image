%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fonction renvoyant les niveaux de gris du voisinage de chaque point en ligne

function voisins = voisinage(I,xyPt,TailleFenetre)
% ENTREES
% I    : l'image
% xyPt : les coordonnees des points dont nous cherchons le voisinage. 
%        ATTENTION : on fait l'hypothese qu'il n'y a aucun point sur les bords
% TailleFenetre    : La taille de la fenêtre de correlation correspond 
%                    a TailleFenetre x TailleFenetre

% SORTIE
% voisins : une matrice contenant pour chaque ligne (= chaque point),
%           le voisinage du point associe
% Nombre de points pour lesquels leur voisinage est cherche
npt = size(xyPt,1); 

% Initialisation
voisins = zeros(npt,TailleFenetre*TailleFenetre);

% Calcul de la demi-fenetre de correlation
K = floor(TailleFenetre/2);

%%%%%%%%%%%%%%%%%
%% A COMPLETER %%
%%%%%%%%%%%%%%%%%
% fonction qui retourne les niveaux de gris dans le voisinage de chaque point
% d'interet dans une matrice (appelee par apparier Points.m)


for p = 1:npt
    x = xyPt(p,1);
    y = xyPt(p,2);

    patch = I(y-K:y+K, x-K:x+K);     % K autour du centre
    % Vectorisation ligne-par-ligne (haut→bas, gauche→droite)
    voisins(p,:) = reshape(patch, 1, []);  
end

%% --- VOISINAGE: extraction des patchs pour la corrélation ---
% Objectif: pour chaque point (x,y), retourner le patch vectorisé KxK centré en (x,y).
% Entrées: I (2D), xyPts (N x 2), K (impair)
% Sortie: voisins (N x K^2)
% Étapes:
% - Définir r = (K-1)/2; gérer les bords (ignorer ou padarray).
% - Pour i=1..N: extraire I(y-r:y+r, x-r:x+r), vectoriser par colonnes, sauver ligne i.
% Astuces:
% - Utiliser 'replicate' au padding pour robustesse bord.
% - Vérifier que (x,y) respecte l'ordre [col, ligne] si tes points sont (x,y) ou (col,row).
% - Accélération possible: préallouer voisins avec zeros(N,K*K).


    