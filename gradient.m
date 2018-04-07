function [ G ] = gradient( h, w )
%GRADIENT Summary of this function goes here
%   Detailed explanation goes here
%i = zeros(2*h*(w-1)+2*w*(h-1),1);
%j = zeros(2*h*(w-1)+2*w*(h-1),1);
%v = zeros(2*h*(w-1)+2*w*(h-1),1);

i = [];j = [];v = [];

for session = 1:(w)
for row = 1:(h-1)

    idx = 2*((session-1)*(h-1)+row);
    
    i(idx-1) = idx/2;
    i(idx) = i(idx-1);
    j(idx-1) = h*(session-1)+row;
    j(idx) = j(idx-1)+1;
    v(idx-1) = 1;
    v(idx) = -1;
    
end
end

for row = (1):h
    for c = 1:(w-1)
    
        R = 2*((h-1)*w+(row-1)*(w-1)+c);
        if R ==0
            display(R);
        end
        i(R-1) = R/2;
        i(R) = i(R-1);
        j(R-1) = row+h*(c-1);
        j(R) = j(R-1)+h;
        v(R-1) = -1;
        v(R) = 1;
    end
end

%display(i);
%display(j);
%display(v);


% collect triplets here

G = sparse(i,j,v);


