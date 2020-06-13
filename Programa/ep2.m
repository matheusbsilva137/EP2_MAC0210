clear variables;

% Geração da imagem a partir de uma função
% imgM = zeros(953, 953);
% for a = 1 : 3
%     for x = 1 : 953
%        for y = 1 : 953
%            if a == 1
%                imgM(x,y, a) = sin(x);
%            elseif a == 2
%                imgM(x,y, a) = (sin(x)+sin(y))/2;
%            else
%                imgM(x,y, a) = sin(x);
%            end
%        end
%     end
% end
% 
% imwrite(uint8(imgM), 'plot.png', 'png');

imgFileName = input('Informe o nome da imagem: ', 's');
method = input('Informe o método de descompressão da imagem (1- Bilinear, 2 - Bicúbico): ');
k = input('Informe o valor de k: ');

originalImg = imread(imgFileName);
compressedImg = compress(originalImg, k);
decompressedImg = decompress(compressedImg, method, k, k+2);

err = calculateError(originalImg, decompressedImg);
fprintf('Erro: %f\n', err);