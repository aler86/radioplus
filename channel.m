% Shashank Gaur
% initialize 
    clear
    clc


% parameter definition
    N  = 256;           % total number of subchannels
    P  = 256/8;         % total number of Pilots
    S  = N-P;           % total number of data subchannels
    GI = N/4;           % guard interval length
    M  = 2;             % modulation
    p_i = 8;            % pilot position interval
    L  = 16;            % channel length
    nIteration = 500;    % number of iteration in each evaluation

    Vector_SNR = [0:3:27];   % signal to noise ratio vector in dB
    ber = zeros(1,length(Vector_SNR));   % initializing bit error rate

% Pilot Location and strength
    Ip = [1:p_i:N];       % location of pilots
    Is = setxor(1:N,Ip);            % location of data
    
    Ep = 2;                        % energy in pilot symbols in comparison 
                                    % to energy in data symbols

% fft matrix
    F = exp(2*pi*sqrt(-1)/N .* meshgrid([0:N-1],[0:N-1])...
        .* repmat([0:N-1]',[1,N]));


for( i = 1 : length(Vector_SNR))
    SNR = Vector_SNR(i)
    for(k = 1 : nIteration)BER function in matlab
        % generating random channel coefficients
            h(1:L,1)  =     random('Normal',0,1,L,1) + ...
                        j * random('Normal',0,1,L,1);  
            h  = h./sum(abs(h));    % normalization    
        
        % Tr Data
            TrDataBit = randint(N,1,M);
            TrDataMod = qammod(TrDataBit,M);
            TrDataMod(Ip) = Ep * TrDataMod(Ip);
            TrDataIfft = ifft(TrDataMod,N);
            TrDataIfftGi = [TrDataIfft(N- GI + 1 : N);TrDataIfft];

        % tx Data    
            TxDataIfftGi = filter(h,1,TrDataIfftGi);    % channel effect
            % adding awgn noise
            TxDataIfftGiNoise = awgn(TxDataIfftGi ...
                , SNR - db(std(TxDataIfftGi))); % normalization to signal power

            TxDataIfft  = TxDataIfftGiNoise(GI+1:N+GI);
            TxDataMod   = fft(TxDataIfft,N);

            % Channel estimation
            Spilot = TrDataMod(Ip); % trnasmitted pilots
            Ypilot = TxDataMod(Ip); % received pilots

            G = (Ep * length(Ip))^-1 ...
                * ctranspose(sqrt(Ep)*diag(Spilot)*ctranspose(F(1:L,Ip)));

            hHat = G*Ypilot;    % estimated channel coefficient in time domain

            TxDataBit   = qamdemod(TxDataMod./(fft(hHat,N)),M);

        % bit error rate computation
            [nErr bErr(i,k)] = symerr(TxDataBit(Is),TrDataBit(Is));
    end
end

f1 = figure(1);
    set(f1,'color',[1 1 1]);
    semilogy(Vector_SNR,mean(bErr'),'b->')
    xlabel('SNR in dB');
    ylabel('Bit Error Rate')
