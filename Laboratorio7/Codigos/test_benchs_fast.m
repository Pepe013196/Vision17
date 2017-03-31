%% 4. morphological version for : all the benchmarks for results stored as a cell of segmentations
addpath('benchmarks');

imgDir = 'C:\Users\fabia\Dropbox\SEMESTRE 9 - 201710\Vision\Labs\5 - BSDS500\BSDS500FastBench\BSR\BSDS500\data\images\test';
gtDir = 'C:\Users\fabia\Dropbox\SEMESTRE 9 - 201710\Vision\Labs\5 - BSDS500\BSDS500FastBench\BSR\BSDS500\data\groundTruth\test';
inDir = 'C:\Users\fabia\Dropbox\SEMESTRE 9 - 201710\Vision\Labs\5 - BSDS500\Test1\DefiniPOLLAS';
outDir = 'eval/test_all_fast';
mkdir(outDir);
nthresh = 99;

tic;
allBench_fast(imgDir, gtDir, inDir, outDir, nthresh);
toc;

plot_eval(outDir)

title('Curva PR para GMM')