image=imread('blurryCat.jpg');
[h w d]=size(image);
U = double(reshape(image,w*h,d))/255;
figure, imshow(image);
%% Write your method here
G = gradient(h,w);
U_t = transpose(U);
g = G.*U;

G_t = transpose(G);
cs = 1.2;
cu = 3;
len = length(G_t.*G);
I = 1:len;
J = 1:len;
V = ones(len,1);
id = sparse(I,J,V);


rhs = cs.*G_t.*g +cu.*U;
lhs = (G_t.*G + cu.*id);
rhs_t = transpose(rhs);
U = rhs_t./lhs;

U = transpose(U);

image=uint8(reshape(U,h,w,d)*255);
hold on;
figure, imshow(image);
imwrite(image, 'out.png');
