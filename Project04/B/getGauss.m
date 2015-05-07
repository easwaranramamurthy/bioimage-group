function [ val ] = getGauss( i, j, gauss )

if(~(floor(i)==i)&&~(floor(j)==j))
    list = [];
    if((i+0.5)>=1&&(i+0.5)<=size(gauss,1)&&(j+0.5)>=1&&(j+0.5)<=size(gauss,2))
        list = [list, gauss(i+0.5,j+0.5)];
    end
    if((i-0.5)>=1&&(i-0.5)<=size(gauss,1)&&(j+0.5)>=1&&(j+0.5)<=size(gauss,2))
        list = [list, gauss(i-0.5,j+0.5)];
    end
    if((i-0.5)>=1&&(i-0.5)<=size(gauss,1)&&(j-0.5)>=1&&(j-0.5)<=size(gauss,2))
        list = [list, gauss(i-0.5,j-0.5)];
    end
    if((i+0.5)>=1&&(i+0.5)<=size(gauss,1)&&(j-0.5)>=1&&(j-0.5)<=size(gauss,2))
        list = [list, gauss(i+0.5,j-0.5)];
    end
    
    val = mean(list);
elseif(~(floor(i)==i))
    list = [];
    if((i+0.5)>=1&&(i+0.5)<=size(gauss,1)&&(j)>=1&&(j)<=size(gauss,2))
        list = [list, gauss(i+0.5,j)];
    end
    if((i-0.5)>=1&&(i-0.5)<=size(gauss,1)&&(j)>=1&&(j)<=size(gauss,2))
        list = [list, gauss(i-0.5,j)];
    end
    val = mean(list);
elseif(~(floor(j)==j))
    list = [];
    if((i)>=1&&(i)<=size(gauss,1)&&(j+0.5)>=1&&(j+0.5)<=size(gauss,2))
        list = [list, gauss(i,j+0.5)];
    end
    if((i)>=1&&(i)<=size(gauss,1)&&(j-0.5)>=1&&(j-0.5)<=size(gauss,2))
        list = [list, gauss(i,j-0.5)];
    end
    val = mean(list);
else
    if((i)>=1&&(i)<=size(gauss,1)&&(j)>=1&&(j)<=size(gauss,2))
        val = gauss(i,j);
    else
        val = 0;
    end    
end

