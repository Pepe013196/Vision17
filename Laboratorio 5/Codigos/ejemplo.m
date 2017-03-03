%% Crear ONU banco de filtros con deafult params
[FB] = fbCreate(4,4,1);

rutas = load('rutas.mat');

%% Imágenes de la Muestra de carga desde el disco de 
imagen = imread(strcat('muestreo/',rutas{1}));

for i = 2:numel(rutas)
   imagen  = horzcat(imagen,imread(strcat('muestreo/',rutas{i})));
end
%%
% Número Determinado de Grupos de  
K= 16*8 ;

% APLICAR Filtros para muestrear imagen  
filterResponses = fbRun(FB,horzcat(imBase1,imBase2));

% Textons informáticos de filtro
[Mapa, textons] = computeTextons(filterResponses,K);
%%
% Cargar Más Imágenes  
imTest1 = double ((imread( 'textures\train\T01_02.jpg' ))) / 255 ;
imTest2 = double ((imread( 'textures\train\T02_02.jpg' ))) / 255 ;
%%
% Calcula textons Representación Con El textons DICCIONARIO real  
tmapBase1 = assignTextons (fbRun(FB, imBase1), textons' );
tmapBase2 = assignTextons (fbRun(FB, imBase2), textons' );
tmapTest1 = assignTextons (fbRun(FB, imTest1), textons' );
tmapTest2 = assignTextons (fbRun(FB, imTest2), textons' );
%%
% Compruebe la distancia euclidiana Entre los histogramas y convencerse de Que las Imágenes de las Cabras estan Más cerca Porque Tienen patrón de textura parecida 
% ¿Se Puede Decir Por Qué TENEMOS Que CREAR UN histograma de los antes Medir la distancia? 
D = norm( histc (tmapBase1 (:), 1 : K) / numel(tmapBase1) -  histc (tmapTest1 (:), 1 : K) / numel (tmapTest1))
D = norm( histc (tmapBase1 (:), 1 : K) / numel(tmapBase1) -  histc (tmapTest2 (:), 1 : K) / numel (tmapTest2))

D = norm( histc (tmapBase2 (:), 1 : K) / numel(tmapBase2) -  histc (tmapTest1 (:), 1 : K) / numel (tmapTest1))
D = norm( histc (tmapBase2 (:), 1 : K) / numel(tmapBase2)    -  histc (tmapTest2 (:), 1 : K) / numel (tmapTest2))