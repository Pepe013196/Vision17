rutas = dir(fullfile('BSR','BSDS500','data','images','test','*jpg'));
segs = cell(1,36);

for j = 1:numel(rutas)
    a = imread(fullfile('BSR','BSDS500','data','images','test',rutas(j).name));
    
    for k = 2:7
        for i = 3:4:23
	    try
		b = segmentByClustering(a,'lab','gmm',k);
	    catch
		warning('Problema usando gmm. Se reeemplaza por kmeans');
		b = segmentByClustering(a,'lab','kmeans',k);
	    end
            c = ordfilt2(b,(i*i+1)/2,ones(i),'symmetric');
            segs{1,6*(k-2)+(i+1)/4} = c;
        end
    end
    
    save(strcat('Test2/',rutas(j).name(1:end-4),'.mat'),'segs');
end
