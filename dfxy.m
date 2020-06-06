function  [val] = dfxy(img, a, i, j, h, p)
    if i == 1
        val = (dfy(img, a, i+h-1, j, h, p) - dfy(img, a, i, j, h, p))/h;
    elseif i == p
        val = (dfy(img, a, i, j, h, p) - dfy(img, a, i-h+1, j, h, p))/h;
    else
        val = (dfy(img, a, i+h-1, j, h, p) - dfy(img, a, i-h+1, j, h, p))/2*h;
    end
end