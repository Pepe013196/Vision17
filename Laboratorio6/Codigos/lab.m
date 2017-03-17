%Evaluacion
nombres = {'55075' '55067' '54005' '48055' '27059' '26031' '25098' '24063'}';

espacios = {'rgb' 'rgb+xy' 'lab' 'lab+xy' 'hsv' 'hsv+xy'}';

metodos = {'kmeans' 'gmm' 'hierarchical' 'watershed'}';

jaccards2 = zeros(numel(espacios),numel(metodos));

for m = 3:numel(metodos)-1
    for e = 1:numel(espacios)
        for n = 1:numel(nombres)
            im = load(strcat(nombres{n},'.mat'));
            anotacion = im.groundTruth{1}.Segmentation;
            k = max(max(anotacion));
            im = imread(strcat(nombres{n},'.jpg'));
            if(m==3)
               k = 1.15;
            end
            disp(k);
            segm = segmentByClustering(im,espacios{e},metodos{m},k);
            k = max(max(anotacion));
            
            jaccard = 0;
            for i = 1:k
                regionCluster = anotacion == i;
                areaTotal = sum(sum(regionCluster));
                [filas,columnas] = size(segm);
                
                vector = [];
                
                for fil = 1:filas
                   for col = 1:columnas
                       if(regionCluster(fil,col))
                           vector = horzcat(vector,segm(fil,col));
                       end
                   end
                end
                moda = mode(vector);
                correctos = (regionCluster.*segm) == moda;
                areaCorrectos = sum(sum(correctos));
                jaccard = jaccard + double(areaCorrectos)/double(areaTotal);
            end
            
            jaccard = jaccard/double(k);
            
            jaccards2(e,m) = jaccards2(e,m)+jaccard;
        end
        jaccards2(e,m) = jaccards2(e,m)/numel(nombres);
    end
end
save jaccards2.mat;
