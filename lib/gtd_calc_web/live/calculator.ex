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
      c1: 1.2 , c2: 1.164,
      # результаты
      t_v: nil,
      t_k: nil,
      n_g: nil,
      w_k: nil,
      p_k: nil,
      srvtg: nil,
      srvtk: nil,
      ntg: nil,
      nrb: nil,
      qr: nil,
      ak1: nil,
      ak2: nil,
      ak: nil,
      formula1: "",
      formula2: "",
      formula3: "",
      formula4: "",
      formula5: "",
      formula6: "",
      formula7: "",
      formula8: "",
      formula9: "",
      formula10: "",
      formula11: "",
      formula12: "",
      formula13: "",
      formula14: "",
      formula15: ""
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
      c1: Utils.to_float(params["c1"]),
      c2: Utils.to_float(params["c2"]),
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

            Относительный расход топлива<br>
            {@formula6}
            {@formula7}
            {@formula8}
            {@formula9}
            {@formula10}

            <br>Коэффициент избытка воздуха в камере сгорания<br>
            {@formula11}
            <div>
              <label class="block text-sm font-medium">C1:</label>
              <input type="number" name="calc[c1]" value={@c1} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            <div>
              <label class="block text-sm font-medium">C2:</label>
              <input type="number" name="calc[c2]" value={@c2} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>

            {@formula14}
            {@formula15}
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

    w_k = calculate_w_k(socket.assigns)
    socket = assign(socket, w_k: w_k)

    formula3 = "\\[ Wк = \\sqrt{ Rв \\cdot Tк \\cdot \\frac{2 \\cdot k}{k + 1} \\cdot λк} = #{w_k} \\]"

    p_k = calculate_p_k(socket.assigns)
    socket = assign(socket, p_k: p_k)

    formula4 = "\\[ Pк = Пк \\cdot Pос = #{p_k} \\]"

    srvtg = calculate_srvtg(socket.assigns)
    socket = assign(socket, srvtg: srvtg)
    srvtk = calculate_srvtk(socket.assigns)
    socket = assign(socket, srvtk: srvtk)
    ntg = calculate_ntg(socket.assigns)
    socket = assign(socket, ntg: ntg)
    nrb = calculate_nrb(socket.assigns)
    socket = assign(socket, nrb: nrb)
    qr = calculate_qr(socket.assigns)
    socket = assign(socket, qr: qr)

    formula6 = "\\[ СрвTг = 4.187 \\cdot (-0.10353 \\cdot Tг^4 \\cdot 10^{-10}+0.35002 \\cdot Tг^3 \\cdot 10^{-7}-0.15931 \\cdot Tг^2 \\cdot 10^{-4}+0.24089 \\cdot Tг) = #{srvtg} \\]"
    formula7 = "\\[ СрвTк = 4.187 \\cdot (-0.10353 \\cdot Tк^4 \\cdot 10^{-10}+0.35002 \\cdot Tк^3 \\cdot 10^{-7}-0.15931 \\cdot Tк^2 \\cdot 10^{-4}+0.24089 \\cdot Tк) = #{srvtk} \\]"
    formula8 = "\\[ nTг = 4.187 \\cdot ( 0.25084 \\cdot Tг^2 \\cdot 10^{-3}+0.35186 \\cdot Tг-0.33025 \\cdot Tг^3 \\cdot 10^{-7}-17.533 ) = #{ntg} \\]"
    formula9 = "\\[ nRв = 4.187 \\cdot ( 0.25084 \\cdot Rв^2 \\cdot 10^{-3}+0.35186 \\cdot Rв-0.33025 \\cdot Rв^3 \\cdot 10^{-7}-17.533 ) = #{nrb} \\]"
    formula10 = "\\[ qт = \\frac{СрвTг - СрвTк}{Hu \\cdot ηг-nTг+nRв} = #{qr} \\]"

    ak1 = calculate_ak1(socket.assigns)
    socket = assign(socket, ak1: ak1)
    ak2 = calculate_ak2(socket.assigns)
    socket = assign(socket, ak2: ak2)
    ak = calculate_ak(socket.assigns)
    socket = assign(socket, ak: ak)

    formula11 = "\\[ αк1 = \\frac{1}{qт \\cdot L0}= #{ak1} \\]"
    formula14 = "\\[ αк2 = \\frac{Hu \\cdot ηг-C2 \\cdot Tг}{L0(C2 \\cdot Tг-C1 \\cdot Tк)} = #{ak2} \\]"
    formula15 = "\\[ αк = \\frac{Gв}{L0 \\cdot Gт}= #{ak} \\]"

    assign(socket, formula1: formula1,
                   formula2: formula2,
                   formula3: formula3,
                   formula4: formula4,
                   formula5: formula5,
                   formula6: formula6,
                   formula7: formula7,
                   formula8: formula8,
                   formula9: formula9,
                   formula10: formula10,
                   formula11: formula11,
                   formula14: formula14,
                   formula15: formula15
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

  defp calculate_w_k(assigns) do
    :math.sqrt(assigns.rb*assigns.t_k*(((2*assigns.k)/(assigns.k+1))))*assigns.yk
  end

  defp calculate_p_k(assigns) do
    assigns.pk * assigns.r_os
  end

  defp calculate_srvtg(a) do
    4.187 * (
      -0.10353 * :math.pow(a.tg, 4) * :math.pow(10, -10) +
       0.35002 * :math.pow(a.tg, 3) * :math.pow(10, -7) +
      -0.15931 * :math.pow(a.tg, 2) * :math.pow(10, -4) +
       0.24089 * a.tg
    )
  end
  defp calculate_srvtk(a) do
    4.187 * (
      -0.10353 * :math.pow(a.t_k, 4) * :math.pow(10, -10) +
       0.35002 * :math.pow(a.t_k, 3) * :math.pow(10, -7) +
      -0.15931 * :math.pow(a.t_k, 2) * :math.pow(10, -4) +
       0.24089 * a.t_k
    )
  end
  defp calculate_ntg(a) do
    4.187 * (
       0.25084 * :math.pow(a.tg, 2) * :math.pow(10, -3) +
       0.35186 * a.tg +
      -0.33025 * :math.pow(a.tg, 3) * :math.pow(10, -7) +
       -17.533
    )
  end
  defp calculate_nrb(a) do
    4.187 * (
       0.25084 * :math.pow(a.rb, 2) * :math.pow(10, -3) +
       0.35186 * a.rb +
      -0.33025 * :math.pow(a.rb, 3) * :math.pow(10, -7) +
       -17.533
    )
  end
  defp calculate_qr(a) do
    (a.srvtg - a.srvtk) / (a.hu * a.n_g - a.ntg + a.nrb)
  end
  defp calculate_ak1(a) do
    (1) / (a.qr*a.l0)
  end
  defp calculate_ak2(a) do
    ((a.hu * a.n_g)-(a.c2 * a.tg))
     / (a.l0*((a.c2 * a.tg) - (a.c1 * a.t_k)))
  end
  defp calculate_ak(a) do
    (a.gv) / (a.l0 * a.gt)
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
