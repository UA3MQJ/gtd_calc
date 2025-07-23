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
    :math.sqrt(a.rb*a.t_k*(((2*a.k)/(a.k+1))))*a.yk
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
       0.25084 * :math.pow(a.rb, 2) * :math.pow(10, -3) +
       0.35186 * a.rb +
      -0.33025 * :math.pow(a.rb, 3) * :math.pow(10, -7) +
       -17.533
    )
  end
  def calculate(:qr, a) do
    (a.srvtg - a.srvtk) / (a.hu * a.n_g - a.ntg + a.nrb)
  end
  def calculate(:ak1, a) do
    (1) / (a.qr*a.l0)
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
end
