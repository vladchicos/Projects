M = csvread('wifi_localization.txt');
tic
maxIter = 1000000;
n = 2000;
it = 1;
eta = 0.5;
x = M(:,1:7);
w = repmat([0.1 0.1 0.1 0.1],7,1);
pos =1;

%gradientul pt fctia softmax evaluat in x(i,:)
grad = x(pos,:)'*(softmax(x(pos,:)*w)-[1 0 0 0]);
G = grad'*grad;
beta_t = sqrt(diag(G));
xi = 0.001*zeros(4,1);;
beta_t = beta_t + xi;
ok = 0;

while(ok == 0 && it < maxIter) 
        w = w - (eta./beta_t)'.*grad;
        it = it + 1;
        pos = pos+100; %antrenam pe un singur x(i)
        if pos > 2000
                pos = pos - 2000 +1;
        end

        %label encodat
        if pos <= 500
                ENC = [1 0 0 0];
        elseif pos <= 1000
                ENC = [0 1 0 0];
        elseif pos <= 1500
                ENC = [0 0 1 0];
        else
                ENC = [0 0 0 1];
        end

        grad = x(pos,:)'*(softmax(x(pos,:)*w)-ENC);
        G = G + grad'*grad;
        beta_t = sqrt(diag(G));
        beta_t = beta_t + xi;
        w1 = softmax(x(22,:)*w);
        w2 = softmax(x(522,:)*w);
        w3 = softmax(x(1029,:)*w);
        w4 = softmax(x(1700,:)*w);
        if(w1(1,1) > 0.999 && w2(1,2) > 0.999 && w3(1,3) > 0.999 && w4(1,4) > 0.999)
                ok = 1;
        end
end

%Testez acuratetea
corect = 0;
gresit = 0;
for i=1:2000
        [argval, argmax_f] = max(softmax(x(i,:)*w));
        if i <= 500
                ENC = [1 0 0 0];
        elseif i <= 1000
                ENC = [0 1 0 0];
        elseif i <= 1500
                ENC = [0 0 1 0];
        else
                ENC = [0 0 0 1];
        end
        [argval, argmax_s] = max(ENC);
        if(argmax_f == argmax_s)
                corect = corect + 1;
        else
                gresit = gresit + 1;
        end
end
toc
procent_clasificare_corecta = corect*100/2000