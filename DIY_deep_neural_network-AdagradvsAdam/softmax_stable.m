function f = softmax_stable(x)
        z = x - max(x);
        numerator = exp(z);
        denominator = sum(numerator);
        f = numerator/denominator;