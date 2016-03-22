start_idx = find_start_point_cox_schmidl(y, 20);

y_frame = y(start_idx:end);

avg_freq_error = 0;
for k = 1:64
    avg_freq_error = avg_freq_error + angle(y_frame(k+64)/y_frame(k))/64;
end

avg_freq_error = avg_freq_error/64

y_corrected = y_frame.*(exp(-1i*avg_freq_error*[1:length(y_frame)]'));

