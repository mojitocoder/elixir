defmodule SpaceAge do
  def age_on(planet, seconds) do
    case planet do
      :earth ->
        seconds / 365.25 / 24 / 3600
      :mercury ->
        age_on(:earth, seconds) / 0.2408467
      :venus ->
        age_on(:earth, seconds) / 0.61519726
      :mars ->
        age_on(:earth, seconds) / 1.8808158
      :jupiter ->
          age_on(:earth, seconds) / 11.862615
      :saturn ->
          age_on(:earth, seconds) / 29.447498
      :uranus ->
          age_on(:earth, seconds) / 84.016846
      :neptune ->
          age_on(:earth, seconds) / 164.79132
      _ ->
        seconds
    end
  end
end
