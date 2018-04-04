function [ G ] = gradient( h, w )
%GRADIENT Summary of this function goes here
%   Detailed explanation goes here
i = ones(2*h*(w-1)+2*w*(h-1),1);
j = ones(2*h*(w-1)+2*w*(h-1),1);
v = ones(2*h*(w-1)+2*w*(h-1),1);

% collect triplets here

G = sparse(i,j,v);


