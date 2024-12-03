%初始化
num_error_bits1 = 0;
num_error_bits2 = 0;

% 逐像素比较原始水印图像和提取水印图像
for i = 1:64
    for j = 1:64
        if J(i, j) ~= W_out(i, j)
            num_error_bits1 = num_error_bits1 + 1;
        end
    end
end

% 逐像素比较原始水印图像和 HNN 提取水印图像
for i = 1:64
    for j = 1:64
        if J(i, j) ~= Final(i, j)
            num_error_bits2 = num_error_bits2 + 1;
        end
    end
end

% 计算总像素数
total_bits = 64 * 64;

% 计算误码率 (BER)
BER1 = num_error_bits1 / total_bits;
BER2 = num_error_bits2 / total_bits;