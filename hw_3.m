function hw_3(file)
% Allison Crim, HW 3
% hw_3(file) performs histogram equalization as defined in lecture 4
% of audio signal processing taught by Prof. Nassar Nasrabadi

I = imread(file);

N = size(I,1);
M = size(I,2);
grey_levels = 2^8;

r = zeros(grey_levels,1);
n = zeros(grey_levels,1);
pr = zeros(grey_levels,1);

for i=1:N
    for j=1:M
        %need to figure out how often each pixel level shows up
        r = I(i,j);
        n(r+1) = n(r+1)+1;
        %calculate the probability of each n
        pr(r+1) = n(r+1)/M*N;
    end
end 

s = 0;
L = grey_levels-1;
sum_final = zeros(grey_levels,1);

for j = 1:grey_levels
    %sum the prevalence of the each pixel level
    s = s + n(j);
    sum_final(j) = s;
    %calculate the cdf for each pixel level
    sum_final(j) = round(sum_final(j)*L/(M*N));
end

output = uint8(zeros(N,M));
for i=1:N
    for j=1:M
        %map each pixel to the cdf calculated above
        output(i,j) = sum_final(I(i,j)+1);
    end
end

figure;
subplot(2,2,1);
imhist(I);
title('Histogram of Unprocessed Image');

subplot(2,2,2);
imshow(I);
title('Original Image');

subplot(2,2,3);
imhist(output);
title('Equalized Histogram');

subplot(2,2,4);
imshow(output);
title('Image with Equalized Histogram');

% subplot(3,2,5);
% stem(pr);
% title('PDF');
% 
% subplot(3,2,6);
% stem(sum_final);
% title('CDF');

%to run do hw_3('Low_con.tif');







    
    
    

