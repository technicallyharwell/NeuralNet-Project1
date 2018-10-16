% Converts a Rx1 input into a 6x5 grayscale image:
function img = get_img( P )

    % Initialize iterators and blank canvas
    img_rows = 6;
    img_cols = 5;
    img_mat = zeros([img_rows img_cols]);

    % Map values from input vector to image matrix
    % Note - outer loop controlled by cols due to structure of input vector
    for i = 1:img_cols
        for j = 1:img_rows
            index = (i - 1)*img_rows + j;
            img_mat(j, i) = P(index);
        end
    end
    % Finished mapping values; convert -1 values to 0 for clarity
    img = mat2gray(img_mat);
end

