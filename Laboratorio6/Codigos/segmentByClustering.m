function [ segmentation ] = segmentByClustering( rgbImage,featureSpace,clusteringMethod,numberOfClusters )
    
    a = rgbImage;
    k = numberOfClusters;

    if strcmp(featureSpace,'rgb') || strcmp(featureSpace,'rgb+xy')
        b1 = im2col(a(:,:,1),[1 1]);
        b2 = im2col(a(:,:,2),[1 1]);
        b3 = im2col(a(:,:,3),[1 1]);
    elseif strcmp(featureSpace,'hsv') || strcmp(featureSpace,'hsv+xy')
        a = rgb2hsv(a)*255;
        
        b1 = im2col(a(:,:,1),[1 1])*255;
        b2 = im2col(a(:,:,2),[1 1])*255;
        b3 = im2col(a(:,:,3),[1 1])*255;
    elseif strcmp(featureSpace,'lab') || strcmp(featureSpace,'lab+xy')
        a = rgb2lab(a);
        
        b1 = im2col(a(:,:,1),[1 1])*255/100;
        b2 = im2col(a(:,:,2),[1 1]);
        b3 = im2col(a(:,:,3),[1 1]);
    end
    
    if strcmp(featureSpace,'rgb+xy') || strcmp(featureSpace,'hsv+xy') || strcmp(featureSpace,'lab+xy')
        [sizeX,sizeY,~] = size(a);
        [X,Y] = meshgrid(1:sizeX,1:sizeY);
        Y = im2col(Y,[1 1])/max(max(Y))*128;
        X = im2col(X,[1 1])/max(max(X))*128;
        
        x = [b1' b2' b3' Y' X'];
    else
        x = [b1' b2' b3'];
    end

    if strcmp(clusteringMethod,'kmeans')
        ind = kmeans(double(x),k);
        segmentation = col2im(ind,[1 1],size(a(:,:,1)));
        
    elseif strcmp(clusteringMethod,'gmm')
        ind = fitgmdist(double(x),k);
        ind = cluster(ind,double(x));
        segmentation = col2im(ind,[1 1],size(a(:,:,1)));
    elseif strcmp(clusteringMethod,'watershed')
        media1 = mean(b1);
        media2 = mean(b2);
        media3 = mean(b3);
        
        var1 = sum((b1-media1).^2);
        var2 = sum((b2-media2).^2);
        var3 = sum((b3-media3).^2);
        
        vars = [var1 var2 var3];
        [~,ind] = max(vars);
        
        im = a(:,:,ind);
        b = imgradient(im);
        b = uint8(b);
        marker = imextendedmin(b,k);
        ng = imimposemin(b,marker);
        segmentation = watershed(ng);
    elseif strcmp(clusteringMethod,'hierarchical')
        [m,n,~] = size(a);
        a = imresize(a,[100 100]);
        bR = im2col(a(:,:,1),[1 1])';
        bG = im2col(a(:,:,2),[1 1])';
        bB = im2col(a(:,:,3),[1 1])';
        w = [bR bG bB];
        x = pdist(w);
        y = linkage(x);
        z = cluster(y,'cutoff',k);
        segmentation = col2im(z,[1 1],[100 100],'sliding');
        segmentation = imresize(segmentation,[m n]);
    end
end