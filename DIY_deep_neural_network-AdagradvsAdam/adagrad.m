function [hidden_layer_weights, output_layer_weights] = adagrad(data,labels,epochs)
        n = size(data,1);
        it = 1;
        eta = 0.5;
        hidden_layer_weights = rand(10,64)-0.5;
        output_layer_weights = rand(64,12)-0.5;
        pos =1;
        G_hid1 = zeros(64);
        G_out = zeros(12);
        xi = repmat(1e-2,12,1);
        tic
        while(it < epochs*n) %nr de epoci
                %forward propagation
                layer1 = sigmoid(data(pos,:)*hidden_layer_weights);
                output = softmax_stable(layer1*output_layer_weights);
                %label encodat
                ENC = getENC(labels(pos));

                %backpropagation 
                err = (output-ENC);
                grad = layer1'*(output-ENC);
                err1 = output_layer_weights*err'.*((layer1.*(1-layer1))');
                grad_h1 = data(pos,:)'*err1';

                %updating weights

                %output_layer
                G_out = G_out + grad'*grad;
                beta_t = sqrt(diag(G_out));
                beta_t = beta_t + xi;
                output_layer_weights = output_layer_weights - (eta./beta_t)'.*grad;

                %hidden layer 1
                G_hid1 = G_hid1 + grad_h1'*grad_h1;
                beta_t = sqrt(diag(G_hid1));
                beta_t = beta_t + repmat(1e2,size(diag(G_hid1)));
                hidden_layer_weights = hidden_layer_weights - (eta./beta_t)'.*grad_h1;


                it = it + 1;
                pos = pos+1; %training a single instance at a time
                if pos > n
                        pos = pos - n+1;
                end
        end
        toc