% `hardlims` is -1 below zero, 1 at and after zero
function y = hardlims( x )
    y = (x >= 0) - (x < 0);
end

