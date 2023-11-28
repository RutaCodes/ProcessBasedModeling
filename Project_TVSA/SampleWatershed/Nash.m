function [Out,Xend] = Nash(K,N,Xbeg,Inp);

%Loop through the reservoirs
for Res = 1:N
    OO(Res) = K*Xbeg(Res);
    Xend(Res) = Xbeg(Res)-OO(Res);
    
    if Res == 1
        Xend(Res) = Xend(Res) + Inp;
    else
        Xend(Res) = Xend(Res) + OO(Res-1);
    end
end
Out = OO(N);