clear; clc;

% Set up K constant
K =['428a2f98'; '71374491'; 'b5c0fbcf'; 'e9b5dba5'; '3956c25b'; '59f111f1'; '923f82a4'; 'ab1c5ed5';
    'd807aa98'; '12835b01'; '243185be'; '550c7dc3'; '72be5d74'; '80deb1fe'; '9bdc06a7'; 'c19bf174';
    'e49b69c1'; 'efbe4786'; '0fc19dc6'; '240ca1cc'; '2de92c6f'; '4a7484aa'; '5cb0a9dc'; '76f988da';
    '983e5152'; 'a831c66d'; 'b00327c8'; 'bf597fc7'; 'c6e00bf3'; 'd5a79147'; '06ca6351'; '14292967';
    '27b70a85'; '2e1b2138'; '4d2c6dfc'; '53380d13'; '650a7354'; '766a0abb'; '81c2c92e'; '92722c85';
    'a2bfe8a1'; 'a81a664b'; 'c24b8b70'; 'c76c51a3'; 'd192e819'; 'd6990624'; 'f40e3585'; '106aa070';
    '19a4c116'; '1e376c08'; '2748774c'; '34b0bcb5'; '391c0cb3'; '4ed8aa4a'; '5b9cca4f'; '682e6ff3';
    '748f82ee'; '78a5636f'; '84c87814'; '8cc70208'; '90befffa'; 'a4506ceb'; 'bef9a3f7'; 'c67178f2'];

K = dec2bin(hex2dec(K));

r = 64;
m_last = 12;


% Select m last bits
Km_dec = bin2dec(K(r,end-m_last+1:end)); % K[round] constant

texWK_dec_uq = 0:2^m_last;               % unique t_exWK (t excluding W and K)
W_dec_uq = 0:2^m_last;                   % unique W

% Combinations of t 
data = all_combinations({texWK_dec_uq, W_dec_uq});

% Define output variable
[texWK_dec, W_dec] = deal(data(:,1), data(:,2));
clear data
t = texWK_dec + W_dec + Km_dec;

% Define Inputs and output
texWK_bin = bin2log(dec2bin(texWK_dec,m_last));
W_bin = bin2log(dec2bin(W_dec,m_last));
t_bin = bin2log(dec2bin(t,m_last));

texWK_bin(:,1) = [];
W_bin(:,1) = [];
t_bin(:,1:2) = [];

X = double(cat(2,...
           texWK_bin,...
           W_bin));

Y = double(t_bin);
% [uq, ~, iq] = unique(Y,'rows');
% Y = full(ind2vec(iq',length(uq)))';

clear texWK_dec W_dec t texWK_bin  W_bin

function [Z] = bin2log(Z)
    Z = Z == '1';
end