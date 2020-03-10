clc; clear close;
N = 10^5;
m_last = 32;

a_int = randi(2^m_last-1, [N 1]); % unique t_exWK (t excluding W and K)
b_int = randi(2^m_last-1, [N 1]); % unique W

c_int = a_int + b_int;

a_bin = bin2log(dec2bin(a_int,m_last));
b_bin = bin2log(dec2bin(b_int,m_last));
c_bin = bin2log(dec2bin(c_int,m_last));

X = cat(2,...
    a_bin(:, end-1:end),...
    b_bin(:, end-1:end));

Y = c_bin(:, end);

% lstm_ar(X,Y);

function [] = lstm_ar(X, Y)
    [X, Y] = deal(double(X), categorical(Y));
    [n, m] = size(X);

    ntrain = round(0.7*n); 
    train = randperm(n,ntrain);
    test = setdiff(1:n, train);

    [Xc, Yc] = deal(cell(1, ntrain));
    for i = 1:n
        Xc{i} = X(i,:)';
        Yc{i} = Y(i,:);
    end

    [Xtrain, Ytrain] =  deal(Xc(train), Y(train));
    [Xtest, Ytest] =  deal(Xc(test), Y(test));


    numFeatures = m;
    numClasses = length(unique(Y));
    numHiddenUnits = 32;

    layers = [ ...
        sequenceInputLayer(numFeatures)
        lstmLayer(numHiddenUnits{1},'OutputMode','sequence')
        dropoutLayer(0.2)
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer];

    maxEpochs = 10000;
    miniBatchSize = round(0.30*ntrain);

    options = trainingOptions('adam', ...
        'MaxEpochs',maxEpochs, ...
        'MiniBatchSize',miniBatchSize, .....
        'Shuffle','never', ...
        'ValidationData',{Xtest, Ytest}, ...
        'ValidationFrequency',5, ...    
        'Plots','training-progress',...
        'Verbose',1);

    net = trainNetwork(Xtrain,Ytrain,layers,options);
end
