function ChannelOutVec = ChannelTXRX(config, ChannelInVec)
    noise = randn(length(ChannelInVec), 1).*10^(-config.snrdB/20);
    ChannelOutVec = ChannelInVec + noise(:)';
end