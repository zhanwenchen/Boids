%% Zhanwen "Phil" Chen
%% CS250
%% Final Project

numBirds = 20;

%% Bird vars
max_speed = 20; %m/s

%% Randomization funcs
rand_sign = @(n) ones(n, 1) - floor(rand(n,1)*2)*2; % pick -1 or 1, n by 1
rand_speed = @(n) (rand(n,1) - 0.5) * 2 * max_speed; % [-max_speed, max_speed]



%% Environment vars
sky_xlim = 200;
sky_ylim = 200;

% dx = @(birds) (rand(numBirds,1).*2 - 1) .* max_speed; % dx in [-max_speed, max_speed]
% % dy = @(birds) rand_sign(:,2) .* sqrt(max_speed^2 - birds(:,3).^2); % pos or neg
dy = @(birds) rand_sign(:,2) .* sqrt(abs(max_speed^2 - birds(:,3).^2)); % pos or neg
% % dBird = [dx, dy, dv_x, dv_y]
% dBird = @(bird) [dx(bird) dy(bird) ones(numBirds,1) ones(numBirds,1)];

%% Init birds
birds = ones(numBirds, 4); % bird has [x,y,v_x,v_y],
birds(:,1) = birds(:,1) .* (rand(numBirds,1) * sky_xlim);
birds(:,2) = birds(:,2) .* (rand(numBirds,1) * sky_ylim);
birds(:,3) = rand_sign(numBirds) .* rand_speed(numBirds);
birds(:,4) = rand_sign(numBirds) .* rand_speed(numBirds);


birdList = mat2cell(birds,ones(numBirds,1),4); % same thing as birds
birdsList{1} = birds; % birds by frame

numIterations = 200; %s

for i=2:numIterations
  %% Collision
  % for all other birds
  % if
  % birdsList{i} = birdsList{i-1}...
  %               + dBirds(birds(:,1),birds(:,2),birds(:,3),birds(:,4));
  % birds = birds + dBirds();
  birds = birds + dBirds(birds);
  birdsList{i} = birds;

end
