% Close all the windows and clear variables

clc, clearvars, close all

% Load the cipher text
load('cipher_text_test')
alphabets_len = 26;
code_works = [];

% Get Alphabets
alphabets = char('A':'Z');
cipher_alphabets_array = uint8(alphabets); % Numerical Array
cw_array = {};
cw_count = 1;
% Generate Every possible Code Word option 
for i =1: alphabets_len
    for j = 1: alphabets_len
        code_works = [code_works;cipher_alphabets_array(i) cipher_alphabets_array(j)];
        cw_array{cw_count,1} = char([cipher_alphabets_array(i) cipher_alphabets_array(j)]);
        cw_count = cw_count + 1;
    end
end
pt_text = {};
for c = 1:alphabets_len*alphabets_len
    cw = cw_array{c,1};
    pt_text{c,1} = decipher_Caesar(cipher_text,cw_array{c,1});
end

% By inspecting the pt_text it is seen that at 639 position we have a
% readable text 

% True Plain text
true_plain_text = pt_text{639,1}

% true_codeword used
disp('True Code Word')
true_cw = cw_array{639,1}

wordLength = 1:10;
numCodeWords = 26.^wordLength;
% Plot the number of code words on a log scale
semilogy(wordLength, numCodeWords)

% Add labels and title to the plot
xlabel('Code Word Length')
ylabel('Number of Code Words')
title('Number of Possible Code Words')

% Add a grid to the plot
grid on
