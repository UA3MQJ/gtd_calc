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

        :qt =>
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
          "ρв = \\frac{Pк}{Rв \\cdot Tк} \\cdot \\left(1 - \\frac{k-1}{k+1} \\cdot λк\\right)^{\\frac{1}{k-1}}",

        :gvzg =>
          "Gвзг = \\frac{αзг}{αк} \\cdot Gв \\cdot (1 - βотб)",

        :kvzg =>
          "Kvзг = \\frac{Gвзг}{Vжзг \\cdot \\left( \\frac{Pк}{10^5} \\right)^{1.25} \\cdot Tк}",

        :vgzg =>
          "Vжзг",

        :gohl =>
          "Gохл = \\frac{Gв}{100} \\cdot 15",

        :rg =>
          "Rг = Rв \\cdot \\frac{1 + 1.0862 \\cdot qт}{1+qт}",

        :t =>
          "T = \\frac{Tг}{1000}",

        :srv1 =>
          "Срв1 = 1.04406-0.39193\\cdotТ+1.08845\\cdotТ^2-0.85793\\cdotТ^3+0.29362\\cdotТ^4-0.03747\\cdotТ^5",

        :srv =>
          "Срв = Срв1 \\cdot 1000",

        :nn =>
          "Nn = 1.80041+0.93518\\cdotТ+0.98923\\cdotТ^2-0.69064\\cdotТ^3+0.1187\\cdotТ^4",

        :srg =>
          "Срг = \\frac{(Cрв1+Nn \\cdot qт) \\cdot 1000}{1+qт} ",

        :kg =>
          "Срг = \\frac{Срг}{Срг - Rг}",

        :tzg =>
          "Tзг = \\frac{αзг \\cdot Срв \\cdot Tк \\cdot \\frac{1}{L0} \\cdot Срт \\cdot Tт + \\frac{1}{L0} \\cdot Qн \\cdot ηг}{Срг \\cdot (\\frac{1}{L0} + 1) + Срг \\cdot (αзг - 1)}",

        :tzgprov =>
          "Tзгпров = \\frac{Gвзг \\cdot Срв \\cdot Tк+Gт \\cdot Срт \\cdot Tт+Gт \\cdot Qн \\cdot ηг}{(Gт + \\frac{Gвзг}{αзг}) \\cdot Срг + (Gвзг - \\frac{Gвзг}{αзг}) \\cdot Срв}",

      }
  end

  def get(key, a) do
    formula = formulas(a)[key]
    result = a[key]
    "\\[ #{formula} = #{result} \\]"
  end
end
