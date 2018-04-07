source=imread('source.jpg');
target = imread('target.jpg');
source = imresize(source, 0.7);
[h w d]=size(source);
row_start = 220;
col_start = 2;

%% add source to target
for i= row_start+1 : (row_start + h )
    for j = col_start+1 : (col_start + w )
        for k = 1:3
            target(i,j,k) = source(i-row_start, j-col_start,k);
        end
    end
end
% target before blending
figure, imshow(target)

