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
birds(:,1) = birds(:,1) .* (rand(numBirds,1) * sky_xlim);
birds(:,2) = birds(:,2) .* (rand(numBirds,1) * sky_ylim);
birds(:,3) = birds(:,3) .* (rand(numBirds,1) * max_speed);
birds(:,4) = sqrt(max_speed^2 - birds(:,3).^2);

birdsList{1} = birds;
% dBirds =
% dvx = @();
% dvy = @();
dx = @(x,y,v_x,v_y) rand*max_speed;
dy = @(x,y,v_x,v_y) sqrt(rand*max_speed^2-dx^2);
dBirds = @(x,y,v_x,v_y) [arrayfun(dx(x);dx(x,y,v_x,v_y);0;0];

numIterations = 200; %s

for i=2:numIterations
  %% Collision
  % for all other birds
  % if
  birdsList{i} = birdsList{i-1}...
                + dBirds(birds(:,1),birds(:,2),birds(:,3),birds(:,4));
end
