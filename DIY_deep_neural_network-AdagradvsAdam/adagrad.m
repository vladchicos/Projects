M = readtable('avila/avila-tr.txt');
x = table2array(M(:,1:10));
tags = string(table2array(M(:,11)));
n = 10430; %nr de date
it = 1;
eta = 0.5;
%ponderi w
w_hid1 = rand(10,64)-0.5;
w_out = rand(64,12)-0.5;
pos =1;
G_hid1 = zeros(64);
G_out = zeros(12);
xi = repmat(1e-2,12,1);
tic
while(it < 50*n) %nr de epoci
        %forward propagation
        layer1 = sigmoid(x(pos,:)*w_hid1);
        output = softmax_stable(layer1*w_out);
        %label encodat
        ENC = getENC(tags(pos));

        %backward propagation 
        err = (output-ENC);
        grad = layer1'*(output-ENC);
        err1 = w_out*err'.*((layer1.*(1-layer1))');
        grad_h1 = x(pos,:)'*err1';

        %output_layer
        G_out = G_out + grad'*grad;
        beta_t = sqrt(diag(G_out));
        beta_t = beta_t + xi;
        w_out = w_out - (eta./beta_t)'.*grad;
        %hidden layer 1
        G_hid1 = G_hid1 + grad_h1'*grad_h1;
        beta_t = sqrt(diag(G_hid1));
        beta_t = beta_t + repmat(1e2,size(diag(G_hid1)));
        w_hid1 = w_hid1 - (eta./beta_t)'.*grad_h1;


        it = it + 1;
        pos = pos+200; %antrenam pe un singur x(i)
        if pos > n
                pos = pos - n +1;
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