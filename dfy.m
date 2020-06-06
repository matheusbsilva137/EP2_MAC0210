function  [val] = dfy(img, a, i, j, h, p)
    if j == 1
        val = (img(i, j+h-1, a) - img(i, j, a))/h;
    elseif j == p
        val = (img(i, j, a) - img(i, j-h+1, a))/h;
    else
        val = (img(i, j+h-1, a) - img(i, j-h+1, a))/2*h;
    end
end