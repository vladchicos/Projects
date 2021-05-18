M = csvread('wifi_localization.txt');
tic
n = 2000; %nr de date
classes = 4;
epoch = n;
it = 1;
eta = 0.5;
x = M(:,1:7);
%ponderi w
w = repmat([0.1 0.1 0.1 0.1],7,1);
pos =1;
G = zeros(4);
xi = repmat(1e-2,4,1);
while(it < 11*epoch) %nr optim de epoci
        %label encodat
        ENC = getENC(pos);
        %gradientul pt fctia softmax evaluat in x(i,:)
        grad = x(pos,:)'*(softmax(x(pos,:)*w)-ENC);
        G = G + grad'*grad;
        beta_t = sqrt(diag(G));
        beta_t = beta_t + xi;
        w = w - (eta./beta_t)'.*grad;

        it = it + 1;
        pos = pos+100; %antrenam pe un singur x(i)
        if pos > n
                pos = pos - n +1;
        end
end

%Testez acuratetea
corect = 0;
gresit = 0;
for i=1:n
        [argval, argmax_f] = max(softmax(x(i,:)*w));
        ENC = getENC(i);
        [argval, argmax_s] = max(ENC);
        if(argmax_f == argmax_s)
                corect = corect + 1;
        else
                gresit = gresit + 1;
        end
end
toc
procent_clasificare_corecta = corect*100/n

function ENC = getENC(pos)
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
end