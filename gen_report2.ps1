$ErrorActionPreference='Stop'
function F($n){ ('{0:#,0}' -f [double]$n).Replace(',','.') }
function Norm($s){ ($s -replace '[áÁ]','a' -replace '[éÉ]','e' -replace '[íÍ]','i' -replace '[óÓ]','o' -replace '[úÚ]','u' -replace '[ñ]','n').ToLower().Trim() }

$base = @'
Corrientes|951577|374376|279152|66638|14621|4762|3426|2481|3296|39.34|29.34
Misiones|1006530|380783|287777|55469|22372|4539|3671|3216|3739|37.83|28.59
Santa Fe|2843532|1031807|726623|227015|48929|9481|8578|4044|7137|36.29|25.55
San Luis|429717|152069|108224|28676|8393|2089|1611|1392|1684|35.39|25.18
Santa Cruz|272016|95495|67761|11132|5491|6666|2105|815|1525|35.11|24.91
Chaco|1013558|348109|261302|63227|14105|2906|1703|2257|2609|34.35|25.78
Cordoba|3118556|1063172|746739|224610|51665|15106|8902|8324|7826|34.09|23.95
Formosa|491527|156517|109495|33587|6706|2686|1280|1343|1420|31.84|22.28
Salta|1117052|355147|250165|65044|19232|11345|2992|3405|2964|31.79|22.40
La Pampa|304686|95850|61040|21827|4974|4728|1575|746|960|31.46|20.03
Catamarca|347281|107842|77889|20943|4192|2389|914|475|1040|31.05|22.43
Buenos Aires|13315485|4116043|2858634|843949|229632|63112|47222|34840|38654|30.91|21.47
La Rioja|310142|93096|67515|17061|3755|1584|626|1797|758|30.02|21.77
Rio Negro|611518|183286|122798|34770|10708|8816|3014|985|2195|29.97|20.08
Capital Federal|2516630|748963|462946|229950|28476|4864|10210|5668|6849|29.76|18.40
Chubut|485047|144170|86158|30315|9508|11264|2929|1200|2796|29.72|17.76
Mendoza|1523708|452545|278723|117774|32076|11952|4852|3473|3695|29.70|18.29
Tierra del Fuego|153120|44913|30659|4466|2792|4889|1103|483|521|29.33|20.02
Jujuy|602374|176384|125003|30470|10146|6707|1792|621|1645|29.28|20.75
Entre Rios|1155365|335038|213721|86209|16445|6778|4721|3947|3217|29.00|18.50
San Juan|620808|173816|116646|39770|9811|3491|1128|1515|1455|28.00|18.79
Santiago del Estero|826322|212886|144147|53146|7784|3273|975|2421|1140|25.76|17.44
Neuquen|581426|143414|86298|24403|11970|12098|4349|2083|2213|24.67|14.84
Tucuman|1341516|271764|172456|75854|12102|5162|1864|2408|1918|20.26|12.86
'@ -split "`n" | Where-Object { $_.Trim() }

$sexRaw = @'
Buenos Aires|1254340|1604087
Capital Federal|212849|250003
Catamarca|33497|44389
Chaco|110000|151296
Chubut|36185|49957
Corrientes|119263|159881
Cordoba|331549|415154
Entre Rios|91241|122470
Formosa|45980|63512
Jujuy|51955|73046
La Pampa|25613|35422
La Rioja|28777|38737
Mendoza|119281|159427
Misiones|125866|161905
Neuquen|33593|52687
Rio Negro|51440|71350
Salta|104146|146007
San Juan|49632|67013
San Luis|47149|61068
Santa Cruz|28904|38855
Santa Fe|332414|394180
Santiago del Estero|54320|89827
Tierra del Fuego|13433|17221
Tucuman|70191|102257
'@ -split "`n" | Where-Object { $_.Trim() }
$sex=@{}; foreach($l in $sexRaw){ $x=$l.Split('|'); $sex[(Norm $x[0])]=@($x[1],$x[2]) }

$locRaw = @'
Buenos Aires|61 - LA MATANZA~232801~1056850~22.0||50 - GENERAL PUEYRREDON~136373~575289~23.7||77 - MERLO~109535~434337~25.2||63 - LA PLATA~106764~576276~18.5||70 - LOMAS DE ZAMORA~101209~518823~19.5||3 - ALMIRANTE BROWN~99976~460722~21.7
Capital Federal|1 - COMUNA 1~43973~177801~24.7||14 - COMUNA 14~40636~205470~19.8||4 - COMUNA 4~38887~180967~21.5||13 - COMUNA 13~38160~216504~17.6||8 - COMUNA 8~34262~147446~23.2||3 - COMUNA 3~31767~154064~20.6
Catamarca|1 - CAPITAL~33802~145527~23.2||8 - VALLE VIEJO~7170~28547~25.1||13 - BELEN~6450~24894~25.9||16 - SANTA MARIA~4697~21716~21.6||15 - TINOGASTA~4652~20006~23.3||3 - LA PAZ~4195~21265~19.7
Chaco|1 - SAN FERNANDO~82558~368671~22.4||13 - COMANDANTE FERNANDEZ~24088~89371~27.0||25 - GENERAL GUEMES~23776~76571~31.1||11 - MAYOR LUIS J. FONTANA~15218~53899~28.2||8 - LIBERTADOR GRAL. SAN MARTIN~12421~56296~22.1||24 - ALMIRANTE BROWN~10399~33186~31.3
Chubut|15 - ESCALANTE~28845~172291~16.7||1 - RAWSON~21252~121843~17.4||2 - BIEDMA~13411~80794~16.6||6 - FUTALEUFU~8159~43127~18.9||5 - CUSHAMEN~5383~25478~21.1||14 - SARMIENTO~2345~11284~20.8
Corrientes|1 - CAPITAL~80515~313467~25.7||2 - GOYA~23606~81527~29.0||19 - ITUZAINGO~18267~45127~40.5||7 - SANTO TOME~17917~55585~32.2||8 - PASO DE LOS LIBRES~15255~48436~31.5||4 - MERCEDES~14530~38919~37.3
Cordoba|1 - CAPITAL~264308~1135924~23.3||3 - COLON~63983~264655~24.2||13 - RIO CUARTO~56227~225761~24.9||12 - PUNILLA~51270~196735~26.1||20 - SAN JUSTO~44344~193090~23.0||21 - SANTA MARIA~32540~126329~25.8
Entre Rios|1 - PARANA~57585~320959~17.9||13 - CONCORDIA~29964~151302~19.8||9 - URUGUAY~17139~93727~18.3||10 - GUALEGUAYCHU~14563~104279~14.0||3 - LA PAZ~13510~61188~22.1||15 - COLON~11346~60841~18.6
Formosa|1 - FORMOSA~43950~214219~20.5||3 - PILCOMAYO~19075~79054~24.1||6 - PATINO~15429~65279~23.6||4 - PIRANE~13650~57090~23.9||5 - PILAGAS~4398~17182~25.6||7 - BERMEJO~3506~14090~24.9
Jujuy|1 - DR. MANUEL BELGRANO~47020~232575~20.2||4 - EL CARMEN~17126~87286~19.6||7 - LEDESMA~16339~70031~23.3||5 - SAN PEDRO~13879~66656~20.8||2 - PALPALA~8843~50479~17.5||15 - YAVI~4280~18641~23.0
La Pampa|2 - CAPITAL~18400~97356~18.9||15 - MARACO~9700~55864~17.4||20 - TOAY~3511~16043~21.9||22 - UTRACAN~3188~14413~22.1||19 - REALICO~3106~15413~20.2||18 - RANCUL~2608~9720~26.8
La Rioja|1 - CAPITAL~33452~167866~19.9||6 - CHILECITO~11569~44942~25.7||4 - ARAUCO~4022~13310~30.2||17 - ROSARIO VERA PENALOZA~3706~14062~26.4||12 - CHAMICAL~3432~12935~26.5||14 - GENERAL BELGRANO~1965~6746~29.1
Mendoza|3 - GUAYMALLEN~44752~241410~18.5||4 - LAS HERAS~35146~171441~20.5||16 - SAN RAFAEL~28836~156121~18.5||2 - GODOY CRUZ~28426~160324~17.7||6 - MAIPU~27438~158292~17.3||7 - LUJAN DE CUYO~20574~120434~17.1
Misiones|1 - CAPITAL~78281~296906~26.4||8 - OBERA~25596~95005~26.9||16 - IGUAZU~25500~80477~31.7||13 - GUARANI~23476~62939~37.3||14 - ELDORADO~19334~70826~27.3||10 - CAINGUAS~14741~47688~30.9
Neuquen|1 - CONFLUENCIA~51980~379628~13.7||15 - LACAR~6750~34825~19.4||4 - PEHUENCHES~5061~23902~21.2||3 - ANELO~4987~18386~27.1||2 - ZAPALA~4021~35750~11.2||16 - LOS LAGOS~3373~14405~23.4
Rio Negro|12 - GENERAL ROCA~53414~301928~17.7||9 - BARILOCHE~30709~134461~22.8||1 - ADOLFO ALSINA~12151~59089~20.6||3 - SAN ANTONIO~7257~30429~23.8||11 - AVELLANEDA~7044~32497~21.7||6 - 25 DE MAYO~3190~12889~24.7
Salta|1 - CAPITAL~82809~460646~18.0||7 - ORAN~37538~125533~29.9||8 - SAN MARTIN~36717~143299~25.6||5 - ANTA~17953~53596~33.5||4 - METAN~9629~36764~26.2||6 - RIVADAVIA~9444~30683~30.8
San Juan|6 - RAWSON~20236~102405~19.8||1 - CAPITAL~15219~93652~16.3||3 - CHIMBAS~15120~74874~20.2||4 - RIVADAVIA~13797~76726~18.0||12 - POCITO~11021~51587~21.4||2 - SANTA LUCIA~8010~45923~17.4
San Luis|1 - JUAN MARTIN DE PUEYRREDON~49105~201517~24.4||3 - PEDERNERA~29680~118961~24.9||6 - JUNIN~9671~34949~27.7||4 - CHACABUCO~5482~21458~25.5||7 - AYACUCHO~4794~19067~25.1||9 - DUPUY~4111~11320~36.3
Santa Cruz|1 - DESEADO~27266~102073~26.7||7 - GUER AIKE~23361~108628~21.5||6 - LAGO ARGENTINO~6799~23790~28.6||3 - MAGALLANES~3207~10626~30.2||2 - LAGO BUENOS AIRES~3206~10747~29.8||5 - CORPEN AIKE~2800~11734~23.9
Santa Fe|13 - ROSARIO~264592~1060760~24.9||1 - LA CAPITAL~125129~461618~27.1||9 - GENERAL OBLIGADO~44662~154888~28.8||16 - GENERAL LOPEZ~41726~167787~24.9||19 - SAN LORENZO~38635~161228~24.0||5 - CASTELLANOS~38177~151659~25.2
Santiago del Estero|1 - CAPITAL~40064~261368~15.3||6 - BANDA~24475~136059~18.0||22 - RIO HONDO~8612~52524~16.4||27 - TABOADA~7540~37562~20.1||21 - ROBLES~7535~42378~17.8||16 - MORENO~7046~30606~23.0
Tierra del Fuego|1 - USHUAIA~14725~68403~21.5||2 - RIO GRANDE~14475~78386~18.5||5 - TOLHUIN~1410~6088~23.2||3 - ANTARTIDA~49~239~20.5
Tucuman|1 - CAPITAL~66274~464926~14.3||12 - CRUZ ALTA~20394~178524~11.4||16 - TAFI VIEJO~17490~129557~13.5||15 - YERBA BUENA~10931~80821~13.5||2 - LULES~7327~59535~12.3||5 - CHICLIGASTA~7176~71706~10.0
'@ -split "`n" | Where-Object { $_.Trim() }
$loc=@{}; foreach($l in $locRaw){ $i=$l.IndexOf('|'); $loc[(Norm $l.Substring(0,$i))]=$l.Substring($i+1) }

$ageRaw = @'
Buenos Aires|230341|611013|914569|881784|477541|335036|643509
Capital Federal|28593|59855|119813|163041|110047|83472|197437
Catamarca|4207|16359|24813|23453|13712|9874|15381
Chaco|14152|57297|82970|73471|42460|30566|47135
Chubut|9559|20987|31122|29663|16987|12911|22861
Corrientes|14690|58080|87525|82948|48426|33392|48496
Cordoba|51815|143706|233170|232395|136184|96948|170722
Entre Rios|16504|47555|70357|63832|37806|33955|66104
Formosa|6742|25449|35031|29999|18452|15608|25034
Jujuy|10177|28808|42640|38818|19590|13413|22926
La Pampa|4991|15871|20803|18273|10806|8415|16676
La Rioja|3777|13889|21888|20460|11918|8781|12059
Mendoza|32152|52481|90561|91950|50778|46320|88121
Misiones|22440|70809|94613|78898|44245|30740|38601
Neuquen|12028|20323|33483|31986|16402|11204|18793
Rio Negro|10765|27031|42389|40710|21278|14411|26556
Salta|19300|56138|84090|75929|41781|28625|48174
San Juan|9856|25424|37667|35421|19652|16335|29299
San Luis|8436|24299|33009|32354|19433|13900|20728
Santa Cruz|5520|16768|23948|22575|12287|6851|7711
Santa Fe|49053|148836|221897|221309|123457|97635|168630
Santiago del Estero|7816|29961|44866|41253|26294|20820|41719
Tierra del Fuego|2800|7375|11363|10144|6734|3793|2822
Tucuman|12170|31656|53513|53264|33017|28621|60104
'@ -split "`n" | Where-Object { $_.Trim() }
$age=@{}; foreach($l in $ageRaw){ $x=$l.Split('|'); $age[(Norm $x[0])]=$x[1..7] }

$ageLabels=@('16-17','18-24','25-34','35-49','50-64','65-74','75+')
# nacional age x sexo
$natF=@(286721,732802,1057711,1001031,623328,546850,1128008)
$natM=@(317423,881383,1399599,1393770,736265,454963,717340)

# ===== orden alfabetico =====
$prov = $base | Sort-Object { $_.Split('|')[0] }

# ===== national ranking list (alfabetico, valores dentro de las barras) =====
$maxAus=42.0
$rankRows=''
$r=0
foreach($row in $prov){ $r++
  $c=$row.Split('|'); $nm=$c[0]; $tau=[double]$c[10]
  $infA=[double]$c[3]+[double]$c[7]+[double]$c[8]+[double]$c[9]
  $tin=[math]::Round(100*$infA/[double]$c[1],1)
  $wa=[math]::Round(100*$tau/$maxAus,1); $wi=[math]::Round(100*$tin/$maxAus,1)
  $tauC=$tau.ToString('0.0').Replace('.',','); $tinC=$tin.ToString('0.0').Replace('.',',')
  $rankRows+="<div class='rl-row'><div class='rl-name'><span class='rl-rk'>$('{0:D2}' -f $r)</span>$nm</div><div class='rl-track'><div class='rl-aus' style='width:$wa%'><span>$tauC%</span></div><div class='rl-inf' style='width:$wi%'><span>$tinC%</span></div></div></div>`n"
}

# ===== comparacion 2023 vs 2025 =====
$cmp23raw = @'
Buenos Aires|13060464|2585561|1641772
Capital Federal|2528274|573227|322017
Catamarca|340167|75938|52685
Chaco|1001729|260475|190047
Chubut|474233|116015|73071
Cordoba|3062222|696231|454411
Corrientes|933653|195208|131449
Entre Rios|1143017|237649|139573
Formosa|482567|111465|75071
Jujuy|590854|122188|80691
La Pampa|300150|63395|35922
La Rioja|304440|56972|39606
Mendoza|1492190|331027|187295
Misiones|988432|229582|162366
Neuquen|553731|105575|59407
Rio Negro|595062|128550|81544
Salta|1090033|256426|174269
San Juan|608514|162015|109985
San Luis|421349|86052|55274
Santa Cruz|265328|71981|49870
Santa Fe|2814471|708999|463207
Santiago del Estero|812030|163509|105311
Tierra del Fuego|148020|37456|23845
Tucuman|1320412|220122|133419
'@ -split "`n" | Where-Object { $_.Trim() }
$cmp23=@{}; foreach($l in $cmp23raw){ $x=$l.Split('|'); $cmp23[(Norm $x[0])]=@($x[1],$x[2],$x[3]) }
$balraw = @'
Buenos Aires|3506730
Capital Federal|609657
Catamarca|95595
Chaco|262590
Chubut|122748
Cordoba|729413
Corrientes|213508
Entre Rios|246835
Formosa|117047
Jujuy|133964
La Pampa|69905
La Rioja|62376
Mendoza|340887
Misiones|256232
Neuquen|112209
Rio Negro|139000
Salta|264891
San Juan|120284
San Luis|91512
Santa Cruz|78868
Santa Fe|677698
Santiago del Estero|169309
Tierra del Fuego|37985
Tucuman|220741
'@ -split "`n" | Where-Object { $_.Trim() }
$bal=@{}; foreach($l in $balraw){ $x=$l.Split('|'); $bal[(Norm $x[0])]=$x[1] }
$cmpScale=42.0
$cmpRows=''
foreach($row in $prov){
  $c=$row.Split('|'); $nm=$c[0]; $k=Norm $nm
  $au25=[double]$c[2]; $pad25=[double]$c[1]; $t25=[math]::Round(100*$au25/$pad25,1)
  $p23=[double]$cmp23[$k][0]; $a23=[double]$cmp23[$k][1]; $t23=[math]::Round(100*$a23/$p23,1)
  $ab=[double]$bal[$k]; $tb=[math]::Round(100*$ab/$p23,1)
  $d=[math]::Round($t25-$t23,1)
  $w23=[math]::Round(100*$t23/$cmpScale,1); $w25=[math]::Round(100*$t25/$cmpScale,1); $wb=[math]::Round(100*$tb/$cmpScale,1)
  $t23s=$t23.ToString('0.0').Replace('.',','); $t25s=$t25.ToString('0.0').Replace('.',','); $tbs=$tb.ToString('0.0').Replace('.',','); $ds=('+'+$d.ToString('0.0')).Replace('.',',')
  $cmpRows+="<div class='cmp-row'><div class='cmp-name'>$nm</div><div class='cmp-bars'><div class='cmp-b cmp-23' style='width:$w23%'><span>$t23s% gen&middot;23</span></div><div class='cmp-b cmp-bal' style='width:$wb%'><span>$tbs% bal&middot;23</span></div><div class='cmp-b cmp-25' style='width:$w25%'><span>$t25s% &middot;25</span></div></div><div class='cmp-d'>$ds</div></div>`n"
}

# ===== totales 4 anios por provincia (cod distrito: nombre|aus2017|aus2019 PASO) =====
$h1719raw = @'
Capital Federal|629446|590846
Buenos Aires|2662066|2553278
Catamarca|92574|79815
Cordoba|853627|800967
Corrientes|232186|229608
Chaco|282132|245947
Chubut|117657|118824
Entre Rios|249322|257038
Formosa|126628|126787
Jujuy|136804|141268
La Pampa|73007|70856
La Rioja|93900|88226
Mendoza|296960|292781
Misiones|239822|244341
Neuquen|101975|101122
Rio Negro|145436|132581
Salta|302940|279518
San Juan|121466|121376
San Luis|84783|97673
Santa Cruz|70572|72305
Santa Fe|759569|713120
Santiago del Estero|180928|187455
Tucuman|250761|279885
Tierra del Fuego|34042|37743
'@ -split "`n" | Where-Object { $_.Trim() }
$h17=@{}; $h19=@{}; foreach($l in $h1719raw){ $x=$l.Split('|'); $h17[(Norm $x[0])]=$x[1]; $h19[(Norm $x[0])]=$x[2] }
$elecRaw = @'
Capital Federal|2555160
Buenos Aires|12242708
Catamarca|310961
Cordoba|2884358
Corrientes|845295
Chaco|912052
Chubut|435077
Entre Rios|1076866
Formosa|443275
Jujuy|537701
La Pampa|282012
La Rioja|279753
Mendoza|1407748
Misiones|894679
Neuquen|488354
Rio Negro|536983
Salta|991239
San Juan|554228
San Luis|376897
Santa Cruz|248302
Santa Fe|2715363
Santiago del Estero|735373
Tucuman|1217207
Tierra del Fuego|132924
'@ -split "`n" | Where-Object { $_.Trim() }
$elec=@{}; foreach($l in $elecRaw){ $x=$l.Split('|'); $elec[(Norm $x[0])]=$x[1] }
function TC($t,$n){ "<td class='tc'><b>$($t.ToString('0.0').Replace('.',','))%</b><span>$(F $n)</span></td>" }
$totRows=''; $s17=0;$s19=0;$s23=0;$s25=0;$e19=0;$p23s=0;$p25s=0
foreach($row in $prov){
  $c=$row.Split('|'); $nm=$c[0]; $k=Norm $nm
  $a17=[double]$h17[$k]; $a19=[double]$h19[$k]; $a23=[double]$cmp23[$k][1]; $a25=[double]$c[2]
  $el=[double]$elec[$k]; $p23=[double]$cmp23[$k][0]; $p25=[double]$c[1]
  $t17=[math]::Round(100*$a17/$el,1); $t19=[math]::Round(100*$a19/$el,1); $t23=[math]::Round(100*$a23/$p23,1); $t25=[math]::Round(100*$a25/$p25,1)
  $s17+=$a17;$s19+=$a19;$s23+=$a23;$s25+=$a25;$e19+=$el;$p23s+=$p23;$p25s+=$p25
  $totRows+="<tr><td class='lt-d'>$nm</td>$(TC $t17 $a17)$(TC $t19 $a19)$(TC $t23 $a23)$(TC $t25 $a25)</tr>`n"
}
$T17=[math]::Round(100*$s17/$e19,1);$T19=[math]::Round(100*$s19/$e19,1);$T23=[math]::Round(100*$s23/$p23s,1);$T25=[math]::Round(100*$s25/$p25s,1)
$totNat="<tr class='tot'><td>TOTAL PAIS</td>$(TC $T17 $s17)$(TC $T19 $s19)$(TC $T23 $s23)$(TC $T25 $s25)</tr>"

# ===== comparacion edad 2023 vs 2025 =====
$age25aus=@(604166,1614346,2457547,2394935,1359613,1001813,1845349)
$age23aus=@(472470,1033037,1546733,1438899,847241,757564,1613811)
$aMax=2457547.0
$ageCmpRows=''
for($i=0;$i -lt 7;$i++){
  $a23=$age23aus[$i]; $a25=$age25aus[$i]
  $w23=[math]::Round(100*$a23/$aMax,1); $w25=[math]::Round(100*$a25/$aMax,1)
  $g=[math]::Round(100*($a25-$a23)/$a23,0)
  $m23=('{0:0.00}' -f ($a23/1e6)).Replace('.',','); $m25=('{0:0.00}' -f ($a25/1e6)).Replace('.',',')
  $ageCmpRows+="<div class='cmp-row'><div class='cmp-name'>$($ageLabels[$i]) anios</div><div class='cmp-bars'><div class='cmp-b cmp-23' style='width:$w23%'><span>$m23 M &middot;23</span></div><div class='cmp-b cmp-25' style='width:$w25%'><span>$m25 M &middot;25</span></div></div><div class='cmp-d'>+$g%</div></div>`n"
}

# ===== national age pyramid =====
$pyMax=1399599.0
$pyRows=''
for($i=0;$i -lt 7;$i++){
  $f=$natF[$i];$m=$natM[$i]; $wf=[math]::Round(100*$f/$pyMax,1);$wm=[math]::Round(100*$m/$pyMax,1)
  $opt = if($i -eq 0 -or $i -eq 6){' opt'}else{''}
  $pyRows+="<div class='py-row$opt'><div class='py-fnum'>$(F $f)</div><div class='py-f'><div style='width:$wf%'></div></div><div class='py-lab'>$($ageLabels[$i])</div><div class='py-m'><div style='width:$wm%'></div></div><div class='py-mnum'>$(F $m)</div></div>`n"
}

# ===== province cards =====
$cards=''
$rank=0
foreach($row in $prov){ $rank++
  $c=$row.Split('|'); $nm=$c[0]; $k=Norm $nm
  $pad=[double]$c[1];$au=[double]$c[2];$e70=[double]$c[4];$e18=[double]$c[5];$jus=[double]$c[6];$tau=$c[10]
  $inf=[double]$c[3]+[double]$c[7]+[double]$c[8]+[double]$c[9]
  $ex=$e70+$e18
  $tin=([math]::Round(100*$inf/$pad,1)).ToString('0.0')
  $ip=[math]::Round(100*$inf/$au,1);$ep=[math]::Round(100*$ex/$au,1);$op=[math]::Round(100*$jus/$au,1)
  $sf=[double]$sex[$k][0];$sm=[double]$sex[$k][1]; $sfp=[math]::Round(100*$sf/($sf+$sm),1); $smp=[math]::Round(100-$sfp,1)
  $sev = if([double]$tau -ge 35){'var(--c-infractor)'}elseif([double]$tau -ge 30){'oklch(0.58 0.15 45)'}elseif([double]$tau -ge 25){'oklch(0.64 0.13 75)'}else{'oklch(0.55 0.1 150)'}
  $ag=$age[$k]; $agMax=0; foreach($v in $ag){ if([double]$v -gt $agMax){$agMax=[double]$v} }
  $agTot=0; foreach($v in $ag){ $agTot+=[double]$v }
  $ageRows=''
  for($i=0;$i -lt 7;$i++){ $v=[double]$ag[$i]; $w=[math]::Round(100*$v/$agMax,0); $pct=[math]::Round(100*$v/$agTot,1)
    $oc = if($i -eq 0 -or $i -eq 6){'opt'}else{''}
    $ageRows+="<div class='ar $oc'><div class='ar-l'>$($ageLabels[$i])</div><div class='ar-t'><div style='width:$w%'></div></div><div class='ar-n'>$(F $v)<i>$($pct.ToString('0.0').Replace('.',','))%</i></div></div>"
  }
  $locStr=$loc[$k]; $locRows=''; $li=0
  foreach($e in $locStr.Split('||',[StringSplitOptions]::RemoveEmptyEntries)){
    $li++; $ff=$e.Split('~'); if($ff.Count -lt 4){continue}
    $locRows+="<tr><td class='lt-r'>$li</td><td class='lt-d'>$($ff[0])</td><td class='lt-n'>$(F $ff[1])</td><td class='lt-n'>$(F $ff[2])</td><td class='lt-t'>$($ff[3].Replace('.',','))%</td></tr>"
  }
  $tauC=$tau.Replace('.',','); $tinC=$tin.Replace('.',',')
  $cards += @"
<article class='prov'>
<header class='prov-h'><span class='prov-rk'>$('{0:D2}' -f $rank)</span><h3>$nm</h3><div class='prov-tasa'><b style='color:$sev'>$tauC%</b><span>ausentismo</span></div></header>
<div class='prov-fig'><div><b>$(F $pad)</b><span>padron</span></div><div><b>$(F $au)</b><span>ausentes</span></div><div><b style='color:var(--c-infractor)'>$(F $inf)</b><span>infractores</span></div><div><b>$tinC%</b><span>tasa infraccion</span></div></div>
<div class='cap'>Composicion de los ausentes</div>
<div class='comp'><div class='comp-i' style='width:$ip%'>$ip%</div><div class='comp-e' style='width:$ep%'>$ep%</div><div class='comp-o' style='width:$op%'></div></div>
<div class='comp-leg'><span><i class='sw-i'></i>Infractores</span><span><i class='sw-e'></i>Exentos por edad</span><span><i class='sw-o'></i>Justificados</span></div>
<div class='prov-grid'>
<div><div class='cap'>Distribucion por edad</div>$ageRows<div class='cap' style='margin-top:.7rem'>Sexo de los infractores</div><div class='sexbar'><div class='sx-f' style='width:$sfp%'>F $($sfp.ToString('0.0').Replace('.',','))%</div><div class='sx-m' style='width:$smp%'>M $($smp.ToString('0.0').Replace('.',','))%</div></div></div>
<div><div class='cap'>Departamentos por infractores</div><table class='lt'><thead><tr><th></th><th>Departamento</th><th>Infr.</th><th>Padron</th><th>Tasa</th></tr></thead><tbody>$locRows</tbody></table></div>
</div></article>
"@
}

# ===== mapas de burbujas (centroides del CSV, electores 2019) =====
$geoRaw = @'
01|-34.601921|-58.376331|2555160
02|-36.241136|-59.639952|12242708
03|-27.192943|-67.149874|310961
04|-32.226689|-63.516306|2884358
05|-28.691440|-57.739265|845295
06|-26.046333|-60.081004|912052
07|-43.332814|-70.040479|435077
08|-32.414237|-59.227207|1076866
09|-25.056673|-59.840459|443275
10|-23.201506|-65.579939|537701
11|-38.272990|-65.796044|282012
12|-29.165848|-68.122363|279753
13|-33.951613|-69.661330|1407748
14|-26.606812|-54.317642|894679
15|-38.464658|-70.218505|488354
16|-39.969667|-67.630678|536983
17|-24.088887|-65.448094|991239
18|-30.607279|-69.148577|554228
19|-33.719461|-66.438239|376897
20|-48.328755|-71.151541|248302
21|-31.587177|-60.585437|2715363
22|-28.315045|-63.920535|735373
23|-26.845180|-65.404711|1217207
24|-54.5|-67.8|132924
'@ -split "`n" | Where-Object { $_.Trim() }
$code2name=@{'01'='Capital Federal';'02'='Buenos Aires';'03'='Catamarca';'04'='Cordoba';'05'='Corrientes';'06'='Chaco';'07'='Chubut';'08'='Entre Rios';'09'='Formosa';'10'='Jujuy';'11'='La Pampa';'12'='La Rioja';'13'='Mendoza';'14'='Misiones';'15'='Neuquen';'16'='Rio Negro';'17'='Salta';'18'='San Juan';'19'='San Luis';'20'='Santa Cruz';'21'='Santa Fe';'22'='Santiago del Estero';'23'='Tucuman';'24'='Tierra del Fuego'}
$geo=@{}; foreach($l in $geoRaw){ $x=$l.Split('|'); $geo[$x[0]]=@([double]$x[1],[double]$x[2],[double]$x[3]) }
$b25=@{}; foreach($row in $base){ $c=$row.Split('|'); $b25[(Norm $c[0])]=@([double]$c[1],[double]$c[2]) }
# rates por codigo
$rG=@{};$rB=@{};$r5=@{};$r9=@{}
foreach($code in $code2name.Keys){
  $nm=$code2name[$code]; $k=Norm $nm
  $pad23=[double]$cmp23[$k][0]; $a23=[double]$cmp23[$k][1]; $ab=[double]$bal[$k]; $elec=[double]$geo[$code][2]
  $rG[$code]=[math]::Round(100*$a23/$pad23,1)
  $rB[$code]=[math]::Round(100*$ab/$pad23,1)
  $r5[$code]=[math]::Round(100*$b25[$k][1]/$b25[$k][0],1)
  $a19=[double]$h19[$k]; $r9[$code]=[math]::Round(100*$a19/$elec,1)
}
function ColorFor($v){ if($v -lt 15){'oklch(0.93 0.025 60)'}elseif($v -lt 20){'oklch(0.86 0.055 52)'}elseif($v -lt 25){'oklch(0.79 0.09 46)'}elseif($v -lt 30){'oklch(0.71 0.125 40)'}elseif($v -lt 35){'oklch(0.63 0.15 35)'}else{'oklch(0.55 0.17 32)'} }
$lonMin=-73.5;$lonMax=-53.4;$latMin=-55.2;$latMax=-21.5;$MW=170.0;$MH=378.0;$pd=14.0
$sqmin=[math]::Sqrt(132924);$sqmax=[math]::Sqrt(12242708)
function BuildMap($rates){
  $svg="<svg viewBox='0 0 170 378' class='map' role='img' xmlns='http://www.w3.org/2000/svg'>"
  foreach($code in ($code2name.Keys | Sort-Object)){
    $lat=$geo[$code][0];$lon=$geo[$code][1];$elec=$geo[$code][2];$v=$rates[$code]
    $x=[math]::Round($pd+($lon-$lonMin)/($lonMax-$lonMin)*($MW-2*$pd),1)
    $y=[math]::Round($pd+($latMax-$lat)/($latMax-$latMin)*($MH-2*$pd),1)
    $r=[math]::Round(4+([math]::Sqrt($elec)-$sqmin)/($sqmax-$sqmin)*11,1)
    $col=ColorFor $v
    $svg+="<circle cx='$x' cy='$y' r='$r' fill='$col' stroke='oklch(0.3 0.02 60 / .35)' stroke-width='.5'><title>$($code2name[$code]): $($v.ToString('0.0').Replace('.',','))%</title></circle>"
  }
  $svg+"</svg>"
}
$mapG=BuildMap $rG; $mapB=BuildMap $rB; $map5=BuildMap $r5; $map9=BuildMap $r9

# ===== grafico de linea: tendencia nacional 4 periodos =====
$au=@($T17,$T19,$T23,$T25)
$inf=@($null,$null,13.9,22.1)
$xlab=@(@('2017','PASO'),@('2019','PASO'),@('2023','General'),@('2025','Legisl.'))
$lx=@(); for($i=0;$i -lt 4;$i++){ $lx+=[math]::Round(46+$i*116,1) }
function LY($v){ [math]::Round(198-($v/35.0)*172,1) }
$ls="<svg viewBox='0 0 440 244' class='line' role='img' xmlns='http://www.w3.org/2000/svg'>"
foreach($gv in 0,10,20,30){ $gy=LY $gv; $ls+="<line x1='46' x2='418' y1='$gy' y2='$gy' stroke='oklch(0.9 0.008 75)' stroke-width='1'/><text x='40' y='$($gy+3.5)' text-anchor='end' font-size='10' fill='oklch(0.62 0.012 70)'>$gv%</text>" }
$ptsA=''; for($i=0;$i -lt 4;$i++){ $ptsA+="$($lx[$i]),$(LY $au[$i]) " }
$ls+="<polyline points='$($ptsA.Trim())' fill='none' stroke='oklch(0.4 0.02 250)' stroke-width='2.6' stroke-linejoin='round'/>"
for($i=0;$i -lt 4;$i++){ $vy=LY $au[$i]; $vs=$au[$i].ToString('0.0').Replace('.',','); $ls+="<circle cx='$($lx[$i])' cy='$vy' r='4' fill='oklch(0.4 0.02 250)'/><text x='$($lx[$i])' y='$($vy-9)' text-anchor='middle' font-size='11' font-weight='700' fill='oklch(0.4 0.02 250)'>$vs%</text>" }
$ls+="<polyline points='$($lx[2]),$(LY 13.9) $($lx[3]),$(LY 22.1)' fill='none' stroke='oklch(0.56 0.16 32)' stroke-width='2.6' stroke-dasharray='5 3' stroke-linejoin='round'/>"
foreach($p in @(@(2,13.9),@(3,22.1))){ $vy=LY $p[1]; $vs=([double]$p[1]).ToString('0.0').Replace('.',','); $ls+="<circle cx='$($lx[$p[0]])' cy='$vy' r='4' fill='oklch(0.56 0.16 32)'/><text x='$($lx[$p[0]])' y='$($vy+15)' text-anchor='middle' font-size='11' font-weight='700' fill='oklch(0.56 0.16 32)'>$vs%</text>" }
for($i=0;$i -lt 4;$i++){ $ls+="<text x='$($lx[$i])' y='216' text-anchor='middle' font-size='11' font-weight='700' fill='oklch(0.26 0.02 60)'>$($xlab[$i][0])</text><text x='$($lx[$i])' y='230' text-anchor='middle' font-size='9' fill='oklch(0.62 0.012 70)'>$($xlab[$i][1])</text>" }
$lineSvg=$ls+"</svg>"

$html = @"
<!DOCTYPE html><html lang='es'><head><meta charset='utf-8'><meta name='viewport' content='width=device-width,initial-scale=1'>
<title>Ausentismo Electoral 2025 - Argentina</title>
<meta name='description' content='Informe del ausentismo en las elecciones generales 2025 de Argentina: composicion legal, edad, sexo y ranking de departamentos por provincia.'>
<link rel='preconnect' href='https://fonts.googleapis.com'><link rel='preconnect' href='https://fonts.gstatic.com' crossorigin>
<link href='https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,800&family=Inter:wght@400;500;600;700&display=swap' rel='stylesheet'>
<style>
:root{
--paper:oklch(0.99 0.005 85);--paper2:oklch(0.975 0.006 80);--ink:oklch(0.26 0.02 60);--ink2:oklch(0.46 0.015 65);--ink3:oklch(0.62 0.012 70);--rule:oklch(0.9 0.008 75);--rule2:oklch(0.94 0.006 78);
--c-infractor:oklch(0.56 0.16 32);--c-exento:oklch(0.62 0.085 230);--c-justif:oklch(0.74 0.11 78);--c-otros:oklch(0.74 0.02 80);--c-fem:oklch(0.64 0.13 8);--c-masc:oklch(0.56 0.085 245);
--maxw:1040px}
*{box-sizing:border-box;margin:0;padding:0}
html{-webkit-text-size-adjust:100%}
body{font-family:'Inter',system-ui,sans-serif;color:var(--ink);background:var(--paper);line-height:1.6;font-size:clamp(15px,.5vw+14px,17px);-webkit-font-smoothing:antialiased}
.wrap{max-width:var(--maxw);margin:0 auto;padding:0 clamp(16px,4vw,40px) 80px}
.prose{max-width:68ch}
h2{font-family:'Fraunces',serif;font-weight:600;font-size:clamp(1.45rem,3.5vw,2rem);line-height:1.15;margin:3.2rem 0 .3rem;letter-spacing:-.01em}
h2 .h2n{color:var(--c-infractor);font-weight:800;margin-right:.5rem}
.lede{color:var(--ink2);font-size:1.05rem;margin:.2rem 0 1.4rem;max-width:62ch}
p{margin:.9rem 0;max-width:68ch}
b{font-weight:600}
.cap{font-size:.72rem;font-weight:600;letter-spacing:.08em;text-transform:uppercase;color:var(--ink3);margin:.2rem 0 .45rem}
/* cover */
.cover{padding:clamp(3rem,9vw,6rem) 0 2.4rem;border-bottom:1px solid var(--rule)}
.cover .eyebrow{font-size:.78rem;font-weight:700;letter-spacing:.22em;color:var(--c-infractor);text-transform:uppercase}
.cover h1{font-family:'Fraunces',serif;font-weight:800;font-size:clamp(2.6rem,8vw,4.6rem);line-height:.98;letter-spacing:-.025em;margin:.5rem 0 .4rem}
.cover .dek{font-size:clamp(1.05rem,2.4vw,1.3rem);color:var(--ink2);max-width:48ch}
/* key figures band */
.kf{display:grid;grid-template-columns:repeat(4,1fr);gap:0;border:1px solid var(--rule);border-radius:10px;overflow:hidden;margin:2rem 0 .6rem;background:var(--paper2)}
.kf>div{padding:1.1rem 1.2rem;border-right:1px solid var(--rule)}
.kf>div:last-child{border-right:0}
.kf .v{font-family:'Fraunces',serif;font-weight:700;font-size:clamp(1.6rem,4vw,2.3rem);line-height:1}
.kf .k{font-size:.78rem;color:var(--ink2);margin-top:.35rem}
/* definitions */
.defs{display:grid;gap:.6rem;margin:1rem 0}
.def{background:var(--paper2);border:1px solid var(--rule);border-radius:8px;padding:.85rem 1.1rem}
.def b{color:var(--ink)}
.tag{display:inline-block;width:.7rem;height:.7rem;border-radius:2px;margin-right:.4rem;vertical-align:middle}
/* full composition bar */
.bigcomp{display:flex;height:54px;border-radius:8px;overflow:hidden;font-size:.85rem;font-weight:600;color:var(--paper);margin:.6rem 0}
.bigcomp>div{display:flex;align-items:center;justify-content:center;padding:0 .3rem;min-width:0;white-space:nowrap}
.bc-i{background:var(--c-infractor)}.bc-e{background:var(--c-exento)}.bc-o{background:var(--c-otros);color:var(--ink)}
.complegend{display:flex;flex-wrap:wrap;gap:.4rem 1.4rem;margin:.5rem 0 0;font-size:.85rem}
.complegend>div{display:flex;align-items:baseline;gap:.45rem}
.complegend b{font-variant-numeric:tabular-nums}
.complegend small{color:var(--ink3)}
/* ranking list */
.ranklist{margin:1rem 0;display:grid;gap:.34rem}
.rl-head{display:grid;grid-template-columns:minmax(120px,1fr) 2.6fr;gap:.9rem;font-size:.72rem;color:var(--ink3);text-transform:uppercase;letter-spacing:.06em;padding:0 0 .2rem}
.rl-row{display:grid;grid-template-columns:minmax(120px,1fr) 2.6fr;gap:.9rem;align-items:center}
.rl-name{font-weight:500;font-size:.92rem;display:flex;align-items:center;gap:.5rem;min-width:0;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.rl-rk{font-variant-numeric:tabular-nums;color:var(--ink3);font-size:.76rem;flex:none}
.rl-track{position:relative;height:26px;background:var(--rule2);border-radius:5px}
.rl-aus{position:absolute;inset:0 auto 0 0;background:color-mix(in oklch,var(--c-exento) 34%,var(--paper));height:100%;border-radius:5px;display:flex;align-items:center;justify-content:flex-end;padding-right:8px}
.rl-aus>span{font-size:.76rem;font-weight:700;color:var(--ink);font-variant-numeric:tabular-nums}
.rl-inf{position:absolute;inset:0 auto 0 0;background:var(--c-infractor);height:100%;border-radius:5px;display:flex;align-items:center;padding-left:8px}
.rl-inf>span{font-size:.76rem;font-weight:700;color:var(--paper);font-variant-numeric:tabular-nums}
.rl-note{font-size:.82rem;color:var(--ink2);margin-top:.7rem}
.rl-note i{font-style:normal;font-weight:600}
.sw{display:inline-block;width:.7rem;height:.7rem;border-radius:2px;vertical-align:middle;margin-right:.3rem}
/* pyramid */
.pyramid{margin:1rem 0;display:grid;gap:.3rem}
.py-head{display:grid;grid-template-columns:1fr 4fr auto 4fr 1fr;gap:.5rem;align-items:center;font-size:.74rem;color:var(--ink3);margin-bottom:.2rem}
.py-row{display:grid;grid-template-columns:minmax(56px,1fr) 4fr auto 4fr minmax(56px,1fr);gap:.5rem;align-items:center;font-variant-numeric:tabular-nums}
.py-row.opt{opacity:.62}
.py-lab{font-weight:600;font-size:.84rem;text-align:center;white-space:nowrap}
.py-f,.py-m{height:20px}
.py-f{display:flex;justify-content:flex-end}.py-f>div{background:var(--c-fem);height:100%;border-radius:4px 0 0 4px}
.py-m>div{background:var(--c-masc);height:100%;border-radius:0 4px 4px 0}
.py-fnum{text-align:right;font-size:.8rem;color:var(--ink2)}.py-mnum{text-align:left;font-size:.8rem;color:var(--ink2)}
.pylegend{display:flex;gap:1.2rem;font-size:.85rem;margin-top:.5rem}
/* province cards */
.prov{border:1px solid var(--rule);border-radius:12px;padding:clamp(1rem,2.5vw,1.5rem);margin:1rem 0;background:var(--paper);break-inside:avoid}
.prov-h{display:flex;align-items:baseline;gap:.7rem;flex-wrap:wrap;border-bottom:1px solid var(--rule2);padding-bottom:.7rem}
.prov-rk{font-family:'Fraunces',serif;font-weight:800;color:var(--ink3);font-size:1.1rem;font-variant-numeric:tabular-nums}
.prov-h h3{font-family:'Fraunces',serif;font-weight:600;font-size:clamp(1.2rem,3vw,1.5rem)}
.prov-tasa{margin-left:auto;text-align:right;line-height:1.05}
.prov-tasa b{font-family:'Fraunces',serif;font-size:1.5rem}
.prov-tasa span{display:block;font-size:.7rem;color:var(--ink3);text-transform:uppercase;letter-spacing:.06em}
.prov-fig{display:grid;grid-template-columns:repeat(4,1fr);gap:.5rem;margin:.9rem 0 .3rem}
.prov-fig>div{display:flex;flex-direction:column}
.prov-fig b{font-variant-numeric:tabular-nums;font-size:1.05rem}
.prov-fig span{font-size:.72rem;color:var(--ink3)}
.comp{display:flex;height:30px;border-radius:6px;overflow:hidden;font-size:.76rem;font-weight:600;color:var(--paper)}
.comp>div{display:flex;align-items:center;justify-content:center;min-width:0}
.comp-i{background:var(--c-infractor)}.comp-e{background:var(--c-exento)}.comp-o{background:var(--c-otros);color:var(--ink)}
.comp-leg{display:flex;flex-wrap:wrap;gap:.3rem 1rem;font-size:.74rem;color:var(--ink2);margin-top:.35rem}
.comp-leg i{display:inline-block;width:.6rem;height:.6rem;border-radius:2px;margin-right:.3rem;vertical-align:middle}
.sw-i,.comp-leg .sw-i{background:var(--c-infractor)}.sw-e{background:var(--c-exento)}.sw-o{background:var(--c-otros)}
.prov-grid{display:grid;grid-template-columns:1fr 1.15fr;gap:1.4rem;margin-top:1rem}
.ar{display:grid;grid-template-columns:46px 1fr auto;gap:.5rem;align-items:center;margin:.16rem 0;font-size:.8rem;font-variant-numeric:tabular-nums}
.ar.opt{opacity:.6}
.ar-l{color:var(--ink2);white-space:nowrap}
.ar-t{height:12px;background:var(--rule2);border-radius:3px;overflow:hidden}
.ar-t>div{height:100%;background:var(--ink2);border-radius:3px}
.ar-n{text-align:right;white-space:nowrap;color:var(--ink2)}.ar-n i{font-style:normal;color:var(--ink3);margin-left:.3rem}
.sexbar{display:flex;height:24px;border-radius:5px;overflow:hidden;font-size:.76rem;font-weight:600;color:var(--paper)}
.sx-f{background:var(--c-fem);display:flex;align-items:center;justify-content:center}.sx-m{background:var(--c-masc);display:flex;align-items:center;justify-content:center}
.lt{width:100%;border-collapse:collapse;font-size:.8rem;font-variant-numeric:tabular-nums}
.lt th{text-align:left;font-size:.68rem;text-transform:uppercase;letter-spacing:.05em;color:var(--ink3);font-weight:600;padding:.2rem .4rem;border-bottom:1px solid var(--rule)}
.lt th:nth-child(n+3),.lt .lt-n,.lt .lt-t{text-align:right}
.lt td{padding:.28rem .4rem;border-bottom:1px solid var(--rule2)}
.lt .lt-r{color:var(--ink3);width:1.2rem}.lt .lt-d{white-space:nowrap;overflow:hidden;text-overflow:ellipsis;max-width:11rem}.lt .lt-t{font-weight:600;color:var(--c-infractor)}
.foot{margin-top:3rem;padding-top:1rem;border-top:1px solid var(--rule);font-size:.85rem;color:var(--ink2)}
.foot ul{margin:.6rem 0 .6rem 1.1rem}.foot li{margin:.3rem 0}
.src{font-size:.78rem;color:var(--ink3);margin-top:1rem}
.tot-wrap{overflow-x:auto;margin:1rem 0}
.dt.tot-tbl{min-width:560px;border-collapse:collapse}
.dt.tot-tbl th{background:var(--ink);color:var(--paper);padding:.5rem .7rem;text-align:left;font-size:.76rem}
.dt.tot-tbl th:nth-child(n+2){text-align:right}
.dt.tot-tbl td{border-bottom:1px solid var(--rule);padding:.4rem .7rem;font-size:.84rem}
.dt.tot-tbl .tn{text-align:right;font-variant-numeric:tabular-nums}
.dt.tot-tbl .lt-d{white-space:nowrap}
.dt.tot-tbl .tot td{background:var(--paper2);font-weight:700;border-top:2px solid var(--ink)}
.dt.tot-tbl .tc{text-align:right;white-space:nowrap}.dt.tot-tbl .tc b{font-variant-numeric:tabular-nums}.dt.tot-tbl .tc span{display:block;font-size:.71rem;color:var(--ink3);font-variant-numeric:tabular-nums;font-weight:400}
.linewrap{margin:.8rem 0;max-width:580px}.linewrap svg{width:100%;height:auto}
.linelegend{display:flex;gap:1.4rem;font-size:.85rem;margin:.3rem 0 0}
.linelegend i{display:inline-block;width:20px;height:0;border-top:3px solid;vertical-align:middle;margin-right:.4rem}
.linelegend .ll-a{border-color:oklch(0.4 0.02 250)}.linelegend .ll-i{border-top-style:dashed;border-color:var(--c-infractor)}
.maps{display:grid;grid-template-columns:repeat(4,1fr);gap:1rem;margin:1rem 0}
.maps figure{margin:0;text-align:center}.maps svg{width:100%;height:auto;max-height:430px;display:block}
.maps figcaption{font-size:.82rem;font-weight:600;color:var(--ink2);margin-top:.3rem}
.mapleg{display:flex;flex-wrap:wrap;gap:.3rem 1rem;font-size:.78rem;margin:.6rem 0;color:var(--ink2)}
.mapleg span{display:flex;align-items:center;gap:.35rem}.mapleg i{width:.85rem;height:.85rem;border-radius:2px;display:inline-block;border:1px solid oklch(0.85 0.01 70)}
@media(max-width:720px){.maps{grid-template-columns:repeat(2,1fr)}}
.cmp-tbl{max-width:660px}
.dt.cmp-tbl{border-collapse:collapse}.dt.cmp-tbl th{background:var(--ink);color:var(--paper);padding:.5rem .7rem;text-align:left;font-size:.78rem}.dt.cmp-tbl td{border-bottom:1px solid var(--rule);padding:.45rem .7rem;font-variant-numeric:tabular-nums}.dt.cmp-tbl td.up{color:var(--c-infractor);font-weight:700}
.cmp-list{margin:1.1rem 0;display:grid;gap:.45rem}
.cmp-head{display:grid;grid-template-columns:minmax(110px,1fr) 2.6fr auto;gap:.8rem;font-size:.72rem;text-transform:uppercase;letter-spacing:.06em;color:var(--ink3)}
.cmp-row{display:grid;grid-template-columns:minmax(110px,1fr) 2.6fr auto;gap:.8rem;align-items:center}
.cmp-name{font-size:.9rem;font-weight:500;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.cmp-bars{display:grid;gap:3px}
.cmp-b{height:16px;border-radius:4px;display:flex;align-items:center;padding-left:7px}
.cmp-b>span{font-size:.68rem;font-weight:700;white-space:nowrap;font-variant-numeric:tabular-nums}
.cmp-23{background:color-mix(in oklch,var(--c-masc) 55%,var(--paper))}.cmp-23>span{color:var(--ink)}
.cmp-bal{background:var(--c-justif)}.cmp-bal>span{color:var(--ink)}
.cmp-25{background:var(--c-infractor)}.cmp-25>span{color:var(--paper)}
.cmp-d{font-weight:700;color:var(--c-infractor);font-variant-numeric:tabular-nums;font-size:.9rem;text-align:right}
@media(max-width:720px){
.cmp-row,.cmp-head{grid-template-columns:minmax(80px,1fr) 2fr auto;gap:.5rem}.cmp-b>span{font-size:.64rem}
.kf{grid-template-columns:repeat(2,1fr)}.kf>div:nth-child(2){border-right:0}.kf>div:nth-child(1),.kf>div:nth-child(2){border-bottom:1px solid var(--rule)}
.prov-grid{grid-template-columns:1fr}
.rl-row,.rl-head{grid-template-columns:minmax(88px,1fr) 2fr;gap:.5rem}.rl-aus>span,.rl-inf>span{font-size:.7rem}
.prov-fig{grid-template-columns:repeat(2,1fr);gap:.7rem .5rem}
.py-row,.py-head{grid-template-columns:minmax(44px,1fr) 3fr auto 3fr minmax(44px,1fr);gap:.3rem;font-size:.78rem}
.lt .lt-d{max-width:8rem}
}
@media print{body{font-size:11px}.prov{box-shadow:none}.cover{padding-top:0}a{color:inherit}}
</style></head>
<body><div class='wrap'>

<header class='cover'>
<div class='eyebrow'>Informe nacional</div>
<h1>Ausentismo Electoral 2025</h1>
<p class='dek'>Quienes no votaron en las elecciones generales de Argentina, y por que. Padron al 26 de octubre de 2025.</p>
</header>

<div class='kf'>
<div><div class='v'>36,48 M</div><div class='k'>Habilitados (padron)</div></div>
<div><div class='v'>11,29 M</div><div class='k'>Ausentes: 30,9%</div></div>
<div><div class='v'>3,02 M</div><div class='k'>Exentos por edad</div></div>
<div><div class='v' style='color:var(--c-infractor)'>8,06 M</div><div class='k'>Infractores: 22,1%</div></div>
</div>

<p class='prose'>Tres de cada diez habilitados no se presentaron a votar. Pero no todo ausente es infractor: de los 11,29 millones que no votaron, siete de cada diez eran electores obligados sin justificacion (los infractores), mientras que algo mas de un cuarto corresponde a exenciones por edad (menores de 18 y mayores de 70, con voto optativo) y una fraccion menor a ausencias justificadas por ley. Este informe separa esos grupos y los desagrega por provincia, edad, sexo y departamento.</p>

<h2><span class='h2n'>01</span>Como se compone el ausentismo</h2>
<p class='lede'>Los 11.288.010 ausentes, clasificados segun su situacion legal.</p>
<div class='bigcomp'><div class='bc-i' style='width:71.4%'>Infractores 71,4%</div><div class='bc-e' style='width:26.7%'>Exentos 26,7%</div><div class='bc-o' style='width:1.9%'></div></div>
<div class='complegend'>
<div><span class='tag' style='background:var(--c-infractor)'></span><div><b>8.061.870</b> Infractores <small>obligados sin justificacion (incluye pago de multa, CUE anulado y sin clasificar), 22,1% del padron</small></div></div>
<div><span class='tag' style='background:var(--c-exento)'></span><div><b>3.015.385</b> Exentos por edad <small>menores de 18 y mayores de 70</small></div></div>
<div><span class='tag' style='background:var(--c-justif)'></span><div><b>210.755</b> Justificados <small>distancia, salud, laboral, exterior</small></div></div>
</div>

<h2><span class='h2n'>02</span>Edad y sexo</h2>
<p class='lede'>Ausentes por grupo etario. Los extremos (16-17 y 75+) son casi en su totalidad voto optativo.</p>
<div class='pyramid'>
<div class='py-head'><div style='text-align:right'>Mujeres</div><div></div><div>Edad</div><div></div><div>Varones</div></div>
$pyRows
</div>
<div class='pylegend'><span><i class='sw' style='background:var(--c-fem)'></i>Femenino</span><span><i class='sw' style='background:var(--c-masc)'></i>Masculino</span></div>
<p>El ausentismo se concentra en los adultos jovenes y medios: los grupos de 25 a 34 (2,46 M) y de 35 a 49 (2,39 M) anios son los mas numerosos. Hay un sesgo masculino claro en las edades activas y femenino entre los mayores de 65, reflejo de la mayor longevidad de las mujeres.</p>

<h2><span class='h2n'>03</span>Ranking de provincias</h2>
<p class='lede'>Tasa de ausentismo (barra clara) y, dentro de ella, la tasa de infraccion efectiva (barra terracota).</p>
<div class='ranklist'>
<div class='rl-head'><div>Provincia</div><div>Ausentismo (clara) con su infraccion efectiva (terracota)</div></div>
$rankRows
</div>
<p class='rl-note'><span class='sw' style='background:color-mix(in oklch,var(--c-exento) 38%,var(--paper))'></span><i>Ausentismo total</i> &nbsp; <span class='sw' style='background:var(--c-infractor)'></span><i>Infraccion efectiva</i>. El Centro y el Litoral encabezan la ausencia (Corrientes 39,3%, Misiones 37,8%); el NOA la cierra (Tucuman 20,3%, la mayor participacion del pais).</p>

<h2><span class='h2n'>04</span>Como cambio respecto de 2023</h2>
<p class='lede'>Tres turnos consecutivos: la general presidencial y el balotaje de 2023, y la legislativa de medio termino de 2025. El arco mide como el tipo de eleccion mueve la participacion.</p>
<table class='dt cmp-tbl'><thead><tr><th>Indicador</th><th>Generales 2023</th><th>Balotaje 2023</th><th>Legislativas 2025</th></tr></thead><tbody>
<tr><td>Fecha</td><td>22-oct-2023</td><td>19-nov-2023</td><td>26-oct-2025</td></tr>
<tr><td>Ausentismo</td><td>21,2% (7,60 M)</td><td>24,3% (8,68 M)</td><td class='up'>30,9% (11,29 M)</td></tr>
<tr><td>Infraccion (incluye otros)</td><td>13,9% (4,97 M)</td><td>16,7% (5,99 M)</td><td class='up'>22,1% (8,06 M)</td></tr>
<tr><td>Padron habilitado</td><td>35,78 M</td><td>35,78 M</td><td>36,48 M</td></tr>
</tbody></table>
<p>La participacion cayo en cada turno. El balotaje sumo tres puntos de ausentismo sobre la primera vuelta (cansancio de segunda vuelta), y la legislativa de medio termino 2025 marca el piso, casi diez puntos por encima de la general presidencial. El ausentismo crecio en las 24 provincias sin excepcion.</p>
<div class='cmp-list'><div class='cmp-head'><div>Provincia</div><div>Ausentismo: generales y balotaje 2023, y legislativas 2025</div><div>&Delta; gen23&rarr;25</div></div>
$cmpRows
</div>
<p class='rl-note'><span class='sw' style='background:color-mix(in oklch,var(--c-masc) 55%,var(--paper))'></span><i>Gen 2023</i> &nbsp; <span class='sw' style='background:var(--c-justif)'></span><i>Balotaje 2023</i> &nbsp; <span class='sw' style='background:var(--c-infractor)'></span><i>Legislativas 2025</i>. La suba (general 2023 a 2025) fue mayor en el Litoral (Corrientes +18,4, Misiones +14,6) y menor en el NOA (Tucuman +3,6, Santiago del Estero +6,8).</p>

<h3 style="font-family:'Fraunces',serif;font-weight:600;font-size:1.2rem;margin:1.8rem 0 .3rem">Totales de ausentes por provincia, cuatro elecciones</h3>
<p class='lede'>Cantidad de no votantes en cada eleccion. Se excluye 2021 por celebrarse bajo restricciones de la pandemia de COVID-19, que distorsionan la comparacion.</p>
<div class='tot-wrap'><table class='dt tot-tbl'><thead><tr><th>Provincia</th><th>PASO 2017</th><th>PASO 2019</th><th>Generales 2023</th><th>Legislativas 2025</th></tr></thead><tbody>
$totRows
$totNat
</tbody></table></div>
<p class='rl-note'>Cada celda: tasa de ausentismo sobre el padron de ese anio (arriba) y numero de no votantes (abajo). 2017 y 2019 son PASO; 2023 y 2025, generales.</p>

<h3 style="font-family:'Fraunces',serif;font-weight:600;font-size:1.2rem;margin:1.8rem 0 .3rem">Tendencia: ausentismo e infraccion</h3>
<p class='lede'>Evolucion nacional en los cuatro periodos. La infraccion solo se calcula desde 2023: los registros de 2017 y 2019 no traen el motivo de la ausencia.</p>
<div class='linewrap'>$lineSvg</div>
<div class='linelegend'><span><i class='ll-a'></i>Ausentismo</span><span><i class='ll-i'></i>Infraccion (incluye otros)</span></div>

<h3 style="font-family:'Fraunces',serif;font-weight:600;font-size:1.2rem;margin:1.8rem 0 .3rem">Quien dejo de votar: edad y sexo</h3>
<p class='lede'>Ausentes por grupo etario en cada eleccion. La suba no es pareja: se concentra en las edades activas.</p>
<div class='cmp-list'><div class='cmp-head'><div>Edad</div><div>Ausentes: 2023 frente a 2025</div><div>var.</div></div>
$ageCmpRows
</div>
<p class='rl-note'>El salto del ausentismo lo explican los adultos de 25 a 49 anios: cada franja sumo cerca de un millon de ausentes mas que en 2023 (+59% y +66%). Los mayores de 75, casi todos voto optativo, apenas variaron (+14%). El sexo se mantuvo estable: los ausentes fueron 47,1% mujeres en 2023 y 47,7% en 2025. La diferencia entre elecciones la marca la edad, no el genero.</p>

<h2><span class='h2n'>05</span>Provincia por provincia</h2>
<p class='lede'>Cada ficha: composicion legal de los ausentes, distribucion por edad, sexo de los infractores y los departamentos con mas infractores junto a su tasa local. En orden alfabetico.</p>
$cards

<h2><span class='h2n'>06</span>Mapa: evolucion del ausentismo</h2>
<p class='lede'>Tasa de ausentismo por provincia en cuatro elecciones, misma escala de color. El tamano del circulo es proporcional al padron de la provincia.</p>
<div class='mapleg'>
<span><i style='background:oklch(0.93 0.025 60)'></i>&lt;15%</span>
<span><i style='background:oklch(0.86 0.055 52)'></i>15 a 20</span>
<span><i style='background:oklch(0.79 0.09 46)'></i>20 a 25</span>
<span><i style='background:oklch(0.71 0.125 40)'></i>25 a 30</span>
<span><i style='background:oklch(0.63 0.15 35)'></i>30 a 35</span>
<span><i style='background:oklch(0.55 0.17 32)'></i>&ge;35%</span>
</div>
<div class='maps'>
<figure>$map9<figcaption>PASO 2019</figcaption></figure>
<figure>$mapG<figcaption>Generales 2023</figcaption></figure>
<figure>$mapB<figcaption>Balotaje 2023</figcaption></figure>
<figure>$map5<figcaption>Legislativas 2025</figcaption></figure>
</div>
<p class='rl-note'>Posicion segun el centroide de cada provincia. El cursor sobre un circulo muestra provincia y tasa.</p>

<div class='foot'>
<h2 style='font-size:1.2rem;margin-top:1rem'>Fuentes y metodologia</h2>
<ul>
<li><b>Padron:</b> 36.478.349 electores en 25 distritos, sin nulos en campos clave, consistente con las cifras oficiales por distrito.</li>
<li><b>Ausentes:</b> 24 archivos provinciales de no votantes, 11.288.010 registros normalizados (delimitadores ; y tabulacion, variantes de columnas, fechas en formato barra y guion, deduplicacion).</li>
<li><b>Clasificacion legal:</b> diccionarios oficiales t_estados y t_motivos. Infractor: estado con marca infractor. Exento: Art. 18 (mayor de 70 o menor de 18). Justificado: Art. 12/127.</li>
<li><b>Edad:</b> reconstruida desde la fecha de nacimiento, cobertura 99,9% (10.241 sin dato). <b>Localidad:</b> departamento o seccion electoral del padron (135 partidos en Buenos Aires).</li>
<li><b>Cruce DNI ausente contra padron:</b> 99,7%. Quedan 101.310 registros (0,9%) con codigos 2025 aun sin diccionario, agrupados en Otros. Las tasas se calculan sobre el padron total.</li>
</ul>
<p class='src'>Elaborado con datos de la Justicia Nacional Electoral. Base analitica reproducible en BigQuery: cp-electoral.INFRACTORES2025.</p>
</div>

</div></body></html>
"@
$dir="$env:USERPROFILE\ausentismoARG2025"
$html | Set-Content "$dir\index.html" -Encoding UTF8
"BYTES=$((Get-Item "$dir\index.html").Length) CARDS=$rank"
