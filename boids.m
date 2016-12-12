%% Zhanwen "Phil" Chen
%% CS250
%% Final Project

%% Bird vars
max_speed = 10; %m/s
numBirds = 10;
side_length = 10;
leader_id = randi(numBirds,1);

%% Environment vars
sky_xlim = 200;
sky_ylim = 200;

%% Initialize birds
birds = initBirds(numBirds,side_length,max_speed,sky_xlim,sky_ylim);
birdsList{1} = birds; % birds by frame for visualization

numIterations = 200; %s

%% Simulation loop
for i=2:numIterations
  birds = birds + dBirds(birds,side_length,max_speed,sky_xlim,sky_ylim,leader_id);
  birdsList{i} = birds;
end

%% Visualization
viz(birdsList,1,side_length);
