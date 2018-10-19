% Group F, EE 4745, Program 1
% Robert Harwell
% Samuel Smothers
%
% Files explanation:
%   hebbian.m     - Creates a weight matrix using hebbian learning
%   pseudoinv.m   - Creates a weight matrix using pseudo-inverse
%   neuron.m      - Uses a weight matrix to get an output
%   hardlims.m    - Forces neuron output to -1 or 1
%   get_img.m     - Converts an Nx1 vector to an IxJ grayscale image
%   pixcorrupt.m  - Corrupts n-random pixels in an input vector

clear

% The following are constants which represent inputs
%   First a matrix representation, for easy human viewing..
%   ..second is the Mx1 vector containing each column of the matrix..
%   ..last is the Tx1 target output vector for the associated input

% Digit `0`
M_0 = ...
    [  1 -1 -1 -1 -1  1  ;
      -1  1  1  1  1 -1  ;
      -1  1  1  1  1 -1  ;
      -1  1  1  1  1 -1  ;
      -1  1  1  1  1 -1  ;
       1 -1 -1 -1 -1  1] ;   
% convert RxC matrix to (R*C)x1 vector
P_0 = M_0(:);
% 0000
T_0 = [-1;
       -1;
       -1;
       -1]; 
   
% Digit `1`
M_1 = ...
    [  1  1 -1 -1  1  1  ;
       1  1  1 -1  1  1  ;
       1  1  1 -1  1  1  ;
       1  1  1 -1  1  1  ;
       1  1  1 -1  1  1  ;
       1 -1 -1 -1 -1  1  ];
P_1 = M_1(:);
% 0001
T_1 = [-1;
       -1;
       -1;
       1];

% Digit `2`
M_2 = ...
    [  1 -1 -1 -1  1  1  ;
       1  1  1  1 -1  1  ;
       1  1  1  1 -1  1  ;
       1  1 -1 -1  1  1  ;
       1 -1 -1  1  1  1  ;
       1 -1 -1 -1 -1 -1  ];
P_2 = M_2(:);
% 0010
T_2 = [-1;
       -1;
        1;
       -1];
   
% Digit `3`
M_3 = ...
    [  1 -1 -1 -1 -1  1  ;
       1  1  1  1  1 -1  ;
       1  1  1  1  1 -1  ;
       1  1  1 -1 -1 -1  ;
       1  1  1  1  1 -1  ;
       1 -1 -1 -1 -1  1  ];   
P_3 = M_3(:);
% 0011
T_3 = [-1;
       -1;
       1;
       1];
   
% Digit `4`
M_4 = ...
    [ -1  1  1  1 -1  1  ;
      -1  1  1  1 -1  1  ;
      -1  1  1  1 -1  1  ;
      -1 -1 -1 -1 -1  1  ;
       1  1  1  1 -1  1  ;
       1  1  1  1 -1  1  ];
P_4 = M_4(:);
% 0100
T_4 = [-1;
        1;
       -1;
       -1];  
   
% Digit `5`
M_5 = ...
    [  1 -1 -1 -1 -1  1  ;
       1 -1  1  1  1  1  ;
       1 -1 -1 -1  1  1  ;
       1  1  1  1 -1  1  ;
       1  1  1  1 -1  1  ;
       1 -1 -1 -1  1  1 ];
P_5 = M_5(:);
% 0101
T_5 = [-1;
        1;
       -1;
       1]; 

% Digit `6`
M_6 = ...
    [ 1  -1 -1 -1 -1  1  ;
      1  -1  1  1  1  1  ;
      1  -1  1  1  1  1  ;
      1  -1 -1 -1 -1  1  ;
      1  -1  1  1 -1  1  ;
      1  -1 -1 -1 -1  1 ];
P_6 = M_6(:);
% 0110
T_6 = [-1;
        1;
       1;
       -1];
   
% Digit '7'
M_7 = ...
    [-1  -1 -1 -1  1  1  ;
      1   1  1 -1  1  1  ;
      1   1 -1 -1 -1  1  ;
      1   1  1 -1  1  1  ;
      1   1  1 -1  1  1  ;
      1   1  1 -1  1  1 ];
P_7 = M_7(:);
%0111
T_7 = [-1;
        1;
        1;
        1 ];
    
% Digit '8'
M_8 = ...
    [ 1  -1 -1 -1 -1  1  ;
      1  -1  1  1 -1  1  ;
      1  -1 -1 -1 -1  1  ;
      1  -1 -1 -1 -1  1  ;
      1  -1  1  1 -1  1  ;
      1  -1 -1 -1 -1  1 ];    
P_8 = M_8(:);
%1000
T_8 = [ 1;
       -1;
       -1;
       -1 ];
   
% Digit '9'
M_9 = ...
    [ -1 -1 -1 -1 -1  1  ;
      -1  1  1  1 -1  1  ;
      -1  1  1  1 -1  1  ;
      -1 -1 -1 -1 -1  1  ;
       1  1  1  1 -1  1  ;
       1  1  1  1 -1  1 ];    
P_9 = M_9(:);
%1001
T_9 = [ 1;
       -1;
       -1;
        1 ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Letter `R`
% M_R = ...
%     [ -1 -1 -1 -1  1  ;
%       -1  1  1  1 -1  ;
%       -1 -1 -1 -1  1  ;
%       -1  1 -1  1  1  ;
%       -1  1  1 -1  1  ;
%       -1  1  1  1 -1  ];
% P_R = M_R(:);
% %
%    
% % Letter `H`
% M_H = ...
%     [ -1  1  1  1 -1  ;
%       -1  1  1  1 -1  ;
%       -1 -1 -1 -1 -1  ;
%       -1  1  1  1 -1  ;
%       -1  1  1  1 -1  ;
%       -1  1  1  1 -1  ];
% P_H = M_H(:);
% %



% To check how those look, uncomment any of these lines:
% figure, imshow(get_img(P_1, M_0), 'InitialMagnification', 'fit')
% figure, imshow(get_img(P_2, M_0), 'InitialMagnification', 'fit')
% figure, imshow(get_img(P_3, M_0), 'InitialMagnification', 'fit')
% figure, imshow(get_img(P_4, M_0), 'InitialMagnification', 'fit')
 figure, imshow(get_img(P_5, M_0), 'InitialMagnification', 'fit')
% figure, imshow(get_img(P_6, M_0), 'InitialMagnification', 'fit')
% figure, imshow(get_img(P_7, M_0), 'InitialMagnification', 'fit')
% figure, imshow(get_img(P_8, M_0), 'InitialMagnification', 'fit')
% figure, imshow(get_img(P_9, M_0), 'InitialMagnification', 'fit')


% digits{} is a cell array which indexes the vector of each digit
digits{1} = P_0;
digits{2} = P_1;
digits{3} = P_2;
digits{4} = P_3;
digits{5} = P_4;
digits{6} = P_5;
digits{7} = P_6;
digits{8} = P_7;
digits{9} = P_8;
digits{10} = P_9;

% cell array for indexing digit target outputs
t_digits{1} = T_0;
t_digits{2} = T_1;
t_digits{3} = T_2;
t_digits{4} = T_3;
t_digits{5} = T_4;
t_digits{6} = T_5;
t_digits{7} = T_6;
t_digits{8} = T_7;
t_digits{9} = T_8;
t_digits{10} = T_9;

% cell array for letter vectors
% letters{1} = P_R;
% letters{2} = P_H;


num_inputs = length(P_0);
num_outputs = length(T_0);

W_init = zeros([num_outputs num_inputs]);

% Generate all needed W matrices
% Wh{} indexes Hebb weights
% Wi{} indexes psuedoinv weights

P(:,1) = digits{1};
T(:,1) = t_digits{1};
% W for parts (i) and (ii):
for i = 2:length(digits)
    % concat next col to P and T
    P(:,i) = digits{i};
    T(:,i) = t_digits{i};
    
    Wh{i-1} = hebbian(W_init, P, T); %#ok<SAGROW>
    Wi{i-1} = pseudoinv(W_init, P, T); %#ok<SAGROW>
end

% Intoduce noise to pixels and test output of NN

% for each weight matrix..
for i = 1:length(Wh)
    %..perform separate tests for 2, 4, 6 noisy pixels..
    for n = 1:3
       % reset counters for calculating correctness
       num_tests = 0;
       hebb_correct = 0;
       pseudo_correct = 0;
       %..on each input that W is related to..
       for j = 1:(i+1)
           %..10 times each
           for k = 1:10
               % corrupt n*2 pixels 
               noisyP = pixcorrupt(P(:,j),(n*2));
               
               ah = neuron(Wh{i},noisyP);
               ai = neuron(Wi{i},noisyP);
               
               if isequal(ah,T(:,j))
                   hebb_correct = hebb_correct + 1;
               end
               if isequal(ai,T(:,j))
                   pseudo_correct = pseudo_correct + 1;
               end
               
               num_tests = num_tests + 1;    
           end
       end
       % find percent of correct outputs for n-noisy pixels
       hebb_error = 1 - (hebb_correct/num_tests);
       pseudo_error = 1 - (pseudo_correct/num_tests);
       results(i,(n*2-1)) = hebb_error;
       results(i,(n*2)) = pseudo_error;
    end 
end



% W for part (iii):



% Display the results (in a table with the given format):
fprintf('\nPart (i) and (ii) results:\n')
fprintf('W \t\t H(2)\tP(2)   H(4)   P(4)   H(6)   P(6)\n')
for i = 1:length(results)
    fprintf('0-%d  =>  ', i);
    for j = 1:6
        fprintf('%2.3f  ', results(i,j));
    end
    fprintf('\n');
end


