function [hidden_layer_weights, output_layer_weights] = adam(data,labels,epochs)
        n = size(data,1);
        it = 1;
        eta = 0.1;
        epsilon = 1e-8;
        pos = 1;
        hidden_layer_weights = rand(10,64)-0.5;
        output_layer_weights = rand(64,12)-0.5;
        step_size = 0.001;
        beta_1 = 0.9;
        beta_2 = 0.999;
        m = 0;
        v = 0;
        m1 = 0;
        v1 = 0;
        tic
        while(it < epochs*n)
                %forward propagation
                layer1 = sigmoid(data(pos,:)*hidden_layer_weights);
                output = softmax_stable(layer1*output_layer_weights);

                %get one-hot encoding
                ENC = getENC(labels(pos));
                %backpropagation
                grad = layer1'*(output-ENC);
                err = (output-ENC);
                err1 = output_layer_weights*err'.*((layer1.*(1-layer1))');
                grad_h1 = data(pos,:)'*err1';

                %updating weights
                %output layer
                m = beta_1*m + (1- beta_1)*grad;
                v = beta_2*v + (1 - beta_2)*grad.*grad;
                m_hat = m / (1 - power(beta_1, it));
                v_hat = v / (1 - power(beta_2, it));
                output_layer_weights = output_layer_weights - (step_size * m_hat) ./ (sqrt(v_hat) + epsilon);

                %hidden layer 1
                m1 = beta_1*m1 + (1- beta_1)*grad_h1;
                v1 = beta_2*v1 + (1 - beta_2)*grad_h1.*grad_h1;
                m_hat_1 = m1 / (1 - power(beta_1, it));
                v_hat_1 = v1 / (1 - power(beta_2, it));
                hidden_layer_weights = hidden_layer_weights - (step_size * m_hat_1) ./ (sqrt(v_hat_1) + epsilon);
                it = it + 1;
                pos = pos + 1; %training a single instance at a time
                if pos > n
                        pos = pos - n+1;
                end
        
        end
        toc