function [y, net] = xorand_nn(a, b, c)
    % Single bit NN
    for j = 1:size(c, 2)
        X = cat(2,...
                a(:, j),...
                b(:, j));

        Y  = c(:, j);
        [y, net] = pattern_net(X, Y);
    end
end