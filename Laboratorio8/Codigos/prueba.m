rutas = dir(fullfile('imageNet200','test'));
%rutas = dir(fullfile('C:','Users','fabia','Downloads','imageNet200','imageNet200','train'));

save('rutas');

imgs = cell(size(rutas)-[2 0]);
n = zeros(size(rutas)-[2 0]);
a = zeros(numel(rutas)-2,10);

for i = 3:numel(rutas)
    imgs{i-2} = dir(fullfile('imageNet200','test',rutas(i).name,'*JPEG'));
    n(i-2) = numel(imgs{i-2});
    a(i-2,:) = randperm(n(i-2),10);
	
	mkdir (fullfile('subsetTest'), rutas(i).name);
	for j = 1:10
		copyfile(fullfile('imageNet200','test',rutas(i).name,imgs{i-2}(a(i-2,j)).name), fullfile('subsetTest',rutas(i).name));
	end
end
