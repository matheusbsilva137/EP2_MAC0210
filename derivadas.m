function  [val] = dfxy(img, a, i, j, h)
    val = (dfy(img, a, i+h-1, j, h) - dfx(img, a, i-h+1, j, h))/2*h;
end