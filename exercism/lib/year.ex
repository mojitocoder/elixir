defmodule Year do
  # on every year that is evenly divisible by 4
  #   except every year that is evenly divisible by 100
  #     unless the year is also evenly divisible by 400
  def leap_year?(y) do
    if rem(y, 4) == 0 do
      if rem(y, 100) == 0 do
        if rem(y, 400) == 0 do
          true
        else
          false
        end
      else
        true
      end
    else
      false
    end
  end
end
