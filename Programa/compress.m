function [compressedImg] = compress(originalImg, k)
    [p, p, c] = size(originalImg);
    n = floor((p+k)/(1+k));
    
    imgM = zeros(n, n, c);
    for a = 1 : c
       for x = 1 : n
           for y = 1 : n
               imgM(x,y,a) = originalImg((x-1)*(k+1) + 1, (y-1)*(k+1) + 1, a);
           end
       end
    end
            
    imwrite(uint8(imgM), 'compressed.png', 'png');
    compressedImg = imread('compressed.png', 'png');
end