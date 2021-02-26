digit_data = zeros(2400,785);
filenames = "";
for i=1:2400
        filenames(i) = "Train/"+string(i)+".jpg";
        %digit_data(i,:) = [reshape(im2double(imread(char(filenames(i)))),[1,784]) 1];
        tmp = im2double(imread(char(filenames(i))));
        vect = tmp(:);
        digit_data(i,:) = [vect' 1];
end
ell = 784; %dimensiunea vectorilor de clasificat
%formeaza si rezolva problema CMMP
ponderi = zeros(10,785);
for i=0:9
        b = getB(i);
        %ponderi(i+1,:) = CMMP(digit_data,b);
        ponderi(i+1,:) = digit_data\b;
end
generez_matrice_confuzie(ponderi)
function [b] = getB(n)
        b = ones(2400,1);
        b = b*-1;
        for i=240*n+1:240*(n+1)
                b(i) = b(i) * (-1);
        end
end

function generez_matrice_confuzie(ponderi)
        matrice_confuzie = zeros(10);
        nr_poze_test = 200;
        test_data = generez_set_test(nr_poze_test);
        for i=1:nr_poze_test
                max_val = -1;
                max_index = 0;
                for j=0:9
                        if( test_data(i,:)*ponderi(j+1,1:784)' + ponderi(j+1,785) > max_val)
                                max_val = test_data(i,:)*ponderi(j+1,1:784)' + ponderi(j+1,785);
                                max_index = j;
                        end
                end
                matrice_confuzie(floor((i-1)/20)+1,max_index+1) = matrice_confuzie(floor((i-1)/20)+1,max_index+1) + 1;
        end
        matrice_confuzie
end
        


function [test_data] = generez_set_test(nr_poze)
        filenames = "";
        for i=1:nr_poze
                filenames(i) = "Test/"+string(i)+".jpg";
                test_data(i,:) = reshape(im2double(imread(char(filenames(i)))),[784,1])';
        end
end



%function generez_matrice_confuzie(ponderi);