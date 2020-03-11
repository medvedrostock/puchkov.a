function [] = sum_nn(a, b, c)
    % Single bit NN
    [n,m] = size(a);
    [Xc, Yc] = deal(cell(n,1));
    
    for i = 1:n
        Xc{i} = double(cat(1,...
                    a(i, :),...
                    b(i, :)));
        Yc{i}  = categorical(c(i, 1:m));
    end
    
    [X_train, Y_train, X_test, Y_test] = mk_traintets(Xc, Yc);
    
%     numResponses = m;
    featureDimension = 2;
    numHiddenUnits = 32;
    numClasses = 2;
    
    layers = [ ...
        sequenceInputLayer(featureDimension)
        lstmLayer(numHiddenUnits,'OutputMode','sequence')
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer];
    
    options = trainingOptions('adam', ...
                            'MaxEpochs',100, ...
                            'MiniBatchSize',1000, ...
                            'InitialLearnRate',0.01, ...
                            'ValidationData',{X_test,Y_test},...
                            'Plots','training-progress',...
                            'Verbose',1);
                                             
   net = trainNetwork(X_train,Y_train,layers,options); 
   
end

function [X_train , Y_train, X_test, Y_test] = mk_traintets(Xc, Yc, trainshare)
    if nargin == 2
        trainshare = 0.7;
    end
    
    n = length(Xc);
    train = rand(n,1) < trainshare;
    
    X_train = Xc(train);
    Y_train = Yc(train);
    X_test = Xc(~train);
    Y_test = Yc(~train);
end