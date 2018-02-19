H = 3;                                %number of heads
T = 6;                                %number of tails
nFlips = H + T;                       %overall number of flips
data = [zeros(T,1); ones(H,1)]; 
data = data(randperm(length(data)));  %some sequence of flips
counter = 1;
%iterate over possible theta values
for theta = 0:0.001:1
    likelihood(counter) = theta^H*(1-theta)^(nFlips-H); %Bernoulli likelihood function
    counter = counter + 1;
end

%plot the likelihood function
figure;
theta = 0:0.001:1;
plot(theta, likelihood,'b');
xlabel('\theta', 'fontsize', 15)
ylabel('P(D|\theta)');
title([num2str(nFlips) ' flips; ' num2str(H) ' heads']);