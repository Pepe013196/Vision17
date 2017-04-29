run('VLFEATROOT/toolbox/vl_setup.m')

rutas = dir(fullfile('images','TrainCrops'));
rutas = {rutas([rutas.isdir]).name};
rutas = rutas(3:end);

ims = cell(1,4);
contador = 1;
for i = 1: numel(rutas)
	n = dir(fullfile('images','TrainCrops',rutas{i},'*jpg'));
	n = {n.name};
	
	for j = 1:numel(n)
		ims{contador,1}	= imread(fullfile('images','TrainCrops',rutas{i},n{j}));
		contador = contador +1;
	end
end

for i = 1:numel(n(:,1))
	ims{i,2} = imresize(ims{i,1},0.75);
	ims{i,3} = imresize(ims{i,1},0.5);
	ims{i,4} = imresize(ims{i,1},0.25);
end


hogCellsSize = 8;
trainHog = {};
for i = 1:numel(ims)/4
	for j = 1:4
		im = im2single(ims{i,j});	
		trainHog{(i-1)*4+j} = vl_hog(im,hogCellsSize);
	end
end

save trainHog
