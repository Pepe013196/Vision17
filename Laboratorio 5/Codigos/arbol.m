load rutas.mat;
load FB.mat;
load textons.mat;
%%
h = [];

nms = textread('names.txt','%s');
res = cell(numel(nms)/2,2);
for i = 1:numel(res)/2
    res{i,1} = nms{i*2-1};
    res{i,2} = nms{i*2};
end

R = cell(25*8,1);

for i=1:25
    for j = 1:8
        R((i-1)*8+j) = res(i,2);
    end
end

for i = 1:numel(rutas)
    garenLOL = assignTextons(fbRun(FB,imread(strcat('muestreo/',rutas{i}))),textons);
    h = [h,histc(garenLOL,1:25*8)/numel(garenLOL)];
end
save h.mat;
%%
n = 25;

disp(size(h))

arbol = TreeBagger(n,h,R');
save arbol.mat;

MC = zeros(25);

for i = 1:numel(res(:,1))
    for j = 31:40
        ruta = strcat('./test',res(i,1),'_',num2str(j),'.jpg');
        
        zedLOL = assignTextons(fbRun(FB,imread(ruta)),textons);
        R = B.predict(histec(zedLOL,1:25*8)/numel(zedLOL));
        
        if(strcmp(R,res(i,2)))
            MC(i,i) = MC(i,i) + 1;
        else
            MC(i,find(strcmp(res(:,1),R))) = MC(i,find(strcmp(res(:,1),R))) + 1;
        end
    end
end

save MC.mat;