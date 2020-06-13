function err = calculateError(originalImg, decompressedImg)
    orig = double(originalImg);
    dec = double(decompressedImg);
    errR = norm(orig(:,:,1) - dec(:,:,1))/norm(orig(:,:,1));
    errG = norm(orig(:,:,2) - dec(:,:,2))/norm(orig(:,:,2));
    errB = norm(orig(:,:,3) - dec(:,:,3))/norm(orig(:,:,3));
    err = (errR + errG + errB)/3;
end