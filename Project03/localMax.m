function [ isLocalMax ] = localMax( block )

blockSize = size(block,1);

middle = floor(blockSize/2)+1;

isLocalMax = (max(max(block))==block(middle,middle));

end

