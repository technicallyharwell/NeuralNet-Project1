% Apply an input P to the network, defined by weight matrix W
function a = neuron( W, P )
    a = hardlims(W*P);
end

