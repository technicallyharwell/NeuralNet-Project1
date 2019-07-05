function hd = hamming( a, t )
    h = a + t;
    hd = 0;
    for i = 1:length(h)
        if isequal(0,h(i))
            hd = hd + 1;
        end
    end

end

