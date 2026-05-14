defmodule GtdCalcWeb.Formulas do

  def formulas(_a) do
    %{
        :t_v =>
          "T_{\\text{в}} = T_{\\text{ос}} \\cdot \\left( 1 + \\frac{k - 1}{k} \\cdot M^2 \\right)",

        :tk =>
          "T_{\\text{к}} = T_{\\text{в}} \\cdot \\left( 1 + \\frac{Пк^\\frac{k-1}{k}}{ηкомп} \\right)",

        :ng =>
          "ηг = 1 - 0.8 \\cdot Kv^2",

        :wk =>
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

        :tg1 =>
          "Tг1 = \\frac{(Gт+L0 \\cdot Gт) \\cdot Срг \\cdot Tзг + (Gт + L0 \\cdot Gт) \\cdot Срг \\cdot Tзг + (Gв - L0 \\cdot Gт) \\cdot Срг \\cdot Tзг + (Gв - L0 \\cdot Gт) \\cdot Срг + Gохл \\cdot Срв \\cdot Tк}{(Gт+L0 \\cdot Gт+Gт+L0 \\cdot Gт) \\cdot Срг+(Gв-L0 \\cdot Gт+Gв-L0 \\cdot Gт) \\cdot Срв+Gохл \\cdot Срв}",

        :pks =>
          "Pкс = Gт \\cdot Qн \\cdot ηг",

        :dksr =>
          "Dкср = \\frac{Dкн+Dквн}{2}",

        :dtsr =>
          "Dтср = \\frac{Dтн+Dтвн}{2}",

        :hk =>
          "hк = \\frac{Dкн-Dквн}{2}",

        :ht =>
          "hт = \\frac{Dтн-Dтвн}{2}",

        :hz =>
          "hж = \\sqrt{\\frac{2 \\cdot Vж}{π \\cdot (Dкср+Dтср) \\cdot A1}}",

        :hz1 =>
          "hж1 = \\sqrt{\\frac{2 \\cdot Vжзг}{π \\cdot (Dкср+Dтср) \\cdot (A1 - 0.12)}}",

        :lg =>
          "Lж = 4.65 \\cdot hж1",
        :lzg =>
          "Lзг = A2 \\cdot hж1",
        :lzs =>
          "Lзс = Lж-Lзг",
        :ld =>
          "Lд = 3 \\cdot hк",
        :lp =>
          "Lд = A3 \\cdot hж1",
        :dp =>
          "Dр = Dкср + (Dтср - Dкср) \\cdot \\frac{Lд+Lр+hт}{Lкс}",
        :fg =>
          "Fж = π \\cdot Dр \\cdot hж1",

        :vk =>
          "Vк = \\frac{Gв}{ρв}",

        :fk =>
          "Fк = \\frac{π \\cdot Dкн^2}{4} - \\frac{π \\cdot Dквн^2}{4}",
        :fkk =>
          "Fкк = A4 \\cdot Fк",
        :dgn =>
          "dжн = Dр+hж1",
        :dgvn =>
          "dжвн = Dр-hж1",
        :k1 =>
          "K1 = \\frac{dжн^2 - Dр^2}{Dр^2-dжвн^2}",
        :fkkn1 =>
          "Fккн1 = \\frac{dжн^2 - Dр^2}{Dр^2-dжвн^2} \\cdot Fкк",
        :fkkn =>
          "Fккн = \\frac{ \\frac{dжн^2-Dр^2}{Dр^2-dжвн^2} }{2} \\cdot Fкк",
        :fkkvn =>
          "Fкквн = Fкк-Fккн",
        :dkkn =>
          "Dккн = \\sqrt{dжн^2 + \\frac{4 \\cdot Fккн}{π}}",
        :dkkvn =>
          "Dкквн = \\sqrt{dжвн^{2.24} + \\frac{4 \\cdot Fкквн}{π}}",
        :dfr =>
          "Dфр = Dкср + (Dтср-Dкср) \\cdot \\frac{Lд+Lр+hт}{Lкс}",
        :nf1 =>
          "nф1 = \\frac{π \\cdot Dфр}{A5 \\cdot hж1}",
        :nf =>
          "nф = round(nф1)",
        :gf =>
          "Gф = \\frac{Gт}{nф}",
        :dc1 =>
          "dс1 = \\sqrt{\\frac{4 \\cdot Gж}{π \\cdot μ \\cdot \\sqrt{2 \\cdot \\frac{ΔP}{ρт}}}}",
        :lc =>
          "lс = 0.75 \\cdot dс1",
        :lkz =>
          "lкз = \\frac{(Dкз-dс1)}{2 \\cdot tan(\\frac{βк}{2})}",
        :f0 =>
          "f0 = π \\cdot \\frac{dс1^2}{4}",
        :efk =>
          "ΣFк = 4.3 \\cdot f0",
        :lgalpha =>
          "lgα = 0.01 \\cdot βк \\cdot \\left( 5.3 \\cdot \\frac{lс^2}{dс1^2}  \\right) ^{0.58} + 0.32",
        :alpha1 =>
          "α1 = 10^{lgα}",
        :alpha =>
          "α = \\frac{α1 \\cdot 180}{π}",
        :da =>
          "a = \\left( \\frac{ΣFк}{n \\cdot cos(α)}\\right)^{0.5}",
        :b =>
          "b = \\frac{π \\cdot a^2}{4} \\cdot 1000000",
        :dc =>
          "dс = dс1 \\cdot 1000",
        :d =>
          "D = Dкз \\cdot 1000",
        :gc =>
          "Gс = Gф",
        :mf =>
          "mф = \\frac{Gф}{Gс}",
        :fc =>
          "Fс = \\frac{π \\cdot dс^2}{4}",
        :rf =>
          "Rф = D - \\frac{b}{2}",
        :rc =>
          "rс = \\frac{dс}{2}",
        :af =>
          "Aф = \\frac{kф \\cdot π \\cdot Rф \\cdot rс}{n \\cdot b}",
        :af1 =>
          "Aф",
        :affi =>
          "Aф = (1 - φ) \\cdot \\sqrt{\\frac{2}{φ^{3}}}",
        :fi =>
          "φ = Find(φ)",
        :ndif =>
          "nдиф = \\frac{Fвых}{Fк}",
        :ldif =>
          "Lдиф = Lд",
        :opr =>
          "σпр = find(σпр)",
        :fi2 =>
          "ϕ = 10 \\cdot \\left( \\frac{σпр \\cdot deg}{2} \\right) \\cdot  \\sqrt[4]{tan \\left( \\frac{σпр \\cdot deg}{2} \\right) } ",

        :zp =>
          "ζр = ϕ \\cdot \\left( 1 - \\frac{1}{nдиф} \\right) ^2",
        :re =>
          "Re = \\frac{Wк \\cdot 2 \\cdot hк}{vв}",

        :psit =>
          "ζт = \\frac{0.0385}{sin \\left( \\frac{σпр \\cdot deg}{2} \\right)} \\cdot \\frac{1 - \\frac{1}{nдиф^2}}{log(Re - 0.91)^2}",

        :psip =>
          "ζп = (0.43 \\cdot nдиф + 0.02) \\cdot (tan(β \\cdot deg))^{ \\frac{1}{(0.57 \\ cdot nдиф - 0.47)} }",
        :psidif =>
          "ζдиф = ζт+ζр+ζп",
        :deltadif =>
          "δдиф = \\frac{k}{k + 1} \\cdot ζдиф \\cdot λк^2",
        :ndifkr =>
          "nдифкр = 1.65 + 0.1 \\cdot \\frac{Lдиф}{hк}",
        :teta =>
          "θ = \\frac{Tг}{Tк}",
        :dzetatepl =>
          "ζтепл = 0.5 \\cdot  ( θ - 1 ) \\cdot \\left[ \\frac{Fк}{Fж} \\right]  ^ 2",
        :deltatepl =>
          "δтепл = \\frac{k}{k+1} \\cdot ζтепл \\cdot λк ^ 2",
        :deltaotv1 =>
          "δотв1 = δкс - δдиф - δтепл",
        :efotv =>
          "ΣFотв = find(ΣFотв)",
        :formula1 =>
          "\\frac{μ \\cdot ΣFотв}{Fж}",
        :dzetaotv =>
          "ζотв = 0.1 + \\frac{0.6}{ \\left( \\frac{μ \\cdot ΣFотв}{Fкк} \\right) ^{1.5}}",
        :deltaotv =>
          "δотв = \\frac{k}{k + 1} \\cdot ζотв \\cdot λк^2",
        :edelta =>
          "Σδ = δдиф + δтепл + δотв",
        :sigmaks =>
          "σкс = 1-Σδ",
        :deltapdif =>
          "ΔPдиф = Pк - (Pк \\cdot δдиф)",
        :deltaptepl =>
          "ΔPтепл = ΔPдиф - (Pк \\cdot δтепл)",
        :deltapotv =>
          "ΔPотв = ΔPтепл - (Pк \\cdot δотв)",
        :deltape =>
          "ΔPΣ = Pк - ΔPотв",
        :deltapotn =>
          "ΔPотн = \\frac{ΔPΣ}{Pк} \\cdot 100",
        :ffr =>
          "Fфр = \\left( \\frac{αфр}{αк}  \\right) \\cdot ΣFотв",
        :wotv =>
          "Wотв = \\frac{Gв \\cdot ( 1 - βотб )}{ρв \\cdot ΣFотв}",
        :gv =>
          "Gж = \\frac{Gф}{ρт}",
        :wm =>
          "Wm = \\frac{Gв \\cdot Rв \\cdot Tк}{Pк \\cdot Fж}",
        :wpz =>
          "Wпз = \\frac{Gв \\cdot 1.5 \\cdot Rв \\cdot Tк \\cdot μ}{Pк \\cdot Fж}",
        :wkk =>
          "Wкк = \\frac{Gв \\cdot Rв \\cdot Tк \\cdot (1 - Fфр)}{Pк \\cdot Fж \\cdot (1 - μ)}",
        :delptapdif1 =>
          "ΔPдиф1 = Pк \\cdot δдиф",
        :delta_p_obt_zun =>
          "ΔPобт\\_зун = ξобт\\_зун \\cdot \\frac{Pк \\cdot Wкк^2}{2 \\cdot Rв \\cdot Tк}",
        :delta_p_obt_zuvn =>
          "ΔPобт\\_зувн = ξобт\\_зувн \\cdot \\frac{Pк \\cdot Wкк^2}{2 \\cdot Rг \\cdot Tзг}",
        :ksi_pov =>
          "ξпов = 0.73 \\cdot fα \\cdot fRd",
        :delta_p_pov =>
          "ΔPпов = ξпов \\cdot \\frac{Pк \\cdot Wкк^2}{2 \\cdot Rв \\cdot Tк}",
        :gfr =>
          "Gфр = Gохл",
        :nox =>
          "nox = \\frac{Gохл}{Gфр}",
        :mox =>
          "mox = \\frac{Wкк}{Wотв}",
        :delta_p_ohl =>
          "ΔPохл = \\left| \\frac{ρв \\cdot Wотв^{2}}{2} \\cdot (nox^{2} + 2 \\cdot nox - 2 \\cdot nox \\cdot mox) \\right|",
        :gzs =>
          "Gзс = 0.1 \\cdot Gв",
        :nsm =>
          "Nсм = \\frac{Gзс}{Gфр + Gохл \\cdot 8}",
        :delta_p_sm =>
          "ΔPсм = \\left| \\frac{ρв \\cdot Wотв^{2}}{2} \\cdot \\left( nсм^{2} + 2 \\cdot nсм - 2 \\cdot nсм \\cdot mox \\right) \\right|",
        :delta_p_otv1 =>
          "ΔPотв1 = Pк \\cdot δотв",
        :r_evkk =>
          "Reвкк = \\frac{Gв \\cdot hж}{ρв \\cdot vв \\cdot (Fж - Fкквн) }",
        :l_uch =>
          "Lуч = \\frac{2 \\cdot Lж}{10}",
        :h_kk =>
          "hкк = \\frac{Dккн - dжн}{2}",
        :dzeta_tr_34 =>
          "ζтр3–4 = 0.0334 \\cdot Reвкк^(-0.2) \\cdot \\frac{Lуч}{hкк}",
        :delta_p_tr_34 =>
          "ΔPтр3–4 = ζтр3–4 \\cdot \\frac{ρв \\cdot Wкк^{2}}{2}",
        :dzeta_tr_45 =>
          "ζтр4–5 = 0.0334 \\cdot Reвкк^{-0.2} \\cdot \\frac{Lуч}{hкк}",
        :delta_p_tr_45 =>
          "ΔPтр4–5 = ζтр4–5 \\cdot \\frac{ρв \\cdot Wкк^{2}}{2}",
        :dzeta_tr_56 =>
          "ζтр5–6 = 0.0334 \\cdot Reвкк^{-0.2} \\cdot \\frac{2 \\cdot Lуч}{hкк}",
        :delta_p_tr_56 =>
          "ΔPтр5–6 = ζтр3–4 \\cdot \\frac{ρв \\cdot Wкк^{2}}{2}",
        :dzeta_tr_67 =>
          "ζтр6–7 = 0.0334 \\cdot Reвкк^{-0.2} \\cdot \\frac{Lуч}{hкк}",
        :delta_p_tr_67 =>
          "ΔPтр6–7 = ζтр3-4 \\cdot \\frac{ρв \\cdot Wкк^{2}}{2}",
        :dzeta_tr_78 =>
          "ζтр7–8 = 0.0334 \\cdot Reвкк^{-0.2} \\cdot \\frac{Lуч}{hкк}",
        :delta_p_tr_78 =>
          "ΔPтр7–8 = ζтр3-4 \\cdot \\frac{ρв \\cdot Wкк^{2}}{2}",
        :dzeta_tr_89 =>
          "ζтр8–9 = 0.0334 \\cdot Reвкк^{-0.2} \\cdot \\frac{2 \\cdot Lуч}{hкк}",
        :delta_p_tr_89 =>
          "ΔPтр8–9 = ζтр3-4 \\cdot \\frac{ρв \\cdot Wкк^{2}}{2}",
        :dzeta_tr_910 =>
          "ζтр9–10 = 0.0334 \\cdot Reвкк^{-0.2} \\cdot \\frac{Lуч}{hкк}",
        :delta_p_tr_910 =>
          "ΔPтр9–10 = ζтр3-4 \\cdot \\frac{ρв \\cdot Wкк^{2}}{2}",
        :dzeta_tr_1011 =>
          "ζтр10–11 = 0.0334 \\cdot Reвкк^{-0.2} \\cdot \\frac{Lуч}{hкк}",
        :delta_p_tr_1011 =>
          "ΔPтр10–11 = ζтр3-4 \\cdot \\frac{ρв \\cdot Wкк^{2}}{2}",
        :dzeta_tr_1112 =>
          "ζтр11–12 = 0.0334 \\cdot Reвкк^{-0.2} \\cdot \\frac{2 \\cdot Lуч}{hкк}",
        :delta_p_tr_1112 =>
          "ΔPтр11–12 = ζтр3-4 \\cdot \\frac{ρв \\cdot Wкк^{2}}{2}",
        :delta_p_ks =>
          "ΔPкс = ΔPдиф1 + ΔPобт\\_зун + ΔPобт\\_зувн + ΔPпов + ΔPохл + ΔPотв1 + ΔPсм + ΔPтр3–4 + ΔPтр4–5 + ΔPтр5–6 + ΔPтр6–7 + ΔPтр7–8 + ΔPтр8–9 + ΔPтр9–10 + ΔPтр10–11 + ΔPтр11–12",
        :delta_p_ks_100 =>
          "ΔPкс_{100} = \\frac{ΔPкс}{Pк} \\cdot 100",
        :ef_ozg =>
          "ΣFозг = \\left( \\frac{αзг}{αк} \\right) \\cdot ΣFотв",
        :f_ozg =>
          "Fозг = ΣFозг - Fфр",
        :fnozg =>
          "Fнозг = \\frac{K1 \\cdot Fозг}{0.98 + K1}",
        :fvnozg =>
          "Fвнозг = Fозг - Fнозг",
        :dnozg1 =>
          "dнозг1 = \\sqrt{\\frac{24 \\cdot Fнозг}{\\pi \\cdot nозг}}",
        :dvnozg1 =>
          "dвнозг1 = \\sqrt{\\frac{1.6 \\cdot Fвнозг}{\\pi \\cdot nозг}}",
        :f_zg1 =>
          "Fзг1 = Fозг \\cdot 0.535",
        :f_zg2 =>
          "Fзг2 = Fозг - Fзг1",
        :fohl =>
          "Fохл = Gохл",
        :foohl =>
          "Fоохл = Gохл \\cdot ΣFотв",
        :fozs =>
          "Fозс = ΣFотв - Fфр - Fозг - Fоохл",
        :nozg =>
          "nозг = 6 \\cdot nф \\cdot zзг",
        :nozs =>
          "nозс = 3.85 \\cdot nф \\cdot zзс",
        :dnozg2 =>
          "dнозг2 = dвнозг1",
        :dvnozg2 =>
          "dвнозг2 = dнозг1",
        :fnozs =>
          "Fнозс = 0.9 \\cdot Fозс",
        :fvnozs =>
          "Fвнозс = 0.1 \\cdot Fозс",
        :dnozs =>
          "dнозс = \\sqrt{\\frac{10.5 \\cdot Fозс}{\\pi \\cdot nозс}}",
        :dvnozs =>
          "dвнозс = \\sqrt{\\frac{0.65 \\cdot Fозс}{\\pi \\cdot nозс}}",
        :pg =>
          "Pг = Pк \\cdot σкс",
        :dee =>
          "dее = dнозс",
        :ro_g =>
          "ρг = \\frac{Pг}{Rг \\cdot Tг}",
        :b2 =>
          "B = Find(B)",
        :botn =>
          "Bотн = \\frac{B}{hж}",
        :lrc =>
          "Lгс = 1.25 \\cdot hж",
        :lopz1 =>
          "Lопз1 = 0.8 \\cdot hж",
        :loopz =>
          "Lопз = 0.3 \\cdot hж",
        :lozs =>
          "Lозс = 0.8 \\cdot hж",
        :dd =>
          "Dd = 0.8 \\cdot dкз",
        :fkz =>
          "Fкз = \\frac{π \\cdot Dкз^2}{4}",
        :fc1 =>
          "Fс1 = \\frac{Fкз \\cdot 0.22}{mп}",
        :efc =>
          "ΣFс = Fс1 \\cdot mп \\cdot nф",
        :fc2 =>
          "Fс2 = \\frac{Fс1 \\cdot mп}{Fкз}",
        :dtdc =>
          "Dc = 2 \\cdot \\sqrt{\\frac{Fс1}{π}}",
        :u1 =>
          "u1 = \\frac{Rп \\cdot Tв}{Pб}",
        :pkr =>
          "Pкр = βкр \\cdot Pб",
        :vkr =>
          "Vкр = υ1 \\cdot \\left( \\frac{Pб}{Pкр} \\right)^{\\frac{1}{k}}",
        :omega_kr =>
          "ωкр = \\sqrt{2 \\cdot \\frac{k}{k + 1} \\cdot Rп \\cdot Tв}",
        :fsf =>
          "Fсф = \\frac{Gф \\cdot υкр}{ωкр}",
        :u2 =>
          "u2 = υ1 \\cdot \\left( \\frac{Pб}{Pк} \\right)^{\\frac{1}{k}}",
        :omega =>
          "ω = \\sqrt{2 \\cdot \\frac{k}{k - 1} \\cdot Pб \\cdot υ1 \\cdot \\left[1 - \\left( \\frac{Pк}{Pб} \\right)^{\\frac{k - 1}{k}} \\right]}",
        :fsfvih =>
          "Fсфвых = \\frac{Gф \\cdot u2}{ω}",
        :dvih =>
          "dв = \\sqrt{\\frac{Fсфвых}{\\frac{π}{4}}}",
        :nuvzg =>
          "Nuвзг = 0.021 \\cdot Re ^ {0.8} \\cdot Prnзг ^ {0.43} \\cdot \\left( \\frac{Prnзг}{Prст} \\right) ^ {0.25}",
        :alphakzg =>
          "αкзг = \\frac{Nuвзг \\cdot λвзг}{dжвн}",
        :nuvkk =>
          "Nuвкк = 0.021 \\cdot Reвкк ^ {0.8} \\cdot Prnзг ^ {0.43} \\cdot \\left( \\frac{Prnзг}{Prст} \\right) ^ {0.25}",
        :akohl =>
          "αохл = \\frac{Nuвкк \\cdot λвзг}{dжвн}",
        :lv =>
          "lв = 0.6 \\cdot Dр",
        :csigma =>
          "Cσ = 5.67 \\cdot 10 ^ {-8} \\frac{Вт}{м^2 \\cdot К^4}",
        :epsilon_g =>
          "εг = 1 - exp \\left[ -290 \\cdot Pк \\cdot Lсвт \\cdot ( 0.0653 \\cdot αзг \\cdot lв ) ^{0.5} \\cdot Tг \\right]",
        :tw1 =>
          "T_{w1} \\text{ — численное решение системы (Mathcad Given/Find)}",
        :tw2 =>
          "T_{w2} \\text{ — численное решение системы (Mathcad Given/Find)}",
        :wall_c1 =>
          "C_1 = \\alpha_{\\text{кзг}} \\cdot G_{\\text{в}} \\cdot (T_{\\text{зг}} - T_{w1})",
        :wall_c2 =>
          "C_2 = \\alpha_{\\text{кохл}} \\cdot G_{\\text{охл}} \\cdot (T_{w2} - T_{\\text{к}})",
        :wall_r1 =>
          "R_1 = \\left| 0.5 \\cdot \\sigma \\cdot (1 + 0.7) \\cdot \\varepsilon_{\\Gamma} \\cdot T_{\\Gamma}^{1.5} \\cdot \\left( T_{\\Gamma}^{2.5} - T_{w1}^{2.5} \\right) \\right|",
        :wall_r2 =>
          "R_2 = \\left[ \\frac{0.7 \\cdot 0.1}{0.1 + 0.7 \\cdot (1 - 0.1) \\cdot \\left( \\frac{D_{\\text{р}}}{D_{\\text{кср}}} \\right)} \\right] \\cdot \\sigma \\cdot (T_{w2}^4 - T_{\\text{к}}^4)",
        :wall_k12 =>
          "K_{12} = \\frac{26}{\\delta_{\\text{тепл}}} \\cdot (T_{w1} - T_{w2})"
      }
  end

  @doc """
  Две строки системы для Tw1, Tw2 (как в Mathcad Given): только LaTeX в `\\[ … \\]`,
  без подстановки численного результата — для вывода рядом с остальными формулами.
  """
  def wall_tw_system_latex do
    eq1 =
      "\\left[ 0.5 \\cdot \\sigma \\cdot (1 + 0.7) \\cdot \\varepsilon_{\\Gamma} \\cdot T_{\\Gamma}^{1.5} \\cdot \\left( T_{\\Gamma}^{2.5} - T_{w1}^{2.5} \\right) \\right] + \\left[ \\alpha_{\\text{кзг}} \\cdot G_{\\text{в}} \\cdot (T_{\\text{зг}} - T_{w1}) \\right] = \\frac{26}{\\delta_{\\text{тепл}}} \\cdot (T_{w1} - T_{w2})"

    eq2 =
      "\\left[ \\frac{0.7 \\cdot 0.1}{0.1 + 0.7 \\cdot (1 - 0.1) \\cdot \\left( \\frac{D_{\\text{р}}}{D_{\\text{кср}}} \\right)} \\cdot \\sigma \\cdot (T_{w2}^4 - T_{\\text{к}}^4) \\right] + \\left[ \\alpha_{\\text{кохл}} \\cdot G_{\\text{охл}} \\cdot (T_{w2} - T_{\\text{к}}) \\right] = \\frac{26}{\\delta_{\\text{тепл}}} \\cdot (T_{w1} - T_{w2})"

    "\\[" <> eq1 <> "\\]<br><br>\\[" <> eq2 <> "\\]"
  end

  def get(key, a) do
    formula = formulas(a)[key] || "?"
    result = a[key]
    "\\[ #{formula} = #{result} \\]"
  end
end
