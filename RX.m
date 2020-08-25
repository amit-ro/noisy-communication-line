function r_bits = RX(config, channel_out)
    % demodulate the signal
    n = linspace(0, length(channel_out)-1, length(channel_out));
    mod_down = cos(2*pi*n*config.Fc/config.Fs);
    unmoded_sig = channel_out(:).*mod_down(:);
    
    % applying LPF
    filtered_sig = conv(unmoded_sig, config.RxLPFpulse);
    
    % delay sync and gain aproximation
    rev_sync_sig = config.synchsymbol(end:-1:1);
    E_sync = sum(config.synchsymbol.^2);
    rev_nyq = config.tpulsesinc(end:-1:1);
    sig_start_filter = conv(rev_sync_sig, filtered_sig);
    [max_val,sig_start_index] = max(abs(sig_start_filter(1:4*config.Fs)));
    if sig_start_filter(sig_start_index) < 0
        max_val = max_val*-1;
    end
    gain = max_val/E_sync;
    
    % decode the signal using the nyquist pulse
    matched_filter_out = conv(rev_nyq, filtered_sig/gain);

    % sample the signal in Fs/B intervals
    for i = 1:config.K
        if i == 1
            r_BPSK(i) = matched_filter_out(sig_start_index+i);
        else
            r_BPSK(i) = matched_filter_out(sig_start_index+(i-1)*config.Ts);
        end
    end
    r_bits(r_BPSK > 0) = 0;
    r_bits(r_BPSK < 0) = 1;
end