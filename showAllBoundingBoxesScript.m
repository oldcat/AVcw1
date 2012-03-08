addpath(genpath('~/AV/'))

path = '~/AV/train/';

seqs = listSeqs(path);

dim = size(seqs);

for i = 10:dim(1)
    boundingBoxTest(seqs(i,:), 1, 1, path, 3);
end
