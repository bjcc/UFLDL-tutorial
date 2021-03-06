function pooledFeatures = cnnPool(poolDim, convolvedFeatures)
%cnnPool Pools the given convolved features
%
% Parameters:
%  poolDim - dimension of pooling region
%  convolvedFeatures - convolved features to pool (as given by cnnConvolve)
%                      convolvedFeatures(imageRow, imageCol, featureNum, imageNum)
%
% Returns:
%  pooledFeatures - matrix of pooled features in the form
%                   pooledFeatures(poolRow, poolCol, featureNum, imageNum)
%     

numImages = size(convolvedFeatures, 4);
numFilters = size(convolvedFeatures, 3);
convolvedDim = size(convolvedFeatures, 1);

pooledFeatures = zeros(convolvedDim / poolDim, ...
        convolvedDim / poolDim, numFilters, numImages);

% Instructions:
%   Now pool the convolved features in regions of poolDim x poolDim,
%   to obtain the 
%   (convolvedDim/poolDim) x (convolvedDim/poolDim) x numFeatures x numImages 
%   matrix pooledFeatures, such that
%   pooledFeatures(poolRow, poolCol, featureNum, imageNum) is the 
%   value of the featureNum feature for the imageNum image pooled over the
%   corresponding (poolRow, poolCol) pooling region. 
%   
%   Use mean pooling here.

%%% YOUR CODE HERE %%%
filter = ones(poolDim);
for imNum = 1:numImages
    for filterNum = 1:numFilters
        % Obtain the pooledImage's fetures
        im = squeeze(convolvedFeatures(:, :, imNum));
        pooledImage = conv2(im,filter,'valid');
        % ?????
        pooledImage = pooledImage(1:poolDim:end,1:poolDim:end);
        pooledImage = pooledImage./(poolDim*poolDim); 
        pooledImage = reshape(pooledImage,convolvedDim / poolDim, ...
            convolvedDim / poolDim, 1, 1);
        pooledFeatures(:,:,filterNum,imNum) = pooledImage;
    end
end

        
        
end

