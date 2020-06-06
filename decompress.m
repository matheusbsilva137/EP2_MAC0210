function [decompressedImg] = decompress(compressedImg, method, k, h)
    [n, n, c] = size(compressedImg);
    p = n + (n-1)*k;
    
    imgM = zeros(p, p, c);
    for a = 1 : c
       for x = 1 : n
           for y = 1 : n
               imgM((x-1)*(k+1) + 1, (y-1)*(k+1) + 1, a) = compressedImg(x, y, a);
           end
       end
    end
    
    if method == 1
        %Bilinear
        H = [1, 0, 0, 0; 1, 0, h, 0; 1, h, 0, 0; 1, h, h, h*h];
        A = zeros(4, 1);
        F = zeros(4, 1);
        
        for i = 1 : h - 1 : p-h+1
            for j = 1 : h - 1 : p-h+1
                for a = 1 : c
                    F = [imgM(i, j, a); imgM(i, j+h-1, a); imgM(i+h-1, j, a); imgM(i+h-1, j+h-1, a)];
                    A = H\F;
                    %Procura os pontos a ser interpolados
                    for x = i : i + h - 1
                       for y = j : j + h - 1
                           %O ponto encontrado pertence ao Quadrado
                           if (x ~= i || y ~= j) && (x ~= i || y ~= j + h - 1) && (x ~= i + h - 1 || y ~= j) && (x ~= i + h - 1 || y ~= j + h - 1)
                               imgM(x, y, a) = A(1,1) + A(2,1)*(x-i) + A(3,1)*(y-j) + A(4,1)*(x-i)*(y-j);
                           end
                       end
                    end
                end
            end
        end
    else 
        %Bicúbico
        B = [1, 0, 0, 0; 1, h, h*h, h*h*h; 0, 1, 0, 0; 0, 1, 2*h, 3*h*h];
        A = zeros(4, 4);
        F = zeros(4, 4);
        
        for i = 1 : h - 1 : p-h+1
            for j = 1 : h - 1 : p-h+1
                for a = 1 : c
                    F = [imgM(i, j, a), imgM(i, j+h-1, a), dfy(imgM, a, i, j, h, p), dfy(imgM, a, i, j+h-1, h, p);
                         imgM(i+h-1, j, a), imgM(i+h-1, j+h-1, a), dfy(imgM, a, i+h-1, j, h, p), dfy(imgM, a, i+h-1, j+h-1, h, p);
                         dfx(imgM, a, i, j, h, p), dfx(imgM, a, i, j+h-1, h, p), dfxy(imgM, a, i, j, h, p), dfxy(imgM, a, i, j+h-1, h, p);
                         dfx(imgM, a, i+h-1, j, h, p), dfx(imgM, a, i+h-1, j+h-1, h, p), dfxy(imgM, a, i+h-1, j, h, p), dfxy(imgM, a, i+h-1, j+h-1, h, p)
                        ];
                    A = (B\F)*inv(transpose(B));
                    %Procura os pontos a ser interpolados
                    for x = i : i + h - 1
                       for y = j : j + h - 1
                           %O ponto encontrado pertence ao Quadrado
                           if (x ~= i || y ~= j) && (x ~= i || y ~= j + h - 1) && (x ~= i + h - 1 || y ~= j) && (x ~= i + h - 1 || y ~= j + h - 1)
                               VX = [1, x-i, (x-i)*(x-i), (x-i)*(x-i)*(x-i)];
                               VY = [1; y-j; (y-j)*(y-j); (y-j)*(y-j)*(y-j)];
                               imgM(x, y, a) = VX * A * VY;
                           end
                       end
                    end
                end
            end
        end
    end
    imwrite(uint8(imgM), 'decompressed.png', 'png');
    decompressedImg = imread('decompressed.png', 'png');
end