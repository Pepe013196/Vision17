function segmentation = segmentByClustering2( rgbImage, featureSpace, clusteringMethod, numberOfClusters)

%% Numero de clusters
if numberOfClusters <2
    fprintf('Ingresar mayor numero de clusters\n');
    return
end
    a = rgbImage;
    k = numberOfClusters;
distancias = 0;
%% Espacio de color
if strcmp('rgb',featureSpace)
    
elseif strcmp('lab',featureSpace)
    a = rgb2hsv(a);
elseif strcmp ('hsv',featureSpace)
    a = rgb2hsv(a);

elseif strcmp('rgb+xy',featureSpace)
    %Distancias y Concatenar
    dist1 = meshgrid(1:size(a,2),1:size(a,1));
    dist2 = meshgrid(1:size(a,1),1:size(a,2))';
    dist1 = cat(3,dist1,dist2);
    a = cat(3,a,dist1);
    distancias =1;
elseif strcmp('lab+xy',featureSpace)
    %Distancias y Concatenar
    dist1 = meshgrid(1:size(a,2),1:size(a,1));
    dist2 = meshgrid(1:size(a,1),1:size(a,2))';
    dist1 = cat(3,dist1,dist2);
    a = cat(3,a,dist1);
    a = rgb2hsv(a);
    distancias =1;
elseif strcmp('hsv+xy',featureSpace)
    %Distancias y Concatenar
    dist1 = meshgrid(1:size(a,2),1:size(a,1));
    dist2 = meshgrid(1:size(a,1),1:size(a,2))';
    dist1 = cat(3,dist1,dist2);
    a = cat(3,a,dist1);
    a = rgb2hsv(a);
    distancias =1;
else
    fprintf('No es un espacio correcto\n')
    return
end

%% Método de cluster

if strcmp('k-means',clusteringMethod)
    if distancias == 0
        segmentation = kmeansImg(a,k);
    else
        segmentation = kmeansImgXY(a,k)
    end
elseif strcmp('gmm',clusteringMethod)

elseif strcmp('hierarchical',clusteringMethod)

elseif strcmp('watershed',clusteringMethod)

else
    fprintf('Metodo incorrecto de cluster\n')
return
    
end


%% Respuesta

end