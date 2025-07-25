defmodule GtdCalcWeb.Calculator do
  use GtdCalcWeb, :live_view

  @params [:r_os, :t_os, :k, :rb, :m, :gv, :pk, :dkn, :dkvn, :ncomp, :yk, :votb, :tg, :dtn, :dtvn, :gt, :hu, :l0, :rt, :vr, :tt, :kv, :c1, :c1]
  @calcs  [
            :t_v, :t_k, :n_g, :w_k, :p_k, :srvtg, :srvtk, :ntg, :nrb, :qr, :ak1, :ak2, :ak, :gtc, :vg, :kv2, :pv,
            :gvzg
          ]

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
      c1: 1.2 , c2: 1.164,
      azg: 1.61 # αзг
    }

    socket = assign(socket, Map.new(assigns))

    {:ok, refresh_formula(socket)}
  end

  def handle_event("calculate", %{"calc" => params}, socket) do
    assigns = @params
      |> Enum.map(fn(k) -> {k, Utils.to_float(params["#{k}"])} end)
      |> Enum.into(%{})

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

            Температура на входе в двигатель<br>{@formulas.t_v}
            Температура за компрессором<br>{@formulas.t_k}
            Скорость за компрессором<br>{@formulas.w_k}
            Давление за компрессором<br>{@formulas.p_k}
            Полнота сгорания<br>
            <div>
              <label class="block text-sm font-medium">Kv:</label>
              <input type="number" name="calc[kv]" value={@kv} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>

            {@formulas.n_g}

            Относительный расход топлива<br>
            {@formulas.srvtg}
            {@formulas.srvtk}
            {@formulas.ntg}
            {@formulas.nrb}
            {@formulas.qr}

            <br>Коэффициент избытка воздуха в камере сгорания<br>
            {@formulas.ak1}
            <div>
              <label class="block text-sm font-medium">C1:</label>
              <input type="number" name="calc[c1]" value={@c1} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            <div>
              <label class="block text-sm font-medium">C2:</label>
              <input type="number" name="calc[c2]" value={@c2} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>

            {@formulas.ak2}
            {@formulas.ak}

            Часовой расход топлива<br>
            {@formulas.gtc}

            Объем жаровой трубы<br>
            {@formulas.kv2}
            {@formulas.vg}
            {@formulas.pv}

            Расход воздуха в зоне горения<br>
            <div>
              <label class="block text-sm font-medium">αзг:</label>
              <input type="number" name="calc[azg]" value={@azg} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            {@formulas.gvzg}

          </div>


      </form>

    </div>
    """
  end

  defp refresh_formula(socket) do
    socket = Enum.reduce(@calcs, socket, fn key, socket->
      calc(key, socket)
    end)

    formulas = Enum.reduce(@calcs, %{}, fn key, formulas->
      result = GtdCalcWeb.Formulas.get(key, socket.assigns)
      Map.merge(formulas, %{key => result})
    end)

    assign(socket, formulas: formulas)
  end

  def calc(key, socket) do
    result = GtdCalcWeb.Calculates.calculate(key, socket.assigns)
    assign(socket, %{key => result})
  end
end
