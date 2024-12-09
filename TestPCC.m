J=imread('logo.png');
J=imresize(J(:,:,1),[64,64]);%Select channel 1(let's say RGB) for J and scale it to 64*64

if ~isfloat(W_out)
    W_out = im2double(W_out); 
end
if ~isfloat(Final)
    Final = im2double(Final); 
end

% Normalized format 
Final_min = min(Final(:));
Final_max = max(Final(:));
Final_norm = (Final - Final_min) / (Final_max - Final_min);

random_gray_values = 1 + (255 - 1) * rand(64);

W_gray = W_out.* random_gray_values;
F_gray = Final_norm.* (50 + rand(64) * 150);

W_gray=uint8(W_gray);
F_gray=uint8(F_gray);

% Calculated mean
mean_J = mean(J(:));
mean_W = mean(W_gray(:));
mean_F = mean(F_gray(:));
% Calculated covariance
cov_JW = sum((J(:) - mean_J) .* (W_gray(:) - mean_W)) / (64 * 64);
cov_JF = sum((J(:) - mean_J) .* (F_gray(:) - mean_F)) / (64 * 64);
% Calculated standard deviation
std_J = sqrt(sum((J(:) - mean_J).^2) / (64 * 64));
std_W = sqrt(sum((W_gray(:) - mean_W).^2) / (64 * 64));
std_F = sqrt(sum((F_gray(:) - mean_F).^2) / (64 * 64));

% Computing PCC
PCC1 = cov_JW / (std_J * std_W);
PCC2 = cov_JF / (std_J * std_F);