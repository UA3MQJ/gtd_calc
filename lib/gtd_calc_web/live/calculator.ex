defmodule GtdCalcWeb.Calculator do
  use GtdCalcWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
      assign(socket,
        r_os: 101325,
        t_os: 288.15,
        k: 1.4,
        rb: 287.1,
        m: 0.0,
        result: nil,
        math_content:  "Когда \\(a \\ne 0\\), решения квадратного уравнения \\(ax^2 + bx + c = 0\\): \\[ x = {-b \\pm \\sqrt{b^2-4ac} \\over 2a}. \\]"
      )}
  end

  def handle_event("calculate", _, socket) do
    result = 123
    {:noreply,
      assign(socket,
        result: result
      )}
  end

  def render(assigns) do
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

          <div id="formula-container">
            <%= raw(@math_content) %>
          </div>

      <%= if @result do %>
        <div class="mt-6 p-4 bg-green-50 text-green-800 rounded">
          <p>Температура на входе в двигатель<br>
          <div id="formula-container" phx-hook="KatexRenderer">
            <%= raw(@math_content) %>
          </div>
          <strong><%= @result %> </strong></p>
        </div>
      <% end %>
    </div>
    """
  end
end
