function in_vec = TX(config, info_bits)
    % create BPSK
    for i = 1:length(info_bits)
        if (info_bits(i) == 0)
            BPSK(i) = 1;
        else
            BPSK(i) = -1;
        end
    end   
    % create pulse train
    pulse_train = upsample(BPSK, config.Ts);

    % encode the signal using nyquist pulse
    in_vec = conv(pulse_train, config.tpulsesinc);
    
    % zero padding
    Fs_zero = zeros(config.Fs, 1);
    Fs_zero_4 = zeros(config.Fs*4, 1);
    in_vec = [Fs_zero; in_vec(:); Fs_zero_4];
    
    % modulate the signal
    n = linspace(0, length(in_vec)-1, length(in_vec));
    mod_up = cos(2*pi*n*config.Fc/config.Fs);
    in_vec = in_vec(:).*mod_up(:);
    in_vec = in_vec(:)';
end