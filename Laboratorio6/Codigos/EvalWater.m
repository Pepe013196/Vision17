%Evaluacion
nombres = {'55075' '55067' '54005' '48055' '27059' '26031' '25098' '24063'}';

espacios = {'rgb' 'rgb+xy' 'lab' 'lab+xy' 'hsv' 'hsv+xy'}';

metodos = {'kmeans' 'gmm' 'hierarchical' 'watershed'}';

P = zeros(numel(espacios),numel(nombres),25);
R = zeros(numel(espacios),numel(nombres),25);

for m = 4:numel(metodos)
    for e = 1:numel(espacios)
        TP = 0;
        FP = 0;
        FN = 0;
        for n = 1:numel(nombres)
            im = load(strcat(nombres{n},'.mat'));
            anotacion = im.groundTruth{1}.Segmentation;
            b = imgradient(anotacion);
            c = b > 0;
            
            im = imread(strcat(nombres{n},'.jpg'));
            
            for i = 2:2:50
                segm = segmentByClustering(im,'lab','watershed',i);
                segm = segm == 0;
                TP = TP + sum(sum(segm .* c));
                FP = FP + sum(sum(segm .* imcomplement(c)));
                FN = FN + sum(sum(imcomplement(segm) .* c));
                precision = TP/(TP+FP);
                recall = TP/(TP+FN);
                P(e,n,i/2) = precision;
                R(e,n,i/2) = recall;
            end
        end
    end
end

p = mean(P,2);
p = reshape(p,6,25);
p = mean(p,1);
p = reshape(p,1,25);

r = mean(R,2);
r = reshape(r,6,25);
r = mean(r,1);
r = reshape(r,1,25);

figure
plot(r,p);
xlabel('Recall');
ylabel('Precision');