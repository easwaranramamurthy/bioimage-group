function [ isLocalMin ] = localMin( block )

blockSize = size(block,1);

middle = floor(blockSize/2)+1;

isLocalMin = (min(min(block))==block(middle,middle))

end

