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

  def calculate(:wk, a) do
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
    (a.gw) / (a.l0 * a.gt)
  end
  def calculate(:gtc, a) do
    (a.gt) * 3600
  end
  def calculate(:vg, a) do
    (a.gw * (1 - a.votb)) / (a.kv * (a.p_k / (:math.pow(10, 5))) * a.tk)
  end
  def calculate(:kv2, a) do
    (a.gw * (1 - a.votb)) / (a.vg * (a.p_k / (:math.pow(10, 5))) * a.tk)
  end
  def calculate(:pv, a) do
    (a.p_k / (a.rv*a.tk)) * (:math.pow(1 - (((a.k - 1)/(a.k + 1))*a.yk), (1/(a.k - 1))))
  end
  def calculate(:gvzg, a) do
    (a.azg / a.ak) * a.gw * (1 - a.votb)
  end
  def calculate(:kvzg, a) do
    a.kvzg
  end
  def calculate(:vgzg, a) do
    (a.gvzg) / (a.kvzg * :math.pow((a.p_k / (:math.pow(10, 5))), 1.25) * a.tk)
  end
  def calculate(:gohl, a) do
    (a.gw/100) * 15
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
      (a.gw - a.l0*a.gt) * a.srg * a.tzg +
      (a.gw - a.l0*a.gt) * a.srg +
      a.gohl*a.srv*a.tk
    ) / (
      (a.gt + a.l0*a.gt + a.gt + a.l0*a.gt)*a.srg +
      (a.gw - a.l0*a.gt + a.gw - a.l0*a.gt)*a.srv +
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
  def calculate(:hz, a) do
    :math.sqrt(
      (2 * a.vg)
      /
      (:math.pi() * (a.dksr + a.dtsr) * (a.a1))
    )
  end
  def calculate(:hz1, a) do
    :math.sqrt(
      (2 * a.vgzg)
      /
      (:math.pi() * (a.dksr + a.dtsr) * (a.a1 - 0.12))
    )
  end
  def calculate(:lg, a) do
    (4.65 * a.hz1)
  end
  def calculate(:lzg, a) do
    (a.a2 * a.hz1)
  end
  def calculate(:lzs, a) do
    (a.lg - a.lzg)
  end
  def calculate(:ld, a) do
    (3.0 * a.hk)
  end
  def calculate(:lp, a) do
    (a.a3 * a.hz1)
  end
  def calculate(:dp, a) do
    a.dksr +
    (a.dtsr - a.dksr) * (
      (a.ld + a.lp + a.ht)
      /
      (a.lks)
    )
  end
  def calculate(:fg, a) do
    :math.pi() * a.dp * a.hz1
  end
  def calculate(:vk, a) do
    a.gw / a.pv
  end
  def calculate(:fk, a) do

    x1 = (
      ((:math.pi() * :math.pow(a.dkn, 2)) / 4)
    )

    x2 = (
      ((:math.pi() * :math.pow(a.dkvn, 2)) / 4)
    )

    x1 - x2
  end
  def calculate(:fkk, a) do
    a.a4 * a.fk
  end

  def calculate(:dgn, a) do
    a.dp + a.hz1
  end
  def calculate(:dgvn, a) do
    a.dp - a.hz1
  end
  def calculate(:fkkn1, a) do
    (
      (:math.pow(a.dgn, 2) -:math.pow(a.dp, 2))
      /
      (:math.pow(a.dp, 2) -:math.pow(a.dgvn, 2))
    ) * a.fkk
  end
  def calculate(:fkkn, a) do
    (
      (:math.pow(a.dgn, 2) -:math.pow(a.dp, 2))
      /
      (:math.pow(a.dp, 2) -:math.pow(a.dgvn, 2))
      /
      2
    ) * a.fkk
  end
  def calculate(:fkkvn, a) do
    a.fkk - a.fkkn
  end
  def calculate(:dkkn, a) do
    :math.sqrt(
      :math.pow(a.dgn, 2) + (4*a.fkkn/:math.pi)
    )
  end
  def calculate(:dkkvn, a) do
    :math.sqrt(
      :math.pow(a.dgvn, 2.24) + (4*a.fkkvn/:math.pi)
    )
  end
  def calculate(:dfr, a) do
    a.dksr + (a.dtsr - a.dksr) * (
      (a.ld + a.lp + a.ht)
      /
      (a.lks)
    )
  end
  def calculate(:nf1, a) do
    (:math.pi() * a.dfr)
    /
    (a.a5 * a.hz1)
  end
  def calculate(:nf, a) do
    round(a.nf1)
  end
  def calculate(:gf, a) do
    a.gt / a.nf2
  end
  def calculate(:gv, a) do
    a.gf / a.rt
  end
  def calculate(:dc1, a) do
    :math.sqrt(
      (4 * a.gv)
      /
      (
        (:math.pi() * a.u) * :math.sqrt(
          2 * (a.deltap / a.rt)
        )
      )
    )
  end
  def calculate(:lc, a) do
    a.dc1 * 0.75
  end
  def calculate(:lkz, a) do
    (a.dkz - a.dc1) /
    (2 * :math.tan(a.bk / 2))
  end
  def calculate(:f0, a) do
    :math.pi() * (a.dc1*a.dc1/4)
  end
  def calculate(:efk, a) do
    a.f0*4.3
  end
  def calculate(:lgalpha, a) do
    0.01 * a.bk * :math.pow((
      5.3 * ((a.lc*a.lc)/(a.dc1*a.dc1))
    ), 0.58) + 0.32
  end
  def calculate(:alpha1, a) do
    :math.pow(10, a.lgalpha)
  end
  def calculate(:alpha, a) do
    a.alpha1 * 180 / :math.pi()
  end
  def calculate(:da, a) do
    :math.pow((
      (a.efk)
      /
      (a.n * :math.cos(a.alpha))
    ), 0.5)
  end
  def calculate(:b, a) do
    ((:math.pi() * a.da * a.da)
    /
    (4)) * 1000000
  end
  def calculate(:dc, a) do
    a.dc1 * 1000
  end
  def calculate(:d, a) do
    a.dkz * 1000
  end
  def calculate(:gc, a) do
    a.gf
  end
  def calculate(:mf, a) do
    a.gf / a.gc
  end
  def calculate(:fc, a) do
    ((:math.pi() * a.dc * a.dc)
    /
    (4))
  end
  def calculate(:rf, a) do
    a.d - ((a.b)
    /
    (2))
  end
  def calculate(:rc, a) do
    a.dc
    /
    (2)
  end
  def calculate(:af, a) do
    (a.kf * :math.pi() * a.rf * a.rc)
    /
    (a.n * a.b)
  end
  def calculate(:af1, a) do
    0.85
  end
  def calculate(:affi, a) do
    a.af1
  end
  def calculate(:fi, a) do
    0
  end
  def calculate(:ndif, a) do
    a.fvih / a.fk
  end
  def calculate(:ldif, a) do
    a.ld
  end
  def calculate(:deg, a) do
    0.01745329251994
  end
  def calculate(:opr, a) do
    # a.ndif
    # a.deg
    2*:math.atan(
      (a.hk*(:math.sqrt(a.ndif) - 1))
      /
      (a.ldif)
    ) /
    (a.deg)
  end
  def calculate(:fi2, a) do
    10 * :math.tan(
      (a.opr*a.deg) / 2
    )
    *
    :math.pow(
      :math.tan(
        (a.opr*a.deg) / 2
      ), 1/4
    )
  end
  def calculate(:zp, a) do
    a.fi2 * :math.pow(
      1 - (
        1 / a.ndif
      ),
      2
    )
  end
  def calculate(:re, a) do
    (a.wk * 2 * a.hk) / (a.vb)
  end
  def calculate(:psit, a) do
    (
      (0.0385) /
      :math.sin((a.opr * a.deg) / 2)
    )
    *
    (
      (1 - (1 / (:math.pow(a.ndif, 2)))) /
      :math.pow(:math.log10(a.re - 0.91), 2)
    )
  end
  def calculate(:psip, a) do
    (0.43*a.ndif + 0.02) *
    (
      :math.pow(
        (:math.tan(a.beta*a.deg)),
        (
          1 / (
            0.57 * a.ndif - 0.47
          )
        )
      )
    )
  end
  def calculate(:psidif, a) do
    a.psit + a.zp + a.psip
  end
  def calculate(:deltadif, a) do
    (a.k/(a.k + 1)) * a.psidif * (:math.pow(a.yk, 2))
  end
  def calculate(:ndifkr, a) do
    1.65 + 0.1 * ( a.ldif / a.hk)
  end
  def calculate(:teta, a) do
    a.tg / a.tk
  end
  def calculate(:dzetatepl, a) do
    0.5 * (a.teta - 1) * :math.pow((a.fk / a.fg), 2)
  end
  def calculate(:deltatepl, a) do
    (a.k / (a.k + 1)) * a.dzetatepl * :math.pow(a.yk, 2)
  end
  def calculate(:deltaotv1, a) do
    a.deltaks - a.deltadif - a.deltatepl
  end
  def calculate(:efotv, a) do
    # a.fkk
    sq = :math.sqrt(
      :math.pow((
        (0.6 * :math.pow(a.yk, 2) * a.k)/
        ((a.deltaotv1 * (a.k + 1)) - (0.1 * :math.pow(a.yk, 2) * a.k))
      ), 3)
    )

    (a.fkk * sq) / a.uzt
  end
  def calculate(:formula1, a) do
    (a.uzt * a.efotv) / a.fg
  end
  def calculate(:dzetaotv, a) do
    0.1 +
    (
      (0.6)/
      (:math.pow((
        (a.uzt * a.efotv) / a.fkk
      ), 1.5))
    )
  end
  def calculate(:deltaotv, a) do
    (a.k / (a.k + 1)) * a.dzetaotv * :math.pow(a.yk, 2)
  end
  def calculate(:edelta, a) do
    a.deltadif + a.deltatepl + a.deltaotv
  end
  def calculate(:sigmaks, a) do
    1-a.edelta
  end
  def calculate(:deltapdif, a) do
    a.p_k - (a.p_k * a.deltadif)
  end
  def calculate(:deltaptepl, a) do
    a.deltapdif - (a.p_k * a.deltatepl)
  end
  def calculate(:deltapotv, a) do
    a.deltaptepl - (a.p_k * a.deltaotv)
  end
  def calculate(:deltape, a) do
    a.p_k - a.deltapotv
  end
  def calculate(:deltapotn, a) do
    a.deltape/a.p_k * 100
  end
  def calculate(:ffr, a) do
    (a.alphafr / a.ak) * a.efotv
  end
  def calculate(:wotv, a) do
    (a.gw * (1 - a.votb))
    /
    (a.pv * a.efotv)
  end
  def calculate(:wm, a) do
    (a.gw * a.rv * a.tk)
    /
    (a.p_k * a.fg)
  end
  def calculate(:wpz, a) do
    (a.gw * 1.5 * a.rv * a.tk * a.uzt)
    /
    (a.p_k * a.fg)
  end
  def calculate(:wkk, a) do
    (a.gw * a.rv * a.tk * (1 - a.ffr))
    /
    (a.p_k * a.fg * (1 - a.uzt))
  end
  def calculate(:labels1, a) do
    Jason.encode!(Enum.to_list(1..5))
  end
  def calculate(:values1, a) do
    Jason.encode!([%{
        label: "ΔPк",
        data: [a.p_k, a.deltapdif, a.deltaptepl, a.deltapotv, a.deltapotv]
    }])
  end

  def calculate(:labels2, a) do
    Jason.encode!([0.3, 0.5, 0.7, 0.9, 1.1, 1.3, 1.5])
  end
  def calculate(:values2, a) do
    Jason.encode!([0.84, 0.86, 1.02, 1.2, 1.4, 1.6, 1.9])
  end
  def calculate(:datasets1, a) do
    Jason.encode!([%{
        label: "ΔPк",
        data: [a.p_k, a.deltapdif, a.deltaptepl, a.deltapotv, a.deltapotv]
    }])
  end
  def calculate(:datasets2, a) do
    Jason.encode!([
      %{
        label: "1",
        data: [0.84, 0.86, 1.02, 1.2, 1.4, 1.6, 1.9]
      },
      %{
        label: "2",
        data: [0.68, 0.69, 0.82, 0.99, 1.19, 1.4, 1.7]
      },
      %{
        label: "3",
        data: [0.6, 0.58, 0.62, 0.8, 1.0, 1.19, 1.4]
      },
      %{
        label: "4",
        data: [0.49, 0.49, 0.50, 0.56, 0.64, 0.8, 1.04]
      },
      %{
        label: "5",
        data: [0.44, 0.38, 0.36, 0.4, 0.48, 0.58, 0.69]
      },
      %{
        label: "6",
        data: [0.41, 0.36, 0.34, 0.36, 0.4, 0.48, 0.56]
      },
    ])
  end

  def calculate(_, a) do
    nil
  end
end
