J=imread('logo.png');
J=imresize(J(:,:,1),[64,64]);%对J选择通道1(假设为RGB)，并缩放为64*64

if ~isfloat(W_out)
    W_out = im2double(W_out); % 转换为 [0, 1] 范围的浮点数
end
if ~isfloat(Final)
    Final = im2double(Final); % 转换为 [0, 1] 范围的浮点数
end

% 归一化 Final 到 [0, 1] 范围
Final_min = min(Final(:));
Final_max = max(Final(:));
Final_norm = (Final - Final_min) / (Final_max - Final_min);

% J = logical(J);
random_gray_values = 1 + (255 - 1) * rand(64);
% 加入一定的随机性，生成连续的灰度值

W_gray = W_out.* random_gray_values;
F_gray = Final_norm.* (50 + rand(64) * 150);

W_gray=uint8(W_gray);
F_gray=uint8(F_gray);

% 计算均值
mean_J = mean(J(:));
mean_W = mean(W_gray(:));
mean_F = mean(F_gray(:));

% 计算协方差
cov_JW = sum((J(:) - mean_J) .* (W_gray(:) - mean_W)) / (64 * 64);
cov_JF = sum((J(:) - mean_J) .* (F_gray(:) - mean_F)) / (64 * 64);

% 计算标准差
std_J = sqrt(sum((J(:) - mean_J).^2) / (64 * 64));
std_W = sqrt(sum((W_gray(:) - mean_W).^2) / (64 * 64));
std_F = sqrt(sum((F_gray(:) - mean_F).^2) / (64 * 64));

% 计算 PCC
PCC1 = cov_JW / (std_J * std_W);
PCC2 = cov_JF / (std_J * std_F);