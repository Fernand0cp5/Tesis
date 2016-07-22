for k=0:20;
    syms x
    xf(k)=2*x+3
    if k==0
        xf(k)=5
    else
        xf(k) = xf(k-1)+xf(k) 
    end
end
        