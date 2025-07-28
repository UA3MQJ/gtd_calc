defmodule GtdCalcWeb.Calculates do

  def calculate(:t_v, a) do
    a.t_os * (1 + (((a.k - 1)/(a.k))*(a.m*a.m)))
  end

  def calculate(:t_k, a) do
    a.t_v * (1 + (((:math.pow(a.pk, ((a.k - 1)/(a.k))))-1)/(a.ncomp)))
  end

  def calculate(:n_g, a) do
    1 - (0.8 * (:math.pow(a.kv, 2)))
  end

  def calculate(:w_k, a) do
    :math.sqrt(a.rv*a.t_k*(((2*a.k)/(a.k+1))))*a.yk
  end

  def calculate(:p_k, a) do
    a.pk * a.r_os
  end

  def calculate(:srvtg, a) do
    4.187 * (
      -0.10353 * :math.pow(a.tg, 4) * :math.pow(10, -10) +
       0.35002 * :math.pow(a.tg, 3) * :math.pow(10, -7) +
      -0.15931 * :math.pow(a.tg, 2) * :math.pow(10, -4) +
       0.24089 * a.tg
    )
  end
  def calculate(:srvtk, a) do
    4.187 * (
      -0.10353 * :math.pow(a.t_k, 4) * :math.pow(10, -10) +
       0.35002 * :math.pow(a.t_k, 3) * :math.pow(10, -7) +
      -0.15931 * :math.pow(a.t_k, 2) * :math.pow(10, -4) +
       0.24089 * a.t_k
    )
  end
  def calculate(:ntg, a) do
    4.187 * (
       0.25084 * :math.pow(a.tg, 2) * :math.pow(10, -3) +
       0.35186 * a.tg +
      -0.33025 * :math.pow(a.tg, 3) * :math.pow(10, -7) +
       -17.533
    )
  end
  def calculate(:nrb, a) do
    4.187 * (
       0.25084 * :math.pow(a.rv, 2) * :math.pow(10, -3) +
       0.35186 * a.rv +
      -0.33025 * :math.pow(a.rv, 3) * :math.pow(10, -7) +
       -17.533
    )
  end
  def calculate(:qt, a) do
    (a.srvtg - a.srvtk) / (a.hu * a.n_g - a.ntg + a.nrb)
  end
  def calculate(:ak1, a) do
    (1) / (a.qt*a.l0)
  end
  def calculate(:ak2, a) do
    ((a.hu * a.n_g)-(a.c2 * a.tg))
     / (a.l0*((a.c2 * a.tg) - (a.c1 * a.t_k)))
  end
  def calculate(:ak, a) do
    (a.gv) / (a.l0 * a.gt)
  end
  def calculate(:gtc, a) do
    (a.gt) * 3600
  end
  def calculate(:vg, a) do
    (a.gv * (1 - a.votb)) / (a.kv * (a.p_k / (:math.pow(10, 5))) * a.t_k)
  end
  def calculate(:kv2, a) do
    (a.gv * (1 - a.votb)) / (a.vg * (a.p_k / (:math.pow(10, 5))) * a.t_k)
  end
  def calculate(:pv, a) do
    (a.p_k / (a.rv*a.t_k)) * (:math.pow(1 - (((a.k - 1)/(a.k + 1))*a.yk), (1/(a.k - 1))))
  end
  def calculate(:gvzg, a) do
    (a.azg / a.ak) * a.gv * (1 - a.votb)
  end
  def calculate(:kvzg, a) do
    a.kvzg
  end
  def calculate(:vgzg, a) do
    (a.gvzg) / (a.kvzg * :math.pow((a.p_k / (:math.pow(10, 5))), 1.25) * a.t_k)
  end
  def calculate(:gohl, a) do
    (a.gv/100) * 15
  end
  def calculate(:rg, a) do
    a.rv*((1 + 1.0862 * a.qt)/(1+a.qt))
  end
end
