% Trains a weight matrix using pseudo-inverse
function W_new = pseudoinv( W_old, P, T )
    P_plus = (P' * P) \ P';
    W_new = W_old + T*P_plus;
    
end