defmodule GtdCalcWeb.Calculates do

  def calculate(:t_v, a) do
    a.t_os * (1 + (((a.k - 1)/(a.k))*(a.m*a.m)))
  end

  def calculate(:tk, a) do
    a.t_v * (1 + (((:math.pow(a.pk, ((a.k - 1)/(a.k))))-1)/(a.ncomp)))
  end

  def calculate(:ng, a) do
    1 - (0.8 * (:math.pow(a.kv, 2)))
  end

  def calculate(:w_k, a) do
    :math.sqrt(a.rv*a.tk*(((2*a.k)/(a.k+1))))*a.yk
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
      -0.10353 * :math.pow(a.tk, 4) * :math.pow(10, -10) +
       0.35002 * :math.pow(a.tk, 3) * :math.pow(10, -7) +
      -0.15931 * :math.pow(a.tk, 2) * :math.pow(10, -4) +
       0.24089 * a.tk
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
    (a.srvtg - a.srvtk) / (a.hu * a.ng - a.ntg + a.nrb)
  end
  def calculate(:ak1, a) do
    (1) / (a.qt*a.l0)
  end
  def calculate(:ak2, a) do
    ((a.hu * a.ng)-(a.c2 * a.tg))
     / (a.l0*((a.c2 * a.tg) - (a.c1 * a.tk)))
  end
  def calculate(:ak, a) do
    (a.gv) / (a.l0 * a.gt)
  end
  def calculate(:gtc, a) do
    (a.gt) * 3600
  end
  def calculate(:vg, a) do
    (a.gv * (1 - a.votb)) / (a.kv * (a.p_k / (:math.pow(10, 5))) * a.tk)
  end
  def calculate(:kv2, a) do
    (a.gv * (1 - a.votb)) / (a.vg * (a.p_k / (:math.pow(10, 5))) * a.tk)
  end
  def calculate(:pv, a) do
    (a.p_k / (a.rv*a.tk)) * (:math.pow(1 - (((a.k - 1)/(a.k + 1))*a.yk), (1/(a.k - 1))))
  end
  def calculate(:gvzg, a) do
    (a.azg / a.ak) * a.gv * (1 - a.votb)
  end
  def calculate(:kvzg, a) do
    a.kvzg
  end
  def calculate(:vgzg, a) do
    (a.gvzg) / (a.kvzg * :math.pow((a.p_k / (:math.pow(10, 5))), 1.25) * a.tk)
  end
  def calculate(:gohl, a) do
    (a.gv/100) * 15
  end
  def calculate(:rg, a) do
    a.rv*((1 + 1.0862 * a.qt)/(1+a.qt))
  end
  def calculate(:t, a) do
    a.tg / 1000
  end
  def calculate(:srv1, a) do
    1.04406-0.39193*a.t+1.08845*(:math.pow(a.t, 2))-0.85793*(:math.pow(a.t, 3))+0.29362*(:math.pow(a.t, 4))-0.03747*(:math.pow(a.t, 5))
  end
  def calculate(:srv, a) do
    a.srv1 * 1000
  end
  def calculate(:nn, a) do
    1.80041+0.93518*a.t+0.98923*(:math.pow(a.t, 2))-0.69064*(:math.pow(a.t, 3))+0.1187*(:math.pow(a.t, 4))
  end
  def calculate(:srg, a) do
    ((a.srv1+a.nn*a.qt) * 1000)/(1+a.qt)
  end
  def calculate(:kg, a) do
    (a.srg)/(a.srg - a.rg)
  end
  def calculate(:tzg, a) do
    ((a.azg*a.srv*a.tk)+((1/a.l0)*a.srt*a.tt)+((1/a.l0)*a.qh*a.ng))
    /
    (a.srg*(1/a.l0 + 1) + a.srg*(a.azg-1))
  end
  def calculate(:tzgprov, a) do
    (a.gvzg*a.srv*a.tk + a.gt*a.srt*a.tt + a.gt*a.qh*a.ng)
    /
    ((a.gt+a.gvzg/a.azg)*a.srg + (a.gvzg-a.gvzg/a.azg)*a.srv)
  end
  def calculate(:tg1, a) do
    (
      (a.gt + a.l0*a.gt) * a.srg * a.tzg +
      (a.gt + a.l0*a.gt) * a.srg * a.tzg +
      (a.gv - a.l0*a.gt) * a.srg * a.tzg +
      (a.gv - a.l0*a.gt) * a.srg +
      a.gohl*a.srv*a.tk
    ) / (
      (a.gt + a.l0*a.gt + a.gt + a.l0*a.gt)*a.srg +
      (a.gv - a.l0*a.gt + a.gv - a.l0*a.gt)*a.srv +
      a.gohl*a.srv
    )
  end
  def calculate(:pks, a) do
    a.gt*a.qh*a.ng
  end
  def calculate(:dksr, a) do
    (a.dkn+a.dkvn)/2
  end
  def calculate(:dtsr, a) do
    (a.dtn+a.dtvn)/2
  end
  def calculate(:hk, a) do
    (a.dkn-a.dkvn)/2
  end
  def calculate(:ht, a) do
    (a.dtn-a.dtvn)/2
  end

end
