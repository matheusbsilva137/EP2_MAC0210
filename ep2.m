clear variables;

imgM = zeros(442, 442);
for a = 1 : 3
    for x = 1 : 442
       for y = 1 : 442
           if a == 1
               imgM(x,y, a) = x*x*(sin(1/(x-20)));
           elseif a == 2
               imgM(x,y, a) = y*y*(sin(1/(y-20)));
           else
               imgM(x,y, a) = 2;
           end
       end
    end
end

imwrite(uint8(imgM), 'plot.png', 'png');

imgFileName = input('Informe o nome da imagem: ', 's');
method = input('Informe o método de descompressão da imagem (1- Bilinear, 2 - Bicúbico): ');
k = input('Informe o valor de k: ');
originalImg = imread(imgFileName);
compressedImg = compress(originalImg, k);
decompressedImg = decompress(compressedImg, method, k, k+2);

err = calculateError(originalImg, decompressedImg);
fprintf('Erro: %f\n', err);