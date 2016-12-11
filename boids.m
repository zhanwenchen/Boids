%% Zhanwen "Phil" Chen
%% CS250
%% Final Project

%% Environment variables
sky_xlim = 100;
sky_ylim = 100;

%% Bird variables
max_speed = 20; %m/s

%% Init birds
numBirds = 20;
birds = rand(numBirds, 4); % bird has [x,y,v_x,v_y],
birds = birds .* [rand*sky_xlim,rand*sky_ylim,rand*max_speed,1];

% Tranform birds to cell array for speed
birds = mat2cell(birds,ones(1,numBirds), 4); % 4 is arity of bird

dBirds = 

numIterations = 200; %s

for i=2:numIterations

end
