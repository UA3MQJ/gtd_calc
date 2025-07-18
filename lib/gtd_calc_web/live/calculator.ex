defmodule GtdCalcWeb.Calculator do
  use GtdCalcWeb, :live_view

  def mount(_params, _session, socket) do
    assigns = %{
      # параметры окружающей среды
      r_os: 101325,
      t_os: 288.15,
      k: 1.4,
      rb: 287.1,
      m: 0.0,
      # параметры компрессора
      gv: 1.42,
      pk: 4.75,
      dkn: 0.230,
      dkvn: 0.215,
      ncomp: 0.77,
      yk: 0.22,
      # параметры КС
      votb: 0,
      tg: 1170,
      # параметры турбины
      dtn: 0.128,
      dtvn: 0.088,
      # параметры топлива
      gt: 0.026,
      hu: 42915,
      l0: 14.7,
      rt: 800,
      vr: 2.5e-6,
      tt: 300,
      # полнота сгорания
      kv: 0.22,
      # результаты
      t_v: nil,
      t_k: nil,
      n_g: nil,
      formula1: "",
      formula2: "",
      formula3: "",
      formula4: "",
      formula5: "",
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
      m: Utils.to_float(params["m"]),
      gv: Utils.to_float(params["gv"]),
      pk: Utils.to_float(params["pk"]),
      dkn: Utils.to_float(params["dkn"]),
      dkvn: Utils.to_float(params["dkvn"]),
      ncomp: Utils.to_float(params["ncomp"]),
      yk: Utils.to_float(params["yk"]),
      votb: Utils.to_float(params["votb"]),
      tg: Utils.to_float(params["tg"]),
      dtn: Utils.to_float(params["dtn"]),
      dtvn: Utils.to_float(params["dtvn"]),
      gt: Utils.to_float(params["gt"]),
      hu: Utils.to_float(params["hu"]),
      l0: Utils.to_float(params["l0"]),
      rt: Utils.to_float(params["rt"]),
      vr: Utils.to_float(params["vr"]),
      tt: Utils.to_float(params["tt"]),
      kv: Utils.to_float(params["kv"]),
    }

    socket = assign(socket, assigns)
    socket = refresh_formula(socket)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-md mx-auto mt-10 p-6 bg-white shadow rounded">
      <h1 class="text-2xl font-bold mb-4">Расчет камеры сгорания МГТД</h1>
      <h1>Исходные данные</h1>
      <br>
      <h1>Необходимые данные</h1>
      <br>

      <form phx-submit="calculate" class="space-y-4">
        <b>Параметры окружающей среды</b>
        <br>
        <div>
          <label class="block text-sm font-medium">Rос (Па):</label>
          <input type="number" name="calc[r_os]" value={@r_os} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">Tос (К):</label>
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
        <br>
        <b>Параметры компрессора</b>
        <br>
        <div>
          <label class="block text-sm font-medium">Gв (кг/c):</label>
          <input type="number" name="calc[gv]" value={@gv} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">Пк:</label>
          <input type="number" name="calc[pk]" value={@pk} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">Dкн (м):</label>
          <input type="number" name="calc[dkn]" value={@dkn} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">Dквн (м):</label>
          <input type="number" name="calc[dkvn]" value={@dkvn} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">ηкомп:</label>
          <input type="number" name="calc[ncomp]" value={@ncomp} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">λк:</label>
          <input type="number" name="calc[yk]" value={@yk} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <br><b>Параметры КС</b><br>
        <div>
          <label class="block text-sm font-medium">βотб:</label>
          <input type="number" name="calc[votb]" value={@votb} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">Tг (K):</label>
          <input type="number" name="calc[tg]" value={@tg} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <br><b>Параметры турбины</b><br>
        <div>
          <label class="block text-sm font-medium">Dтн (м):</label>
          <input type="number" name="calc[dtn]" value={@dtn} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">Dтвн (м):</label>
          <input type="number" name="calc[dtvn]" value={@dtvn} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <br><b>Параметры топлива</b><br>
        <div>
          <label class="block text-sm font-medium">Gт (кг/с):</label>
          <input type="number" name="calc[gt]" value={@gt} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">Hu (кДж/кг):</label>
          <input type="number" name="calc[hu]" value={@hu} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">L0:</label>
          <input type="number" name="calc[l0]" value={@l0} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">ρт (кг/м<sup>3</sup>):</label>
          <input type="number" name="calc[rt]" value={@rt} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">vт (м<sup>2</sup>/c):</label>
          <input type="number" name="calc[vr]" value={@vr} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>
        <div>
          <label class="block text-sm font-medium">Tт:</label>
          <input type="number" name="calc[tt]" value={@tt} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
        </div>

        <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded">
          Рассчитать
        </button>

        <br><br><h1>Расчет</h1><br>


          <div id="katex-container" phx-hook="KatexRenderer" phx-update="replace">
            Температура на входе в двигатель<br>{@formula1}
            Температура за компрессором<br>{@formula2}
            Скорость за компрессором<br>{@formula3}
            Давление за компрессором<br>{@formula4}
            Полнота сгорания<br>
            <div>
              <label class="block text-sm font-medium">Kv:</label>
              <input type="number" name="calc[kv]" value={@kv} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>

            {@formula5}
          </div>


      </form>

    </div>
    """
  end

  defp refresh_formula(socket) do
    t_v = calculate_t_v(socket.assigns)
    socket = assign(socket, t_v: t_v)

    formula1 = "\\[ T_{\\text{в}} = T_{\\text{ос}} \\cdot \\left( 1 + \\frac{k - 1}{k} \\cdot M^2 \\right) = #{t_v} \\]"

    t_k = calculate_t_k(socket.assigns)
    socket = assign(socket, t_k: t_k)

    formula2 = "\\[ T_{\\text{к}} = T_{\\text{в}} \\cdot \\left( 1 + \\frac{Пк^\\frac{k-1}{k}}{ηкомп} \\right) = #{t_k} \\]"


    n_g = calculate_n_g(socket.assigns)
    socket = assign(socket, n_g: n_g)

    formula5 = "\\[ ηг = 1 - 0.8 \\cdot Kv^2 = #{n_g} \\]"

    assign(socket, formula1: formula1,
                   formula2: formula2,
                   formula5: formula5,
    )
  end

  defp calculate_t_v(assigns) do
    assigns.t_os * (1 + (((assigns.k - 1)/(assigns.k))*(assigns.m*assigns.m)))
  end

  defp calculate_t_k(assigns) do
    assigns.t_v * (1 + (((:math.pow(assigns.pk, ((assigns.k - 1)/(assigns.k))))-1)/(assigns.ncomp)))
  end

  defp calculate_n_g(assigns) do
    1 - (0.8 * (:math.pow(assigns.kv, 2)))
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
