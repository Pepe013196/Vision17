n = 10;

aleatorios = zeros(25,n);

rutas = cell(25*n,1);

for i=1:25
     aleatorios(i,:) = randi([1 30],1,n);
     for j = 1:n
        ruta = 'T';
        if i < 10
            ruta = strcat(ruta,'0');
        end
        ruta = strcat(ruta,num2str(i),'_');
        if aleatorios(i,j) < 10
           ruta = strcat(ruta,'0'); 
        end
        ruta = strcat(ruta,num2str(aleatorios(i,j)),'.jpg');
        
        rutas{25*(j-1) + i} = ruta;
        
        a = imread(ruta)
        [x y] = size(a)
        b = a(round(x/2)-105:round(x/2)+106,round(y/2)-81:round(y/2)+80)
        imshow(a)
        figure
        imshow(b)
        
        copyfile(ruta,fullfile('muestreo'));
     end
end
 %%
 cd('C:\Users\fabia\Dropbox\SEMESTRE 9 - 201710\Vision\Labs\3 - textones\textures\muestreo');
 