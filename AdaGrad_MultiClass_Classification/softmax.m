function f = softmax(x)
        f = exp(x)./sum(exp(x),2);