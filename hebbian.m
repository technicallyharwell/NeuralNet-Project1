% Trains a weight matrix using Hebbian
function W_new = hebbian( W_old, P, T )
       
    W_new = W_old + T*P';
        
end
