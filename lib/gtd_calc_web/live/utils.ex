defmodule Utils do
  # def to_float(nil), do: nil
  def to_float(str) when is_binary(str) do
    case Float.parse(str) do
      {num, _rest} -> num
      :error -> raise "Invalid float string: #{str}"
    end
  end

  def to_float(num) when is_number(num), do: num * 1.0
end
