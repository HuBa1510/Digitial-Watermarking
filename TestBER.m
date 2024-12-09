%initialization
num_error_bits1 = 0;
num_error_bits2 = 0;

% A pixel-by-pixel comparison of the original watermark image and the extracted watermark image
for i = 1:64
    for j = 1:64
        if J(i, j) ~= W_out(i, j)
            num_error_bits1 = num_error_bits1 + 1;
        end
    end
end

% Pixel by pixel comparison of original watermark image and HNN extracted watermark image
for i = 1:64
    for j = 1:64
        if J(i, j) ~= Final(i, j)
            num_error_bits2 = num_error_bits2 + 1;
        end
    end
end

% Calculate the total number of pixels
total_bits = 64 * 64;

% Calculated bit error rate (BER)
BER1 = num_error_bits1 / total_bits;
BER2 = num_error_bits2 / total_bits;