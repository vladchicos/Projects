M = readtable('avila/avila-tr.txt');
x = table2array(M(:,1:10));
tags = string(table2array(M(:,11)));
maxIter = 100000;
n = 10430;
it = 1;
eta = 0.1;
epsilon = 1e-8;
pos = 1;
w_hid1 = rand(10,64)-0.5;
w_out = rand(64,12)-0.5;
step_size = 0.001;
%step_size = 0.1;
beta_1 = 0.9;
beta_2 = 0.999;
m = 0;
v = 0;
m1 = 0;
v1 = 0;
tic
while(it < 40*n)
        layer1 = sigmoid(x(pos,:)*w_hid1);
        output = softmax_stable(layer1*w_out);

        ENC = getENC(tags(pos));

        grad = layer1'*(output-ENC);
        err = (output-ENC);
        err1 = w_out*err'.*((layer1.*(1-layer1))');
        grad_h1 = x(pos,:)'*err1';



        m = beta_1*m + (1- beta_1)*grad;
        v = beta_2*v + (1 - beta_2)*grad.*grad;
        m_hat = m / (1 - power(beta_1, it));
        v_hat = v / (1 - power(beta_2, it));
        w_out = w_out - (step_size * m_hat) ./ (sqrt(v_hat) + epsilon);


        m1 = beta_1*m1 + (1- beta_1)*grad_h1;
        v1 = beta_2*v1 + (1 - beta_2)*grad_h1.*grad_h1;
        m_hat_1 = m1 / (1 - power(beta_1, it));
        v_hat_1 = v1 / (1 - power(beta_2, it));
        w_hid1 = w_hid1 - (step_size * m_hat_1) ./ (sqrt(v_hat_1) + epsilon);
        it = it + 1;
        pos = pos + 100;
        if pos > n
                pos = pos - n+1;
        end
      
end
toc
%Testez acuratetea
corect = 0;
gresit = 0;
for i=1:n
        ENC = getENC(tags(i));
        [argval, argmax_f] = max(softmax_stable(sigmoid(x(i,:)*w_hid1)*w_out));
        [argval, argmax_s] = max(ENC);
        if(argmax_f == argmax_s)
                corect = corect + 1;
        else
                gresit = gresit + 1;
        end
end
procent_clasificare_corecta = corect*100/n

function ENC = getENC(tag)
        enc_mat = eye(12);
        possible_tags = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "W", "X", "Y" ];
        %label encodat
        for i=1:12
                if tag == possible_tags(i)
                        ENC = enc_mat(i,:);
                        break;
                end
        end
end