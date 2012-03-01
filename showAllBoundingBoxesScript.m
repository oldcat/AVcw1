addpath(genpath('~/AV/'))

path = '~/AV/train/';

seqs = listSeqs(path);

dim = size(seqs);

for i = 10:10 %dim(1)
    boundingBoxTest(seqs(i,:), i, 1, path);
end
