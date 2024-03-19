function [U] = fuzzy2crisp(fuzzy_U)

[P,N] = size(fuzzy_U); %C: number of partations, N: number of samples
U = zeros(P,N);
[~,indexs] = max(fuzzy_U);
for i = 1:N
    index = indexs(i);
    U(index,i) = 1;
end