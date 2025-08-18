A = [2 0 1; 0 0 2; 5 2 0];
B = [0; 2; 5];
C = [0 2 5];
D = 0;

% Define state-space model
system = ss(A, B, C, D);

% Controllability matrix calculation
controllability_matrix = [B, A*B, A^2*B];
disp('Controllability matrix:');
disp(controllability_matrix);

controllability_rank = rank(controllability_matrix);
state_count = size(A, 1);
fprintf('Controllability matrix rank: %d\n', controllability_rank);
if controllability_rank == state_count
    disp('System is controllable');
else
    disp('System is not controllable');
end

% Observability matrix calculation
observability_matrix = [C; C*A; C*A^2];
disp('Observability matrix:');
disp(observability_matrix);

observability_rank = rank(observability_matrix);
fprintf('Observability matrix rank: %d\n', observability_rank);
if observability_rank == state_count
    disp('System is observable');
else
    disp('System is not observable');
end