function accuracy = test_accuracy(hidden_layer_weights, output_layer_weights)
        M = readtable('avila/avila-ts.txt');
        x = table2array(M(:,1:10));
        tags = string(table2array(M(:,11)));
        

        right = 0;
        wrong = 0;

        for i=1:size(M,1)
                ENC = getENC(tags(i));
                [argval, argmax_f] = ...
                max(softmax_stable(sigmoid(x(i,:)*hidden_layer_weights)*...
                output_layer_weights));

                [argval, argmax_s] = max(ENC);
                if(argmax_f == argmax_s)
                        right = right + 1;
                else
                        wrong = wrong + 1;
                end
        end
        accuracy = right*100/size(M,1);