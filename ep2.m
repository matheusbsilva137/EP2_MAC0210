clear variables;
imgFileName = input('Informe o nome da imagem: ', 's');
originalImg = imread(imgFileName);
compressedImg = compress(originalImg, 2);
decompressedImg = decompress(compressedImg, 2, 2, 4);

imgM = zeros(1498, 1498);
for a = 1 : 3
    for x = 1 : 1498
       for y = 1 : 1498
           if a == 1
               imgM(x,y, a) = sin(1/x);
           elseif a == 2
               imgM(x,y, a) = 0;
           else
               imgM(x,y, a) = sin(1/x);
           end
       end
    end
end

imwrite(imgM, 'plot.png', 'png');
err = calculateError(originalImg, decompressedImg);
fprintf('Erro: %f\n', err);