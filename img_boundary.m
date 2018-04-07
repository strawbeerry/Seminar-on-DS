source=imread('source.jpg');
target = imread('target.jpg');
source = imresize(source, 0.7);
[h w d]=size(source);
row_start = 220;
col_start = 2;

%% add source to target
U = [];
U_b = [];
S = zeros(2*(h+w) -4, (h+2)*(w+2)); % same as size of target matrix
boundary =  target(row_start:(row_start+h+1), col_start,1:3);
U(1:h+2, 1:3) = reshape(boundary, [h+2 3]);
U_b(1:h+2, 1:3) = U(1:h+2, 1:3);
count = 1;
j = col_start;
for i = row_start:(row_start+h+1)
    S(count , (j-1)*w + i) = 1;
    count = count + 1;
end
for j= 1 : w
    U(end+1,1:3) = target(row_start, col_start+j, 1:3);
    U_b(end+1,1:3) = target(row_start, col_start+j , 1:3);
    S(count, row_start + (col_start-1+j)*w) = 1;
    count = count+1;
    for i = 1 : h
        U(end+1,1:3) = source(i,j, 1:3);
        for k = 1:3
            target(row_start+i, col_start+j,k) = source(i, j,k);
        end
    end
    U(end+1,1:3) = target(row_start+i , col_start+j , 1:3);
    U_b(end+1,1:3) = target(row_start+i , col_start+j , 1:3); 
    S(count, row_start+h + (col_start-1+j)*w) = 1;
    count = count+1;
end
boundary =  target(row_start:(row_start+h+1), col_start+w+1, 1:3);
U(end+1:end+h+2, 1:3) = reshape(boundary, [h+2 3]);
U_b(end+1:end+h+2, 1:3) = reshape(boundary, [h+2 3]);

j = col_start+w+1;
for i = row_start:(row_start+h+1)
    S(count , (j-1)*w + i) = 1;
    count = count + 1;
end
% target before blending
figure, imshow(target)

G = gradient(h+2,w+2);
g = G*U;
g(1:(h+2-1),:) = 0;
g((h+2-1)*(w+2-1)+1:(h+2-1)*w,:) = 0;
g((h+2-1)*w+1:(h+2-1)*w+(w-1),:) = 0;
g((h+2-1)*w + (h+2-1)*(w-1) +1: (h+2-1)*w + (h+2)*(w-1),:) = 0;

a = 0.4;
term1 = G'*g;
term2 = a*S'*U_b;
term3 = G'*G;
term4 = a*S'*S
upper = G'*g + a*S'*U_b;
lower = G'*G + a*S'*S;