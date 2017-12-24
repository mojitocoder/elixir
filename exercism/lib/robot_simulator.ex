defmodule RobotSimulator do
  defstruct [:direction, :position]

  def create do
    create(:north, {0, 0})
  end

  def create(direction, _)
    when direction not in [:north, :south, :east, :west] do
    { :error, "invalid direction" }
  end

  def create(direction, position) do
    case position do
      {x, y} ->
        if is_integer(x) && is_integer(y) do
          %RobotSimulator{direction: direction, position: position}
        else
          { :error, "invalid position" }
        end
      _ ->
        { :error, "invalid position" }
    end
  end

  def position(%RobotSimulator{} = robot) do
    robot.position
  end

  def direction(%RobotSimulator{} = robot) do
    robot.direction
  end

  def simulate(robot, instruction) do
    instruction
      |> String.graphemes
      |> Enum.reduce(robot, fn (m, acc) -> act(acc, m) end)
  end

  def act(%RobotSimulator{} = robot, "A") do
    case robot.direction do
      :north ->
        %RobotSimulator{robot |
          position: {elem(robot.position, 0), elem(robot.position, 1) + 1 }}
      :south ->
        %RobotSimulator{robot |
          position: {elem(robot.position, 0), elem(robot.position, 1) - 1 }}
      :east ->
        %RobotSimulator{robot |
          position: {elem(robot.position, 0) + 1, elem(robot.position, 1)}}
      :west ->
        %RobotSimulator{robot |
          position: {elem(robot.position, 0) - 1, elem(robot.position, 1)}}
    end
  end

  def act(%RobotSimulator{} = robot, "L") do
    case robot.direction do
      :north ->
        %RobotSimulator{robot |
          direction: :west}
      :south ->
        %RobotSimulator{robot |
          direction: :east}
      :east ->
        %RobotSimulator{robot |
          direction: :north}
      :west ->
        %RobotSimulator{robot |
          direction: :south}
    end
  end

  def act(%RobotSimulator{} = robot, "R") do
    case robot.direction do
      :north ->
        %RobotSimulator{robot |
          direction: :east}
      :south ->
        %RobotSimulator{robot |
          direction: :west}
      :east ->
        %RobotSimulator{robot |
          direction: :south}
      :west ->
        %RobotSimulator{robot |
          direction: :north}
    end
  end

  def act(_, _) do
    { :error, "invalid instruction" }
  end
end
