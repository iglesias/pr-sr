%% Length of sequences from a finite-duration HMM

mc = MarkovChain( [0.75; 0.25], ...
                  [0.98 0.01 0.01; 0.02 0.97 0.01]);

counter = 0;
N = 10;
for i = 1:N
  S  = mc.rand(1e4);
  counter = counter + length(S);
end

fprintf([ 'Average length of the states sequence ' ...
          'generated= %f\n'], counter/N);
