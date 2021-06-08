%returns the one-hot encoding for classes
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