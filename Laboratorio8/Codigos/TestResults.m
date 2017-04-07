load('confMat.mat');
%Test
mN = normr(confMat);
ACA = 100*mean(diag(mN));

imagesc(mN);
title(strcat('ACA = ',num2str(ACA),'%'));

%%
%Train
load('baseline-result.mat')
figure
imagesc(confus);
mN = normc(confus);
ACA = 100*mean(diag(mN));
title(strcat('ACA = ',num2str(ACA),'%'))