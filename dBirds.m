%% dBirds takes the current frame birds object
function [d] = dBirds(birds)
  numBirds = size(birds,1);

  %% Environment vars
  sky_xlim = 200;
  sky_ylim = 200;

  %% Bird vars
  max_speed = 20; %m/s % don't care if 20^2 + 20^2 = 20*sqrt(2)^2

  %% Randomization funcs
  rand_sign = @(n) ones(n, 1) - floor(rand(n,1)*2)*2; % pick -1 or 1, n by 1
  rand_speed = @(n) (rand(n,1) - 0.5) * 2 * max_speed; % [-max_speed, max_speed]

  % d = zeros(numBirds,4);

  %% Collision with border
  % If a single bird collides into the border with last round's speed
  % 1. keep last speed magnitude
  % 2. change sign of dx, but vary its magnitude
  % 3. dy reacts to keep v_x^2 + v_y^2 = v^2

  % if bird.x + bird.dx >= sky_xlim
  %
  %     bird.dx = -bird.dx * rand; % rand: turn any degree
  %     bird.dy = dy(bird.dx) % adjust v_y with random turn to keep last
  %                             speed magnitude

  %% Each bird
  for i=1:numBirds

    bird = birds(i,:); % bird = [x, y, v_x, v_y]
    x = bird(1);
    y = bird(2);
    % dBird = [v_x, v_y, a_x, a_y]
    % dBird = [bird_dx, bird_dy, 0, 0]
    v_x = bird(3);
    v_y = bird(4);

    fprintf('\nbird %d: [%4.2f, %4.2f, %4.2f, %4.2f]\n', i, x, y, v_x, v_y);

    %% Check sky collision
    % Check x collision with xlim
    while (x+v_x > sky_xlim) | (x+v_x < 0)
      fprintf('bird %d collided at x_lim or 0.\n\tBefore:', i);
      fprintf('\t[%4.2f, %4.2f, %4.2f, %4.2f]\n', x, y, v_x, v_y);

      v_x = -(v_x ./ abs(v_x)) * rand_speed(1); % switch sign, rand magnitude

      fprintf('\tAfter:');
      fprintf('\t[%4.2f, %4.2f, %4.2f, %4.2f]\n', x, y, v_x, v_y);
    end
    % Check y collision with ylim
    while (y+v_y > sky_ylim) | (y+v_y < 0)
      fprintf('bird %d collided at y_lim or 0.\n\tBefore:', i);
      fprintf('\t[%4.2f, %4.2f, %4.2f, %4.2f]\n', x, y, v_x, v_y);

      v_y = -(v_y ./ abs(v_y)) * rand_speed(1); % switch sign, rand magnitude

      fprintf('\tAfter:');
      fprintf('\t[%4.2f, %4.2f, %4.2f, %4.2f]\n', x, y, v_x, v_y);
    end

    d(i,:) = [v_x, v_y, v_x-bird(3), v_y-bird(4)];

  end
end
