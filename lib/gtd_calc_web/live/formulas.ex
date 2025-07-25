defmodule GtdCalcWeb.Formulas do

  def formulas(a) do
    %{
        :t_v =>
          "T_{\\text{в}} = T_{\\text{ос}} \\cdot \\left( 1 + \\frac{k - 1}{k} \\cdot M^2 \\right)",

        :t_k =>
          "T_{\\text{к}} = T_{\\text{в}} \\cdot \\left( 1 + \\frac{Пк^\\frac{k-1}{k}}{ηкомп} \\right)",

        :n_g =>
          "ηг = 1 - 0.8 \\cdot Kv^2",

        :w_k =>
          "Wк = \\sqrt{ Rв \\cdot Tк \\cdot \\frac{2 \\cdot k}{k + 1} \\cdot λк}",

        :p_k =>
          "Pк = Пк \\cdot Pос",

        :srvtg =>
          "СрвTг = 4.187 \\cdot (-0.10353 \\cdot Tг^4 \\cdot 10^{-10}+0.35002 \\cdot Tг^3 \\cdot 10^{-7}-0.15931 \\cdot Tг^2 \\cdot 10^{-4}+0.24089 \\cdot Tг)",

        :srvtk =>
          "СрвTк = 4.187 \\cdot (-0.10353 \\cdot Tк^4 \\cdot 10^{-10}+0.35002 \\cdot Tк^3 \\cdot 10^{-7}-0.15931 \\cdot Tк^2 \\cdot 10^{-4}+0.24089 \\cdot Tк)",

        :ntg =>
          "nTг = 4.187 \\cdot ( 0.25084 \\cdot Tг^2 \\cdot 10^{-3}+0.35186 \\cdot Tг-0.33025 \\cdot Tг^3 \\cdot 10^{-7}-17.533 )",

        :nrb =>
          "nRв = 4.187 \\cdot ( 0.25084 \\cdot Rв^2 \\cdot 10^{-3}+0.35186 \\cdot Rв-0.33025 \\cdot Rв^3 \\cdot 10^{-7}-17.533 )",

        :qr =>
          "qт = \\frac{СрвTг - СрвTк}{Hu \\cdot ηг-nTг+nRв}",

        :ak1 =>
          "αк1 = \\frac{1}{qт \\cdot L0}",

        :ak2 =>
          "αк2 = \\frac{Hu \\cdot ηг-C2 \\cdot Tг}{L0(C2 \\cdot Tг-C1 \\cdot Tк)}",

        :ak =>
          "αк = \\frac{Gв}{L0 \\cdot Gт}",

        :gtc =>
          "GтЧ = Gт \\cdot 3600",

        :kv2 =>
          "Kv = \\frac{Gв \\cdot (1 - βотб)}{Vж \\cdot (\\frac{Pк}{10^5}) \\cdot Tк}",

        :vg =>
          "Vж = Find(Vж) ",

        :pv =>
          "ρв = \\frac{Pк}{Rв \\cdot Tк} \\cdot \\left(1 - \\frac{k-1}{k+1} \\cdot λк\\right)^{\\frac{1}{k-1}}"
      }
  end

  def get(key, a) do
    formula = formulas(a)[key]
    result = a[key]
    "\\[ #{formula} = #{result} \\]"
  end
end
