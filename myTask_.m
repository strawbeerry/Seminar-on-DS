
image=imread('blurryImage.png');
[h w d]=size(image);

U = double(reshape(image,w*h,d))/255;
figure, imshow(image);
%% Write your method here

g = [];
G = gradient(h,w);
g = G*U;


%for cs = 0.1:0.1:0.5
%for cu = 0.6:0.1:1
cs = 3;
cu = 0.5;
len = length(G'*G);
I = 1:len;
J = 1:len;
V = ones(len,1);
Id = sparse(I,J,V);

upper = cs*G'*g + cu*U;
lower = (G'*G + cu*Id);
a = upper;
U_new = a'/lower';

images =uint8(reshape(U_new',h,w,d)*255);
%subplot(len_row,len_h,i)
figure,imshow(images)
title(['cs=' num2str(cs) ' cu=' num2str(cu)])

imwrite(image,'out.png')
