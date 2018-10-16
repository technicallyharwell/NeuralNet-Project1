% Changes n random pixels in a_in
function a_out = pixcorrupt( a_in, n )

    a_out = a_in;
    
    for i = 1:n
        % rand() is in [0,1] and scaled by the length of a_in
        % NOTE: a_in-1 and the trailing +1 needed to prevent value of 0
        rand_idx = floor(rand(1) * (length(a_in)-1)) + 1; 
        % negate the pixel that is randomly indexed
        a_out(rand_idx) = -1 * a_out(rand_idx);
    end
    
end

