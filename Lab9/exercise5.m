run('VLFEATROOT/toolbox/vl_setup.m')

% Training cofiguration
targetClass = 1 ;
numHardNegativeMiningIterations = 5 ;
schedule = [1 2 5 5 5] ;

% Scale space configuration
hogCellSize = 8 ;
minScale = -1 ;
maxScale = 3 ;
numOctaveSubdivisions = 3 ;
scales = 2.^linspace(...
  minScale,...
  maxScale,...
  numOctaveSubdivisions*(maxScale-minScale+1)) ;

% -------------------------------------------------------------------------
% Step 5.1: Construct custom training data
% -------------------------------------------------------------------------

% Load object examples
trainImages = {} ;
trainBoxes = [] ;
trainBoxPatches = {} ;
trainBoxImages = {} ;
trainBoxLabels = [] ;

% Construct negative data
rutas = dir(fullfile('images','TrainImages'));
rutas = {rutas([rutas.isdir]).name};
rutas = rutas(3:end);

contador = 1;
trainImages = {};

for i =1:numel(rutas)
	n = dir(fullfile('images','TrainImages',rutas{i},'*jpg'));
	for j = 1:numel(n)
		trainImages{contador} = fullfile('images','TrainImages',rutas{i},n{j}.name);
		contador = contador + 1;
	end
end

% Construct positive data
rutas = dir(fullfile('images','TrainCrops'));
rutas = {rutas([rutas.isdir]).name};
rutas = rutas(3:end);

contador = 1;
names = {};

for i =1:numel(rutas)
	n = dir(fullfile('images','TrainImages',rutas{i},'*jpg'));
	for j = 1:numel(n)
		names{contador} = fullfile('images','CropImages',rutas{i},n{j}.name);
		contador = contador + 1;
	end
end

for i=1:numel(names)
  im = imread(names{i}) ;
  im = imresize(im, [64 64]) ;
  trainBoxes(:,i) = [0.5 ; 0.5 ; 64.5 ; 64.5] ;
  trainBoxPatches{i} = im2single(im) ;
  trainBoxImages{i} = names{i} ;
  trainBoxLabels(i) = 1 ;
end
trainBoxPatches = cat(4, trainBoxPatches{:}) ;

% Compute HOG features of examples (see Step 1.2)
trainBoxHog = {} ;
for i = 1:size(trainBoxPatches,4)
  trainBoxHog{i} = vl_hog(trainBoxPatches(:,:,:,i), hogCellSize) ;
end
trainBoxHog = cat(4, trainBoxHog{:}) ;
modelWidth = size(trainBoxHog,2) ;
modelHeight = size(trainBoxHog,1) ;

% -------------------------------------------------------------------------
% Step 5.3: Train with hard negative mining
% -------------------------------------------------------------------------

% Initial positive and negative data
pos = trainBoxHog(:,:,:,ismember(trainBoxLabels,targetClass)) ;
neg = zeros(size(pos,1),size(pos,2),size(pos,3),0) ;

for t=1:numHardNegativeMiningIterations
  numPos = size(pos,4) ;
  numNeg = size(neg,4) ;
  C = 1 ;
  lambda = 1 / (C * (numPos + numNeg)) ;
  
  fprintf('Hard negative mining iteration %d: pos %d, neg %d\n', ...
    t, numPos, numNeg) ;
    
  % Train an SVM model (see Step 2.2)
  x = cat(4, pos, neg) ;
  x = reshape(x, [], numPos + numNeg) ;
  y = [ones(1, size(pos,4)) -ones(1, size(neg,4))] ;
  w = vl_svmtrain(x,y,lambda,'epsilon',0.01,'verbose') ;
  w = single(reshape(w, modelHeight, modelWidth, [])) ;
    
end


% -------------------------------------------------------------------------
% Step 5.3: Evaluate the model on the test data
% ------------------------------------------------------------------------
