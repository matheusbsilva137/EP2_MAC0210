function  [val] = dfx(img, a, i, j, h, p)
    if i == 1
        val = (img(i+h-1, j, a) - img(i, j, a))/h;
    elseif i == p
        val = (img(i, j, a) - img(i-h+1, j, a))/h;
    else
        val = (img(i+h-1, j, a) - img(i-h+1, j, a))/2*h;
    end
end