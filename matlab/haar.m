function out = haar(in)

sz = size(in);
szt = sz;
out = in;
p = circshift((1:ndims(in))',-1);
while(any(sz>1))
  for d = 1:numel(sz)
    if(sz(1)>1)
      S = subs(sz);
      [szt(d),t] = kernel(subsref(out,S));
      out = subsasgn(out,S,t);
    end
    out = permute(out,p);
    sz  = sz(p);
  end
  sz=szt;
end
end

%%
function [N,out] = kernel(in)
% adapted for multidimensional input. reduction on rows
NN = size(in,1);
N=NN/2;
t=zeros(size(in));
t(    1:N  ,:) = in(1:2:NN,:)+in(2:2:NN,:);
t((N+1):NN ,:) = in(1:2:NN,:)-in(2:2:NN,:);
t(    1:NN ,:) = t(1:NN,:).*0.70710678118654752440;
out = t;
end

%%
function S = subs(sz)
c = cell([1 numel(sz)]);
for i=1:numel(sz)
  c{i} = 1:sz(i);
end
S = substruct('()',c);
end