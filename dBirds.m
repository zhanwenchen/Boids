%% dBirds takes the current frame birds object
function [d] = dBirds(birds)
  numBirds = length(birds);

  %% Environment vars
  sky_xlim = 200;
  sky_ylim = 200;

  %% Bird vars
  max_speed = 20; %m/s

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
  for i=1:length(birds)

    bird = birds(i,:); % bird = [x, y, v_x, v_y]
    x = bird(1);
    y = bird(2);
    % dBird = [v_x, v_y, a_x, a_y]
    % dBird = [bird_dx, bird_dy, 0, 0]
    v_x = bird(3);
    v_y = bird(4);

    fprintf('\n%d: bird is [%4.2f, %4.2f, %4.2f, %4.2f]\n', i, x, y, v_x, v_y);

    %% Check sky collision
    % Check x collision with xlim
    while (x+v_x > sky_xlim) | (x+v_x < 0)
      fprintf('sky xlim collision\n');
      v_x = -v_x * rand;
      % v_x = -(v_x ./ abs(v_x)) * rand_speed(1); % switch sign, rand magnitude
    end
    % Check y collision with ylim
    while (y+v_y > sky_ylim) | (x+v_y < 0)
      fprintf('sky ylim collision\n');
      v_y = -v_y * rand;
      % v_y = -(v_y ./ abs(v_y)) * rand_speed(1); % switch sign, rand magnitude
    end
    % whos v_x;
    % whos v_y;

    % fprintf('d is [%4.2f, %4.2f, %4.2f, %4.2f]\n', v_x, v_y, 0,0);
    % disp([v_x,v_y,0,0]);
    d(i,:) = [v_x, v_y, 0, 0];


    %% Check max speed
    % if (v_x.^2 + v_y.^2 > max_speed^2)
    %
    %   fprintf('(v_x.^2 + v_y.^2 > max_speed^2)');
    %   fprintf('%4.2f + %4.2f > %4.2f)\n', v_x.^2, v_y.^2, max_speed.^2);
    %
    % end
  end



  % dBird = [v_x, v_y, a_x, a_y];

  % dx = @(birds) (rand(numBirds,1).*2 - 1) .* max_speed; % dx in [-max_speed, max_speed]
  % % dy = @(birds) rand_sign(:,2) .* sqrt(max_speed^2 - birds(:,3).^2); % pos or neg
  % dy = @(birds) rand_sign(:,2) .* sqrt(abs(max_speed^2 - birds(:,3).^2)); % pos or neg
  % % dBird = [dx, dy, dv_x, dv_y]
  % % or      [v_x, v_y, a_x, a_y]
  % dBirds = @(bird) [dx(bird) dy(bird) zeros(numBirds,1) zeros(numBirds,1)];

  % d = dBirds(birds);
end
