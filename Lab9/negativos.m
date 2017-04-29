run('VLFEATROOT/toolbox/vl_setup.m')

rutas = dir(fullfile('images','TrainImages'));
rutas = {rutas([rutas.isdir]).name};
rutas = rutas(3:end);

negs = cell(1);
contador = 1;
for i = 1: numel(rutas)
	n = dir(fullfile('images','TrainImages',rutas{i},'*jpg'));
	n = {n.name};

	for j = 1:numel(n)
		im = imread(fullfile('images','TrainImages',rutas{i},n{j}));
		[x,y,~] = size(im);
		nx = randi([1 x-100]);
		ny = randi([1 y-100]);

		negs{contador}	= im(nx:nx+100,ny:ny+100,:);
		contador = contador +1;
	end
end

hogCellsSize = 8;
trainHogNeg = {};
for i = 1:numel(negs)
	im = im2single(negs{i});	
	trainHogNeg{i} = vl_hog(im,hogCellsSize);
end

save('HogsNegativos.mat','trainHogNeg')
