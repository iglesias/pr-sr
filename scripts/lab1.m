%% Define and use a simple infinite-duration HMM

% Initial and transition probabilities
mc = MarkovChain([0.75; 0.25], [0.99 0.01; 0.03 0.97]);
S  = mc.rand(1e4);
fprintf('Frequency of occurrence of state 1 = %f\n', sum(S==1)/length(S));
fprintf('Frequency of occurrence of state 2 = %f\n', sum(S==2)/length(S));

%%
g1 = GaussD('Mean', 0, 'StDev', 1); % distribution for state 1
g2 = GaussD('Mean', 0, 'StDev', 2); % distribution for state 2
h  = HMM(mc, [g1; g2]); % the HMM
x  = h.rand(500); % generate a random output sequence
fprintf('Mean value of the observations = %f\n', mean(x));
fprintf('Variance of the observations = %f\n', var(x));
plot(x(1:500));
xlabel('observation indices')
ylabel('x')
title('500 contiguous observation values of an infinite HMM with 2 states')

%% Define and use a finite-duration HMM
mc = MarkovChain([0.75; 0.25], [0.98 0.01 0.01; 0.02 0.97 0.01]);
counter = 0;
N = 10;
for i = 1:N
  S  = mc.rand(1e4);
  counter = counter + length(S);
end

fprintf('Average length of the state sequence generated= %f\n', ...
          counter/N);