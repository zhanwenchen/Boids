%% dBirds takes the current frame birds object
function [d] = dBirds(birds,side_length,max_speed)
  numBirds = size(birds,1);
  % side_length = 2;

  %% Environment vars
  sky_xlim = 200;
  sky_ylim = 200;

  %% Bird vars
  % max_speed = 10; %m/s % don't care if 20^2 + 20^2 = 20*sqrt(2)^2

  %% Randomization funcs
  rand_sign = @(n) ones(n, 1) - floor(rand(n,1)*2)*2; % pick -1 or 1, n by 1
  rand_speed = @(n) (rand(n,1) - 0.5) * 2 * max_speed; % [-max_speed, max_speed]

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
    v_x = bird(3);
    v_y = bird(4);

    this_left = x - 0.5*side_length;
    this_right = x + 0.5*side_length;
    this_top = y + 0.5*side_length;
    this_bottom = y - 0.5*side_length;

    collide_with_sky_x = @(v_x) (this_right+v_x > sky_xlim) | (this_left+v_x < 0);
    collide_with_sky_y = @(v_y) (this_top+v_y > sky_ylim) | (this_bottom+v_y < 0);

    % fprintf('\nbird %d: [%4.2f, %4.2f, %4.2f, %4.2f]\n', i, x, y, v_x, v_y);

    %% Check sky collision
    % Check x collision with xlim
    while collide_with_sky_x(v_x)
      % fprintf('bird %d collided at x_lim or 0.\n\tBefore:', i);
      % fprintf('\t[%4.2f, %4.2f, %4.2f, %4.2f]\n', x, y, v_x, v_y);

      v_x = -(v_x ./ abs(v_x)) * rand_speed(1); % switch sign, rand magnitude

      % fprintf('\tAfter:');
      % fprintf('\t[%4.2f, %4.2f, %4.2f, %4.2f]\n', x, y, v_x, v_y);
    end
    % Check y collision with ylim
    while collide_with_sky_y(v_y)
      % fprintf('bird %d collided at y_lim or 0.\n\tBefore:', i);
      % fprintf('\t[%4.2f, %4.2f, %4.2f, %4.2f]\n', x, y, v_x, v_y);

      v_y = -(v_y ./ abs(v_y)) * rand_speed(1); % switch sign, rand magnitude

      % fprintf('\tAfter:');
      % fprintf('\t[%4.2f, %4.2f, %4.2f, %4.2f]\n', x, y, v_x, v_y);
    end

    % Don't need to check before?
    for j=(i+1):numBirds
      other = birds(j,:);

      other_left = other(1) - 0.5*side_length;
      other_right = other(1) + 0.5*side_length;
      other_top = other(2) + 0.5*side_length;
      other_bottom = other(2) - 0.5*side_length;

      collide_with_other_right = @(v_x) (v_x >= 0)... % moving right
          & (x < other(1))... % this bird's center is to the left of other
          & ((this_top+v_y)>other_bottom) & ((this_bottom+v_y)<other_top)... % this
          & (other_left<(this_right+v_x));

      collide_with_other_left = @(v_x) (v_x < 0)... % moving left
          & (other(1) < x)... % this bird's center is to the right of other
          & ((this_top+v_y)>other_bottom) & ((this_bottom+v_y)<other_top)... % this
          & ((this_left+v_x)<other_right);

      collide_with_other_top = @(v_y) (v_y >= 0) ... % moving up
          & (y < other(2)) ... % this bird's center is to the bottom of other
          & ((this_left+v_x)<other_right) & ((this_right+v_x)>other_left) ... % this
          & ((this_top+v_y)>other_bottom);

      collide_with_other_bottom = @(v_y) (v_y < 0) ... % moving down
          & (y > other(2)) ... % this bird's center is to the bottom of other
          & ((this_left+v_x)<other_right) & ((this_right+v_x)>other_left) ... % this
          & ((this_bottom+v_y)<other_top);

      % Strict
      % This bird's right border collides with left border of other bird
      while collide_with_other_right(v_x) | collide_with_other_left(v_x)
        v_x = -(v_x ./ abs(v_x)) * rand_speed(1); % flip sign, rand magnitude
      end

      while collide_with_other_top(v_y) | collide_with_other_bottom(v_y)
        v_y = -(v_y ./ abs(v_y)) * rand_speed(1);
      end

    end
    % d(i,:) = [bird(3), bird(4), v_x-bird(3), v_y-bird(4)];
    d(i,:) = [v_x, v_y, v_x-bird(3), v_y-bird(4)];
  end
end
