% one percent sign makes a comment

% comment

% another comment

%% two percent signs make a section


% Clear all stored variables and command window (makes code reproducible)

clear;
clc;




%% Define some variables
x = 0;
y = 100;
N = 20;




%% Array structure
my_array = linspace(x,y,N); % vector of 20 evenly spaced points between var1 and var2 (inclusive)
disp(my_array);


disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');



another_array = [1, 2, 3, 4, 5]; % or manually create an array
disp(another_array);


disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');

manual_matrix = [1,2,3; 4,5,6; 7,8,9];
disp(manual_matrix);

disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');




%% If loop structure

% in English: IF x equals 0 AND y is not equal to 10, OR the length of
% my_array is equal to N, THEN do [whatever is in the next line]

% Will message A, B, or C (or some combination of those) be printed?

if (x == 0) && (y ~= 10)
    disp('Message A');
elseif x == 1
    disp('Message B');
elseif x == 4
    disp('this');
else
    disp('Message C');
end




%% While loop structure
x = 1; y = 4;
while x < y
    disp('How many times will this message print?');
    x = x + 1;
end

x = 8; y = 6;
while 1
    disp('How about this one?');
    if x <= y
        break
    end
    x = x - 1;
end




%% For loop structure, manipulating array entries
for k = 1 : 5
    another_array(k) = another_array(k) + 3;
    % Notice that indexing begins at 1, not 0
end



%% Exercise
% What will the following block of code output?
for v = 11:15
    w = 2;
    p = true;
    while w < sqrt(v)
        if mod(v, w) == 0
            p = false;
        end
        w = w + 1; 
    end
    if p
        disp(':)')
    else
        disp(':,(')
    end
end



%% Matrix operations

mat1 = ones(3,3); % creates a matrix of 1s with dimension (m rows, n columns)
mat1(1,3) = 4; % change the value of the entry at index (1,3)
disp('Original matrix:');
disp(mat1);

%%

% will these print the same thing?
disp('Matrix squared:');
disp(mat1^2);
disp('Matrix squared, pointwise:');
disp(mat1.^2);

%%


% another useful operation
zero_mat = zeros(3,9); % make a matrix of zeros
disp(zero_mat);

zero_mat(:,1) = 2; % set the first column to be all 2s
disp(zero_mat);




%% Plotting (multiple plots, pointwise array operations, plot formatting)
figure;

subplot(1,2,1);
plot(my_array, my_array.^2); % the 2 arrays to be plotted must be the same length
title('An element-wise squared array versus itself');
xlabel('the array elements');
ylabel('the array elements squared');

subplot(1,2,2);
plot(another_array, another_array.^2);
title('Another element-wise squared array versus itself');
xlabel('the array elements');
ylabel('the array elements squared');

% see MathWorks documentation for various customizations on formatting



%% Functions

% Functions can be defined within scripts. In older versions of MATLAB,
% functions must be implemented at the bottom of the script.

function p = is_prime(num)
%        ^      ^      ^  
%     output   name   input
w = 2;
p = true;
while w < sqrt(num)
    if mod(num, w) == 0
        p = false;
    end
    w = w + 1; 
end

end

disp(is_prime(55))
disp(is_prime(57))
disp(is_prime(59))
disp(is_prime(61))

disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');

% If you have a useful function that you might want you use in different
% scripts, you can define it in a separate file. Refer to is_fib.m for an
% example.

disp(is_fib(4))
disp(is_fib(5))
disp(is_fib(8))
disp(is_fib(19))


%% Exercise
% The "Babylonian method" for finding square roots is one of the oldest
% numerical methods ever designed. (You can read more about it here: 
% https://www.cs.utep.edu/vladik/2009/olg09-05a.pdf) Write a function
% called bab that implements this method. It should take in as input: 
% 
%   a - the number whose square root we are trying to compute
%   x_init - the initial guess
%   num_iter - number of iterations
% 
% It should output the estimated square root of a.
% 
% Bonus: As a user, we might not care what x_init and num_iter are. We
% would want the function to have default values for these. Look at
% https://www.mathworks.com/help/matlab/matlab_prog/support-variable-number-of-inputs.html
% to see how we can change bab to accept one, or two, or three inputs, 
% with default values for x_init and num_iter if they aren't specified.

format long
disp(bab(2, 1, 30))
disp(bab(2, 3.14, 20))
disp(sqrt(2))
disp(bab2(2))
disp(bab2(2, 0.1))
disp(bab2(2, 0.01, 14))


