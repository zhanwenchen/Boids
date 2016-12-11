%% Zhanwen "Phil" Chen
%% CS250
%% Final Project

%% Bird vars
max_speed = 10; %m/s
numBirds = 2;
side_length = 10;

%% Randomization funcs
rand_sign = @(n) ones(n, 1) - floor(rand(n,1)*2)*2; % pick -1 or 1, n by 1
rand_speed = @(n) (rand(n,1) - 0.5) * 2 * max_speed; % [-max_speed, max_speed]

%% Environment vars
sky_xlim = 200;
sky_ylim = 200;

%% Init birds
birds = ones(numBirds, 4); % bird has [x,y,v_x,v_y],
birds(:,1) = birds(:,1) .* (rand(numBirds,1) * sky_xlim);
birds(:,2) = birds(:,2) .* (rand(numBirds,1) * sky_ylim);
birds(:,3) = rand_sign(numBirds) .* rand_speed(numBirds);
birds(:,4) = rand_sign(numBirds) .* rand_speed(numBirds);

% birdList = mat2cell(birds,ones(numBirds,1),4); % same thing as birds
birdsList{1} = birds; % birds by frame

numIterations = 200; %s

for i=2:numIterations
  %% Collision
  birds = birds + dBirds(birds,side_length,max_speed);
  birdsList{i} = birds;
end

viz(birdsList,1,side_length)
