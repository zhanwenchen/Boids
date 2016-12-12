%% InitBirds returns birds at frame 1
function [birds] = initBirds(numBirds,side_length,max_speed,sky_xlim,sky_ylim)

  %% Randomization funcs
  rand_sign = @(n) ones(n, 1) - floor(rand(n,1)*2)*2; % pick -1 or 1, n by 1
  rand_speed = @(n) (rand(n,1) - 0.5) * 2 * max_speed; % [-max_speed, max_speed]

  birds(:,1) = rand(numBirds,1) * (sky_xlim-side_length) + 0.5*side_length;
  birds(:,2) = rand(numBirds,1) * (sky_xlim-side_length) + 0.5*side_length;
  birds(:,3) = rand_sign(numBirds) .* rand_speed(numBirds);
  birds(:,4) = rand_sign(numBirds) .* rand_speed(numBirds);

end
