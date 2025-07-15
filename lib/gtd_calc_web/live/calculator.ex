defmodule GtdCalcWeb.Calculator do
  use GtdCalcWeb, :live_view

  def mount(_params, _session, socket) do
    assigns = %{
      r_os: 101325,
      t_os: 288.15,
      k: 1.4,
      rb: 287.1,
      m: 0.0,
      t_v: nil,
      formula1: ""
    }

    socket = assign(socket, Map.new(assigns))

    {:ok, refresh_formula(socket)}
  end

  def handle_event("calculate", %{"calc" => params}, socket) do
    assigns = %{
      r_os: Utils.to_float(params["r_os"]),
      t_os: Utils.to_float(params["t_os"]),
      k: Utils.to_float(params["k"]),
      rb: Utils.to_float(params["rb"]),
      m: Utils.to_float(params["m"])
    }

    socket = assign(socket, assigns)
    socket = refresh_formula(socket)

    {:noreply, socket}
  end

  def render(assigns) do
    t_v = assigns.t_os * (1 + (((assigns.k - 1)/(assigns.k))*(assigns.m*assigns.m)))

    formula1 = "\\[ T_{\\text{в}} = T_{\\text{ос}} \\cdot \\left( 1 + \\frac{k - 1}{k} \\cdot M^2 \\right) = #{t_v} \\]"

    assigns = assign(assigns, :formula1, formula1)

    ~H"""
    <div class="max-w-md mx-auto mt-10 p-6 bg-white shadow rounded">
      <h1 class="text-2xl font-bold mb-4">Расчет камеры сгорания МГТД</h1>
      <h1>Исходные данные</h1>
      <br>
      <h1>Необходимые данные</h1>
      <br>
      <b>Параметры окружающей среды</b>
      <br>
      <form phx-submit="calculate" class="space-y-4">
        <div>
          <label class="block text-sm font-medium">Rос:</label>
          <input type="number" name="calc[r_os]" value={@r_os} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">Tос:</label>
          <input type="number" name="calc[t_os]" value={@t_os} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">k:</label>
          <input type="number" name="calc[k]" value={@k} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">Rб:</label>
          <input type="number" name="calc[rb]" value={@rb} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">M:</label>
          <input type="number" name="calc[m]" value={@m} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>

        <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded">
          Рассчитать
        </button>
      </form>
        <br><br><h1>Расчет</h1><br>
          <p>Температура на входе в двигатель<br>

          <div id="katex-container" phx-hook="KatexRenderer" phx-update="replace">
            {@formula1}
          </div>
          </p>


    </div>
    """
  end

  defp refresh_formula(socket) do
    t_v = calculate_t_v(socket.assigns)

    formula1 = "\\[ T_{\\text{в}} = T_{\\text{ос}} \\cdot \\left( 1 + \\frac{k - 1}{k} \\cdot M^2 \\right) = #{t_v} \\]"

    assign(socket, t_v: t_v, formula1: formula1)
  end

  defp calculate_t_v(assigns) do
    assigns.t_os * (1 + (((assigns.k - 1)/(assigns.k))*(assigns.m*assigns.m)))
  end
end

defmodule Utils do
  def to_float(str) when is_binary(str) do
    case Float.parse(str) do
      {num, _rest} -> num
      :error -> raise "Invalid float string: #{str}"
    end
  end

  def to_float(num) when is_number(num), do: num * 1.0
end
