defmodule GtdCalcWeb.Calculator do
  use GtdCalcWeb, :live_view

  @params [:r_os, :t_os, :k, :rv, :m, :gv, :pk, :dkn, :dkvn, :ncomp, :yk, :votb, :tg, :dtn, :dtvn, :gt, :hu, :l0, :rt, :vr, :tt, :kv, :c1, :c1,
    :azg, :kvzg, :srt, :qh, :a1, :a2, :a3, :a4, :a5, :lks,
    :deltap, :n, :kf, :u, :bk, :dkz, :nf2, :vb, :beta
  ]
  @calcs  [
            :t_v, :tk, :ng, :wk, :p_k, :srvtg, :srvtk, :ntg, :nrb, :qt, :ak1, :ak2, :ak, :gtc, :vg, :kv2, :pv,
            :gvzg, :kvzg, :vgzg, :gohl, :rg, :t, :srv1, :srv, :nn,
            :srg, :kg, :tzg, :tzgprov, :tg1, :pks, :dksr,
            :dtsr, :hk, :ht, :hz, :hz1,
            :lg, :lzg, :lzs, :ld, :lp, :dp, :fg, :vk, :fk, :fkk,
            :dgn, :dgvn, :fkkn1, :fkkn, :fkkvn,
            :dkkn, :dkkvn,
            :dfr, :nf1, :nf,
            :gf, :gv, :dc1, :lc, :lkz, :f0, :efk, :lgalpha, :alpha1, :alpha, :da,
            :b, :dc, :d, :gc, :mf, :fc, :rf, :rc, :af, :af1, :affi, :fi,
            :ndif, :ldif, :deg, :opr,
            :fi2, :zp, :re, :psit, :psip, :psidif, :deltadif, :ndifkr,
            :teta, :dzetatepl, :deltatepl, :deltaotv1,
            :efotv
          ]

  def mount(_params, _session, socket) do
    assigns = %{
      # параметры окружающей среды
      r_os: 101325,
      t_os: 288.15,
      k: 1.4,
      rv: 287.1,
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
      azg: 1.61, # αзг
      kvzg: 0.097, # Kvзг
      # Максимальная температура зоны горения
      srt: 2220,
      qh: 42950000,
      a1: 2.3, a2: 2.08, a3: 0.5, a4: 1, a5: 0.88,
      lks: 0.19,
      # расчет форсунки
      deltap: 1013250, n: 2, kf: 0.75,  u: 0.6, bk: 2*:math.pi()/3, dkz: 0.004, nf2: 10,
      # гидравлический расчет
      fk: 0.00524, fvih: 0.01,
      vb: 1.51e-5, beta: 10,
      deltaks: 0.03,
      uzt: 0.6
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
          <input type="number" name="calc[rv]" value={@rv} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
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
            Температура за компрессором<br>{@formulas.tk}
            Скорость за компрессором<br>{@formulas.wk}
            Давление за компрессором<br>{@formulas.p_k}
            Полнота сгорания<br>
            <div>
              <label class="block text-sm font-medium">Kv:</label>
              <input type="number" name="calc[kv]" value={@kv} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>

            {@formulas.ng}

            Относительный расход топлива<br>
            {@formulas.srvtg}
            {@formulas.srvtk}
            {@formulas.ntg}
            {@formulas.nrb}
            {@formulas.qt}

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

            Объем зоны горения<br>
            <div>
              <label class="block text-sm font-medium">Kvзг:</label>
              <input type="number" name="calc[kvzg]" value={@kvzg} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            {@formulas.kvzg}
            {@formulas.vgzg}
            Расход воздуха на охлаждение (15-30%)<br>
            {@formulas.gohl}
            Газовая постоянная газа<br>
            {@formulas.rg}
            Относительная температура газа на входе в турбину для использования в расчетном полиноме<br>
            {@formulas.t}
            Теплоемкость сухого воздуха
            {@formulas.srv1}
            {@formulas.srv}
            Комплекс Nn
            {@formulas.nn}
            Теплоемкость газа (Дж/кг/К)
            {@formulas.srg}
            Показатель адиабаты газа на выходе из камеры
            {@formulas.kg}
            Максимальная температура зоны горения
            <div>
              <label class="block text-sm font-medium">Срт:</label>
              <input type="number" name="calc[srt]" value={@srt} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            <div>
              <label class="block text-sm font-medium">Qн:</label>
              <input type="number" name="calc[qh]" value={@qh} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            {@formulas.tzg}
            {@formulas.tzgprov}
            Подтверждение температуры газа
            {@formulas.tg1}
            Мощность камеры сгорания
            {@formulas.pks}

            Определение основных геометрических размеров камеры сгорания<br><br>
            Средний диаметр компрессора
            {@formulas.dksr}
            Средний диаметр турбины
            {@formulas.dtsr}
            Высота лопатки компрессора
            {@formulas.hk}
            Высота лопатки турбины
            {@formulas.ht}

            <br>
            Высота жаровой трубы в первом приближении<br><br>

            <div>
              <label class="block text-sm font-medium">A1:</label>
              <input type="number" name="calc[a1]" value={@a1} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>

            <br>
            Lж/hж=1.8-2.5 относительная длина жаровой трубы<br><br>


            Прямоток
            {@formulas.hz}

            Противоток
            {@formulas.hz1}

            Длины зон камеры сгорания<br><br>
            <div>
              <label class="block text-sm font-medium">A2:</label>
              <input type="number" name="calc[a2]" value={@a2} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            <div>
              <label class="block text-sm font-medium">Lкс:</label>
              <input type="number" name="calc[lks]" value={@lks} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div><br>
            Lзг/hж=1.2-2 относительная длина зоны горения<br><br>


            {@formulas.lg}
            {@formulas.lzg}
            {@formulas.lzs}
            {@formulas.ld}

            <br>
            Средний диаметр жаровой трубы<br><br>
            Lр/hж=0.5-0.6 относительное удаление торца форсунки <br><br>
            <div>
              <label class="block text-sm font-medium">A3:</label>
              <input type="number" name="calc[a3]" value={@a3} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>

            {@formulas.lp}
            {@formulas.dp}

            <br>
            Площадь поперечного сечения жаровой трубы<br><br>
            {@formulas.fg}

            <br>
            Определение размеров корпуса камеры сгорания<br><br>
            <br>
            Объемный расход воздуха через КС
            {@formulas.vk}
            Площадь на входе в КС
            {@formulas.fk}

            <br>
            Суммарная площадь поперечного сечения кольцевых каналов<br><br>
            Fкк/Fк=1.2-1.9 относительная площадь кольцевых каналов<br><br>
            <div>
              <label class="block text-sm font-medium">A4:</label>
              <input type="number" name="calc[a4]" value={@a4} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>

            {@formulas.fkk}
            Наружный и внутренний диаметры ЖТ
            {@formulas.dgn}
            {@formulas.dgvn}
            Площадь наружного и внутреннего кольцевых каналов<br>
            прямоток
            {@formulas.fkkn1}
            противоток
            {@formulas.fkkn}
            {@formulas.fkkvn}
            Диаметр наружной обечайки корпуса
            {@formulas.dkkn}
            Диаметр внутренней обечайки корпуса
            {@formulas.dkkvn}

            <br><br>
            Определение числа форсунок<br><br>
            Средний диаметр фронтового устройства
            {@formulas.dfr}
            tф/hж=0.3-0.8 Относительный шаг форсунок<br><br>
            <div>
              <label class="block text-sm font-medium">A5:</label>
              <input type="number" name="calc[a5]" value={@a5} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            {@formulas.nf1}
            {@formulas.nf}

            <br><br>Расчет форсунки<br><br>
            <div>
              <label class="block text-sm font-medium">ΔP (Па):</label>
              <input type="number" name="calc[deltap]" value={@deltap} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            <div>
              <label class="block text-sm font-medium">n:</label>
              <input type="number" name="calc[n]" value={@n} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            <div>
              <label class="block text-sm font-medium">kф:</label>
              <input type="number" name="calc[kf]" value={@kf} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            <div>
              <label class="block text-sm font-medium">μ:</label>
              <input type="number" name="calc[u]" value={@u} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            <div>
              <label class="block text-sm font-medium">βк (2*pi/3) угол конусности в радианах:</label>
              <input type="number" name="calc[bk]" value={@bk} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            <div>
              <label class="block text-sm font-medium">Dкз (диаметр камеры закрутки):</label>
              <input type="number" name="calc[dkz]" value={@dkz} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            <div>
              <label class="block text-sm font-medium">nф2:</label>
              <input type="number" name="calc[nf2]" value={@nf2} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>

            Расход через одну форсунку в кг/c
            {@formulas.gf}
            Расход через одну форсунку в м3/c
            {@formulas.gv}
            Диаметр соплового отверстия
            {@formulas.dc1}
            Длина соплового канала
            {@formulas.lc}
            Высота камеры закрутки
            {@formulas.lkz}
            Суммарная площадь закручивающих каналов
            {@formulas.f0}
            {@formulas.efk}
            Угол наклона закручивающих каналов
            {@formulas.lgalpha}
            {@formulas.alpha1}
            {@formulas.alpha}
            Диаметр закручивающих каналов
            {@formulas.da}

            <br><br>Аналитический расчет форсунки<br><br>
            {@formulas.b}
            {@formulas.dc}
            {@formulas.d}
            Коэффициент кратности
            {@formulas.gc}
            {@formulas.mf}
            Площадь сопла форсунки в выходном сечении
            {@formulas.fc}
            Растояние от оси входного канало до оси форсунки
            {@formulas.rf}
            Геометрическая характеристика форсунки
            {@formulas.rc}
            {@formulas.af}
            {@formulas.af1}
            Коэффициент живого сечения
            {@formulas.affi}
            {@formulas.fi}
            ...
            доделать позже
            ...

            <br><br>Гидравлический расчет<br><br>
            Степень раскрытия диффузора


            <br><br>Fк = {@fk}<br><br>

            <div>
              <label class="block text-sm font-medium">Fвых:</label>
              <input type="number" name="calc[fvih]" value={@fvih} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            {@formulas.ndif}
            Величина раскрытия диффузора

            { "\\[ Lдиф = Lд \\]" }
            { "Given" }
            { "\\[ tan \\left( \\frac{σпр \\cdot deg}{2} \\right) = \\frac{hк}{Lдиф} \\cdot (\\sqrt{nдиф} - 1) \\]" }

            {@formulas.opr}

            Коэффициенты сопротивления
            {@formulas.fi2}
            {@formulas.zp}

            <div>
              <label class="block text-sm font-medium">vв (кинематическая вязкость):</label>
              <input type="number" name="calc[vb]" value={@vb} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>

            {@formulas.re}
            {@formulas.psit}

            <div>
              <label class="block text-sm font-medium">β:</label>
              <input type="number" name="calc[beta]" value={@beta} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>

            {@formulas.psip}
            Коэффициент гидравлических потель в диффузоре
            {@formulas.psidif}
            {@formulas.deltadif}
            Критическое значение величины степени расширения на плавном участке
            {@formulas.ndifkr}

            <br><br>Тепловые потери<br><br>
            Коэффициент тепловых потерь
            {@formulas.teta}
            {@formulas.dzetatepl}
            {@formulas.deltatepl}

            <br><br>
            Величина потерь полного давления при перетекании через отверстия
            <br><br>

            <div>
              <label class="block text-sm font-medium">δкс:</label>
              <input type="number" name="calc[deltaks]" value={@deltaks} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            {@formulas.deltaotv1}
            Суммарная геометрическая площадь отверстий<br><br>
            <div>
              <label class="block text-sm font-medium">μжт:</label>
              <input type="number" name="calc[uzt]" value={@uzt} step="any" required class="mt-1 block w-full border-gray-300 rounded" />
            </div>
            <br><br>
            given
            { "\\[ μ \\cdot ΣFотв = Fкк \\cdot \\sqrt{[\\frac{0.6 \\cdot λк^2 \\cdot k}{δотв1 \\cdot (k + 1) - 0.1 \\cdot λк^2 \\cdot k}]^{3}} \\]" }

            {@formulas.efotv}

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
