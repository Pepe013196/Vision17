%% Crear ONU banco de filtros con deafult params
[FB] = fbCreate(4,4,1);

load rutas.mat;

%% Im�genes de la Muestra de carga desde el disco de 
imagen = imread(strcat('muestreo/',rutas{1}));

for i = 2:numel(rutas)
   imagen  = horzcat(imagen,imread(strcat('muestreo/',rutas{i})));
end
%%
% N�mero Determinado de Grupos de  
K= 25*8;

% APLICAR Filtros para muestrear imagen  
filterResponses = fbRun(FB,imagen);

% Textons inform�ticos de filtro
[Mapa, textons] = computeTextons(filterResponses,K);

save FB.mat;
save textons.mat;
save Mapa.txt;