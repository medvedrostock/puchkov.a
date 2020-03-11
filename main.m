function [] = main(nn_type)
    addpath('general');
    addpath(genpath('nets'));
    
    N = 10^5;       % number of samples
    m_last = 32;    % bit basis

    a_int = randi(2^m_last-1, [N 1]); % unique t_exWK (t excluding W and K)
    b_int = randi(2^m_last-1, [N 1]); % unique W

    % Convert in to binary (logical)
    a_bin = bin2log(dec2bin(a_int,m_last));
    b_bin = bin2log(dec2bin(b_int,m_last));
    
    switch(nn_type)
        case 'xor'
            c_bin = xor(a_bin, b_bin);
        case 'and'
            c_bin = and(a_bin, b_bin);
        case 'sum'
            c_int = a_int+b_int;
            c_bin = bin2log(dec2bin(c_int,m_last));
    end
    
    [a_bin, b_bin, c_bin] = deal(flip(a_bin,2),...
                                 flip(b_bin,2),...
                                 flip(c_bin,2));
    
    switch(nn_type)
        case {'xor', 'and'}
            xorand_nn(a_bin, b_bin, c_bin);
        case {'sum'}
            sum_nn(a_bin, b_bin, c_bin);
    end 
end