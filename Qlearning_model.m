%% CREATE REWARDS
bounds = [0 1]; % [mix max] probability to win a reaward 
nrtrials = 200;
sd = 0.025;
rewards = zeros(nrtrials,2);

x = [0.4, 0.6];
rewards(1,:) = x;
for t = 2:nrtrials
    for s = 1:2
        rewards(t,s) = rewards(t-1,s)+normrnd(0,sd);
        rewards(t,s) = min(rewards(t,s),max(bounds(2)*2 - rewards(t,s), bounds(1)));
        rewards(t,s) = max(rewards(t,s),min(bounds(1)*2 - rewards(t,s), bounds(2)));
    end
end

%% Q-LEARNING MODEL - choosing between right and left slot machines
% initialize parameters
alpha = 0.25;
beta  = 1;

Ql = 0;     % initial value function for choosing left
Qr = 0;     % initial value function for choosing right

% iterate over trials
for t = 1:nrtrials
    if rand < exp(beta*Qr)/(exp(beta*Qr) + exp(beta*Ql))    % decision rule to choose action 1 (Right) or 2 (Left)
        a = 1;
    else
        a = 2;
    end
    r = rand < rewards(t,a);
    if a == 1
        Qr = Qr + alpha*(r - Qr);                           % value update Right                           
    else
        Ql = Ql + alpha*(r - Ql);                           % value update Left
    end
    % keep track of rewards and actions
    action(t) = a;
    reward(t) = r;
end