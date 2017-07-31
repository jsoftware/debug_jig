NB. Version 1.0 for this add on
NB.coerase <'jig' NB. clear previous jig variables, helps in updates
cocurrent'jig' NB. Set the defining locale as jig
require 'gl2'

CSS=: 0 : 0  NB. CSS for the different types and animations of tootips.
<style type="text/css">
 svg {overflow:visible;}
 rect {overflow:visible;}
 text { font-family:"courier"; font-weight:bold; stroke-width:0.75; stroke:black; pointer-events: none; text-anchor:start; white-space:pre;}
 .err  { fill:red; stroke-width:0.7;}
 .verb  { fill:blue; stroke-width:0.4;}
 .adverb  { fill:gold; stroke-width:0.5;}
 .conj  { fill:purple; stroke-width:0.2;}
 .p  { fill:red; stroke-width:0.4;} 
 .l  { fill:gold; font-family:"<FONT>"; font-weight:normal; stroke:none; font-size:0.8em;}
 .u , .v  { fill:black; font-family:"<FONT>"; font-weight:normal; font-size:0.8em;}
 .sy { fill:black; font-family:"<FONT>"; font-weight:normal; stroke:none; font-size:0.8em;}
 .b , .ja , .ea { fill:white; stroke-width:1;} 
 .i  { font-weight:normal; stroke:none;}
 .f  { fill:#44f; stroke-width:0.5;} 
 .e  { fill:#888; stroke-width:0.4;} 
 .r  { fill:black; stroke-width:0.2;} 
 .ra { fill: #ff5577; stroke-width:1;}
 .c  { fill: #004400; font-style: italic; stroke-width:0.2;}
 .s  { fill:white;  font-weight:normal; stroke:white; stroke-width:1; font-size: 1.5em;}
 .sr { stroke:darkred; stroke-width:1;}
 .sl { fill:#f55;}
 .su { fill:#b22;}
 .sv { fill:#600;}
 .d  { fill:#dde; stroke:#aac; stroke-width:1;}
 .j  { fill:#fff;}
 .x  { stroke:black; stroke-width:1.5; rx:0;} 
 .z0 { fill:#bbb;}
 .z1 { fill:#666;}
 .lb { fill:#004225; stroke:gold; height:18;}
 .lc { fill:#008825; stroke:gold; height:18;}
 .syb { fill:white; stroke:red; height:18;}  
 .ub { fill:yellow; stroke:gold; height:18;}
 .u4 { fill:gold; stroke:yellow; height:18;}
 .tt { opacity:0; transition: opacity 0.5s; transition-delay:0.2s; pointer-events:none; overflow:visible;}
 rect.t1 , rect.t2 , rect.t3  { opacity:0.95; fill:lightyellow; stroke:black; pointer-events:none;}
 g.tt text  { font-family:"arial"; stroke:none;}
 rect:hover  {fill:#96C; opacity:1; transition: all 0.1s ease-in-out;}
 rect:hover + .tt { opacity:1;}
</style>
)

DISPLAY=: 0 : 0 NB. Form that contains the display as well as zoom and font buttons
pc enhanced;
bin h;
cc w1 webview;
bin vs;
cc FI static;cn "Font";
maxwh 80 20;cc menlo radiobutton;cn "menlo";set _ tooltip "Set display font to menlo";
maxwh 80 20;cc unifont radiobutton group;cn "unifont";set _ tooltip "Set display font to unifont";
bin s;
cc SI static;cn "Zoom";
maxwh 60 20;cc xs radiobutton;cn "10%";set _ tooltip "Zoom out to 10% size";
maxwh 60 20;cc s radiobutton group;cn "20%";set _ tooltip "Zoom out to 20% size";
maxwh 60 20;cc sm radiobutton group;cn "50%";set _ tooltip "Zoom out to 50% size";
maxwh 60 20;cc m radiobutton group;cn "100%";set _ tooltip "View at original size";
maxwh 60 20;cc ml radiobutton group;cn "200%";set _ tooltip "Zoom in to 200% size";
maxwh 60 20;cc l radiobutton group;cn "300%";set _ tooltip "Zoom in to 300% size";
maxwh 60 20;cc xl radiobutton group;cn "400%";set _ tooltip "Zoom in to 400% size";
bin szz; 
)

SCALE=:1 NB. display zoom
ZM=: 3 NB. index for display zoom
FM=: 0 NB. index for display f0nt
FONT=: >FM{'menlo';'unifont' NB. options to be 0-menlo for looks and 1-unifont for spacing of unprintables

webdisplay=: 4 : 0 NB. Displays the results in webview for jqt environment
wd DISPLAY
wd 'pn *', > {. x
wd 'set w1 wh *', ": 200 170>. (_225 _200 + 2 3 { ". wd 'qscreen') <. SCALE * > {: x
wd 'set w1 html *', y
wd 'set ', (>ZM{'xs';'s';'sm';'m';'ml';'l';'xl'),' value 1;'
wd 'set ', (>FM{'menlo';'unifont'),' value 1;'
wd 'pshow'
wd 'qhwndp;'
)

enhanced_menlo_button=: 3 : 'font 0'
enhanced_unifont_button=: 3 : 'font 1'

font=: 3 : 0
FM=: y [ FONT=: >y{'menlo';'unifont'
vobj=. ". 'handle',wd 'qhwndp;' [ loc=. ". 'locale',wd 'qhwndp;'
loc visual vobj [ enhanced_close ''
)

enhanced_xs_button=: 3 : 'zoom ''xs'''
enhanced_s_button=:3 : 'zoom ''s''' 
enhanced_sm_button=: 3 : 'zoom ''sm'''
enhanced_m_button=: 3 : 'zoom ''m'''
enhanced_ml_button=: 3 : 'zoom ''ml'''
enhanced_l_button=: 3 : 'zoom ''l'''
enhanced_xl_button=: 3 : 'zoom ''xl'''

zoom=: 3 : 0
SCALE=: (ZM { 0.1 0.2 0.5 1 2 3 4) [ZM=:(<y)i.~ 'xs';'s';'sm';'m';'ml';'l';'xl'
vobj=. ". 'handle',wd 'qhwndp;' [ loc=. ". 'locale',wd 'qhwndp;'
loc visual vobj [ enhanced_close ''
)

enhanced_close=: 3 : 'wd ''pclose''[ erase ''handle'',wd ''qhwndp;''[ erase ''locale'',wd ''qhwndp;'''
enhanced_jctrl_fkey=: labs_run_jqtide_ bind 0
htmpack=: 3 :'''<hmtl><head><meta charset="UTF-8">'', (CSS rplc ''<FONT>'';FONT),''</head><body>'', y ,''</body></html>'''
cnv=:,/ @: > @: (8!:0) NB. converts _20 to -20 for svg text and justifies appropriately
sc=: 3 : '((1 >. % SCALE)* ])  y'

visual=: 4 : 0 NB. main verb that collects input, checks for errors then sends for processing, takes these results and wraps them up to be displayed by webdisplay. Retains information on the current window to track multiple displays.
cocurrent > {: x
if. >{. x do. vobj_jig_=. findline_jig_ y else. vobj_jig_=.y end.
if. _1~: t_jig_=. 4!:0 <(vobj_jig_) do. try. t_jig_ =. 4!:0 <'prox_jig_'[ ". 'prox_jig_=. ', vobj_jig_ catch. t=._2 end. end.  
cocurrent 'jig'
 select. t
  case. _2 do. try. ". vobj catch. tm=. 0 vgalt ": >"1 <;. _2 [ 13!:12 '' end.
  case. _1 do. tm=. 0 vgalt  '|value error: ', vobj,'_',(>{:x),'_'
  case.  0 do. tm=. (0;0) vg prox
  case.    do. tm=. t vgalt vobj
 end.
'fW fH'=.   (sc 200 120) + 3 5 {::"0 _ tm
tm=.  ; (3&{. , ":@(3&{::) ; 4&{ , ":@(5&{::) ; {:) tm
tm=.'<svg width="',(": SCALE * fW),'" height="',(": SCALE * fH),'" viewbox="',(cnv sc _180) ,' ',(cnv sc _85),' ', (": fW,fH),'" preserveAspectRatio="xMidYMin meet" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" >',tm,'</svg>'
ID=:":(vobj; fW , fH) webdisplay htmpack tm  
(i.0 0)[('handle',ID)=:vobj [ ('locale',ID)=: 0;>{:x
)

vgalt=: 4 : 0
'<rect class="';'j';'" width="';(10.5+ 9.59 * {: $ ": ": y);'" height="';0;'"></rect>',,'<text class="',"1(x{:: 'err';'adverb';'conj';'verb'),"1'" y="',"1( cnv ,. 20 * i. {. $ ,:^:(2>#@$) y),"1'">',"1 (":y) ,"1 '</text>'
)

vg=: 3 : 0 NB. selects correct parsing depending on type and if empty shape
(0;1) vg y
:
select. >( 0 e. $ y) { (typ=. datatype y);'z'
 case.'z'        do. (typ;{.x) zerosvg y
 case.('sparse boolean';'sparse integer';'sparse floating';'sparse complex') do. typ spsvg y 
 case.'literal'  do.   x litsvg y 
 case.'unicode'  do.   x unisvg y 
 case.'unicode4' do.   x vnisvg y NB.else. vnisvgu y end.
 case.'symbol'   do.   x symsvg y
 case.'boxed'    do.   x bxsvg y  
 case.           do. typ nmsvg y
end.
)

zerosvg=: 4 : 0 NB. empty shapes case for all types
'typ s'=.x
if. s do. 34;32;'<rect class="syb" x="15.5" y="7" width="14.39" rx="2"></rect><g class="tt"><rect class="t1" x="-121" y="-14" width="140" height="24" stroke-width="1" rx="3"></rect><text x="-121" y="3" font-size="12"> UTF-8 : 0</text></g><text class="sy" x="18.5" y="20"> </text>' NB. case for s: 0{a.  which has shape 0
      else.tt=. '<g class="tt"><rect class="t2" x="',a,'" y="',(cnv 2 + sc _48),'" width="',(cnv sc 140),'" height="',(cnv sc 48),'" stroke-width="',(cnv sc 1),'" rx="',(cnv sc 3),'"></rect><text x="',a,'" y="',(cnv sc _28),'" font-size="',(cnv sc 12),'"> Type : ',typ,'<tspan x="',(a=.cnv 2 + sc _140),'" y="',(cnv sc _10),'"> Shape : ',(":$y),'</tspan></text></g>'
           '<rect class="';('z',": * +/ $ y);'" width="';( 6 + (8 * {:)`(0:) @.(0-:{:)$ y);'" height="';(14 + 18 *  */@:}:@:$ y);'" rx="6"></rect>',tt end.
)

nmercal=: 4 : 0
'xc typ'=. x [ yc=. cnv ,. 24 + 17 * i. # vals=.  y   
if. (typer=.('fc'i.typ){'ej ')~:' 'do. vals=.  vals rplc"1 typer ; '<tspan class="', (typer,'a'), '">', typer ,'</tspan>' end.
,'<text x="',"1 xc ,"1'" y="',"1 yc ,"1'" width="9.59" height="18" class="',"1 typ ,"1'" xml:space="preserve">',"1 vals ,"1 '</text>'
)

spsvg=: 4 : 0 NB. sparse types case
sep=.9.59 * {: $ ind=. t {."1 m  [ v=.(t + 1)}."1 m [ t=.(1 I.~ =&(25{a.)){. m=.":  y 
tb=. '<rect class="j" x="7" y="9" width="',(": sep),'" height="',(": 2 + 17 * # m),'" rx="6"></rect>'
tt=.'<g class="tt"><rect class="t2" x="',a,'" y="',(cnv 11 + sc _48),'" width="',(cnv sc 140),'" height="',(cnv sc 48),'" stroke-width="',(cnv sc 1),'" rx="',(cnv sc 3),'"></rect><text x="',a,'" y="',(cnv 9 + sc _30),'" font-size="',(cnv sc 12),'"> Sparse ',(;(1<#2 $. y){'Index : ';'Indices : '),(": 2$.y),'<tspan x="',(a=.cnv 7 + sc _138),'" dy="1.5em"> Array Shape : ', (": $ y),'</tspan></text></g>'
tm=. tb,tt,((": 11.5 );'i') nmercal  ind
tb=. '<rect class="j" x="',(": 26.5 + sep),'" y="9" width="',(": 4.8 + 9.59 * {: $ v ),'" height="',(":2 + 17 * # m),'" rx="6"></rect>'
tt=.'<g class="tt"><rect class="t3" x="',a,'" y="',(cnv 11 + sc _65),'" width="',(cnv sc 173),'" height="',(cnv sc 65),'" stroke-width="',(cnv sc 1),'" rx="',(cnv sc 3),'"></rect>',"1 '<text x="',(a=.cnv (sc _3) +".a),'" y="',(cnv 11 + sc _46),'" font-size="',(cnv sc 12),'"> Non-Sparse Entries : ',(": 7 $. y),' <tspan x="',a,'" dy="1.5em">Value Type : ',(7 }. datatype y),' <tspan x="',(a=.cnv sep + sc _142),'" dy="1.5em">Sparse Element : ',(": 3 $. y),' </tspan></tspan></text></g>' NB. a is redefined in line to make Safari and Chrome compatible
tm1=. tb,tt,((": 23 + sep) ; {. 7 }. x) nmercal v
tm=.(((": 12 + sep);'p') nmercal ,. (# m) # '|'),tm, tm1
tt=. '<g class="tt"><rect class="t2" x="',a,'" y="',(cnv 2 + sc _48),'" width="',(cnv sc 140),'" height="',(cnv sc 48),'" stroke-width="',(cnv sc 1),'" rx="',(cnv sc 3),'"></rect><text x="',a,'" y="',(cnv sc _28),'" font-size="',(cnv sc 12),'"> Type : ',x,'<tspan x="',(a=.cnv 2 + sc _140),'" y="',(cnv sc _10),'"> Array Shape : ',(":$y),'</tspan></text></g>'
'<rect class="';((1-: {. $ y){'jd');'" width="';(30 + 9.59 * {: $ m);'" height="';(20 + 17 * # m);'" rx="6"></rect>',tt,tm
)

boxutf=: 3 : 0"1
a=.a: [ t=.3 u: y
while. #t do.
 select. s=. 127 191 223 239 I. {. t
  case. (0;1) do. t=.}.t [ a=.a,< {.t                   
  case.       do. if. 0={:t1=.s{.t do. a=.a,<"0 t1-.0 
                                   elseif. 191 < >./ }.t1 do. a=.a,<"0 s{.t1 [ s=.>:@:(1 i.~ 191 < }.) t1
                                   elseif.                do. a=.a,< t1   end. t=. s }.t
 end.
end.
}.a
)

mask=:((1+i:&1) {. ]) @ (((,@#,:) , 0:)/) @ (}:@$ , 1:)
rsfiy=:,.@:(({:@$ # 18*(# i.@#)@mask)`0:@.(''-:$)) NB. mask used to generate y position values
valclean=:>@(('&#9484;';'&#9516;';'&#9488;';'&#9500;';'&#9532;';'&#9508;';'&#9492;';'&#9524;';'&#9496;';'&#9474;';'&#9472;') {~ ((16+i.11) {a.) &i.) NB. box characters insertion
lc=:,@:(-.&a:each)@:<"1@:(-.&a:each)@:((13;10)&(+/\.@:(+./@:(=/)-E.)</.])"1)
unb=:(mask (#^:_1)!.(<a:) ,)

litsvg=: 4 : 0 NB. literal case
's b'=. x
if. b do. yc=.,.(msk=.a:~: ,lit) # rsfiy lit=. boxutf y 
          lit=. ,-.&a: each <"1 -.&a: lit [ xw=.  msk # , xw [xc=.,. msk # , 0&,@}:@(+/\)"1 xw=.(9.59 + s * 2) * >(((0.5+1.5*FM)"_)`1:`((0.5+1.5*FM)"_)`#@.( 15 26 31 I. {.))each lit 
      else. yc=.,.( ([ S:0 (# each each lit) ) # (18 * _1 |.!.0 +/\)) @:;@: (;@:(}: , >:@:;each@:{:) each) @: (+/@:((10;13)e.{:) each each) lit=. unb lc boxutf y 
            xw=. ; xw [ xc=. ,.  ; 0&,@}:@(+/\) each xw=.((9.59 + s * 4.8)&* each) (((0.5+1.5*FM)"_)`(12"_)`((0.5+1.5*FM)"_)`1:`((0.5+1.5*FM)"_)`(#@:>)@.(8 9 15 26 31 I. {.@:>))"0  each lit=.-.&a: ;lit end.
shape=.;(''-: $ y){ (": $ y);'atom'
tt=.'<g class="tt"><rect class="t1" x="',"1 a,"1'" y="',"1(cnv yc + 8 + sc _22),"1'" width="',"1(cnv sc 140),"1'" height="',"1(cnv sc 24),"1'" stroke-width="',"1(cnv sc 1),"1'" rx="',"1(cnv sc 3),"1'"></rect>',"1 '<text x="',"1(a=.cnv (s * 12) + xc + 8 + sc _141),"1'" y="',"1(cnv yc + 8 + sc _5),"1'" font-size="',"1(cnv sc 12),"1'"> UTF-8 : ',"1(;@:(>@:(": each)each) lit),"1 '</text></g>'
tm=. '<rect ',"1(s{::('class="l',"1 ((,. -.&(<'') , 33&>@:{.each S:1 lit){'bc'));'class="syb'),"1'" x="',"1(": (s * 12)+ xc+3.5),"1'" y="',"1(":yc+7),"1'" width="',"1 (": ,. , xw),"1'" rx="2"></rect>'
vals=. ;@:,.@:(;"1@:,.@:((' '"_)`({&a.)`(valclean@:{&a.)`(({&a.))@.(0 15 26 I.{.) each) each)lit NB. vals raw values cleaned to show box characters in svg
tm=. ,tm ,"1 tt ,"1 '<text class="',"1 (s{::'l';'sy'),"1'" x="',"1(cnv (s * 14)+xc+4.5),"1'" y="',"1(cnv yc+20),"1'">',"1 vals ,"1 '</text>'
if. s do. (19.5 + >./  xw +&, xc);(32 + (18 * ({: ; lit) e. 10;13)+{: ,yc);tm NB. width height character string
    else. tt=. '<g class="tt"><rect class="t2" x="',a,'" y="',(cnv 2 + sc _48),'" width="',(cnv sc 140),'" height="',(cnv sc 48),'" stroke-width="',(cnv sc 1),'" rx="',(cnv sc 3),'"></rect><text x="',a,'" y="',(cnv sc _28),'" font-size="',(cnv sc 12),'"> Type : ',(datatype y),'<tspan x="',(a=.cnv 2 + sc _140),'" dy="1.5em"> Shape : ',shape,'</tspan></text></g>'
          '<rect class="';((1-: {. $ y){'jd');'" width="';(7.5 + >./  xw +&, xc);'" height="';(32 + (18* (-.b) * ({: ; lit) e. 10;13)+{: ,yc);'" rx="6"></rect>',tt,tm end.
)

boxuni=: 3 : 0"1
a=.a: [ t=.3 u: y
while. #t do.
 select.  55295 57343 I. {. t
  case. (0;2) do. t=. }. t [ a=. a , < {. t
  case.       do. if. (56320&> +. 57343&<:) {: t1=.2 {. t  do. t=.  }. t [ a=.a , < {. t else. t=.2 }. t [ a=.a , < t1 end.                                                           
 end.
end.
}.a
)

glfontextent_jgl2_ FONT,' 12' NB. sets fontspec for glqextent in wuf
wuf=: (9.59 * (* * 7&>. % 7:) @: (1&>.) @: {. @: glqextent_jgl2_ @: ":)

unisvg=: 4 : 0 NB. unicode case
's b'=. ({.,{:) x 
if. b do. yc=. ,. (msk=.a:~: ,uni2) # rsfiy uni2=. boxuni y
          xc=.,. msk # , 0&,@}:@(+/\)"1 xw=.(># each   uni2) *  ,/"1 >(((9.59 * 0.5+1.5*FM)"_)`(9.59 *1:)`((9.59 *0.5+1.5*FM)"_)`(wuf@(7&u:)@,)@.( 15 26 31 I. {.))each uni2  
          uni21=. ,-.&a: each <"1 -.&a: uni2 [ xwv=. ": ,. xw=. msk # ; xw 
    else. yc=. ,.( ([ S:0 (# each each uni2) ) # (18 * _1 |.!.0 +/\)) @:;@: (;@:(}: , >:@:;each@:{:) each) @: (+/@:((10;13)e.{:) each each) uni2=. unb lc boxuni y
          xc=. ,.  ; 0&,@}:@(+/\)@,"1 each xw=. ( ; each # each each uni21) * each xw=.((9.59 * 0.5+1.5*FM"_)`(9.59 * 12"_)`(9.59 * 0.5+1.5*FM"_)`1:`(9.59 * 0.5+1.5*FM"_)`(wuf@(7&u:)@>)@.(8 9 15 26 31 I. {.@:>))"0  each uni21=.-.&a: ; uni2
          xwv=. ": ,.  xw=. ;xw  end. 
shape=. ; (''-: $ y) { (": $ y) ; 'atom'
tt=.'<g class="tt"><rect class="t1" x="',"1 a,"1'" y="',/"1(cnv yc + 8 + sc _22),"1'" width="',"1(cnv sc 140),"1'" height="',"1(cnv sc 24),"1'" stroke-width="',"1(cnv sc 1),"1'" rx="',"1(cnv sc 3),"1'"></rect>',"1 '<text x="',"1(a=.cnv (s * 12) + xc + 8 + sc _141),"1'" y="',"1(cnv yc + 8 + sc _5),"1'" font-size="',"1(cnv sc 12),"1'"> Unicode : ',"1(;@:(>@:(": each)each) uni21),"1 '</text></g>'
tm=. '<rect',"1(s{::' class="ub"';' class="syb"'),"1 ' x="',"1(": (s * 12) + xc + 5),"1'" y="',"1(":yc+7),"1'" width="',"1 xwv ,"1'" rx="2"></rect>'
vals=.": ;@:,.@:(;"1@:,.@:((' '"_)`((9&u:)@:(9&u:))`(valclean@:{&a.)`((9&u:)@:(9&u:))@.(0 15 26 I.{.) each) each) uni21 NB. vals raw values cleaned to show box characters
tm=. ,tm ,"1 tt ,"1'<text class="',"1 (s{::'u';'sy'),"1'" x="',"1(cnv (s * 12) + xc+6),"1'" y="',"1(cnv yc+20),"1'">',"1 vals ,"1 '</text>'
if. s do. (21.5+ >./  xw +&, xc);(32 + (18 * ({: ; uni2) e. 10;13)+{: ,yc); tm
    else. tt=. '<g class="tt"><rect class="t2" x="',(cnv 2 + sc _140),'" y="',(cnv 2 + sc _48),'" width="',(cnv sc 140),'" height="',(cnv sc 48),'" stroke-width="',(cnv sc 1),'" rx="',(cnv sc 3),'"></rect><text x="',(cnv sc _138),'" y="',(cnv sc _28),'" font-size="',(cnv sc 12),'"> Type : ',(datatype y),'<tspan x="',(cnv sc _138),'" dy="1.5em"> Shape : ',shape,'</tspan></text></g>'
          '<rect class="';((1-: {. $ y){'jd');'" width="';(10.5+ >./  xw +&, xc);'" height="';(32 + (18* (-.b) * ({: ; uni21) e. 10;13)+{: ,yc);'" rx="6"></rect>',tt,tm  end.
)

vnisvg=: 4 : 0 NB. unicode4 case
's b'=. ({.,{:) x
if. b do. yc=. ,. (msk=.a:~: ,uni4) # rsfiy  uni4=.  boxuni y 
          xc=. ,. msk # , 0&,@}:@ (+/\)"1 xw=.(> # each uni4) * ,/"1 >(((9.59 * 0.5+1.5*FM)"_)`(9.59 *1:)`((9.59 *0.5+1.5*FM)"_)`(wuf@(7&u:)@,)@.( 15 26 31 I. {.))each uni4  
          uni41=. ,-.&a: each <"1 -.&a: uni4 [ xwv=. ": ,. xw=. msk # ; xw
    else. yc=. ,.( ([ S:0 (# each each uni4) ) # (18 * _1 |.!.0 +/\)) @:;@: (;@:(}: , >:@:;each@:{:) each) @: (+/@:((10;13)e.{:) each each) uni4=. unb lc boxuni y
          xc=. ,.  ; 0&,@}:@(+/\)@,"1 each xw=. ( ; each # each each uni41) * each ((9.59 * 0.5+1.5*FM"_)`(9.59 * 12"_)`(9.59 * 0.5+1.5*FM"_)`1:`(9.59 * 0.5+1.5*FM"_)`(wuf@(7&u:)@>)@.(8 9 15 26 31 I. {.@:>))"0  each uni41=.-.&a: ; uni4
          xwv=. ": ,. xw=.; xw  end.  
shape=. ; (''-:  $ y) { (": $ y) ; 'atom'
tt=.'<g class="tt"><rect class="t1" x="',"1 a,"1'" y="',"1(cnv yc + 8 + sc _22),"1'" width="',"1(cnv sc 140),"1'" height="',"1(cnv sc 24),"1'" stroke-width="',"1(cnv sc 1),"1'" rx="',"1(cnv sc 3),"1'"></rect>',"1 '<text x="',"1(a=.cnv (s * 12) + xc + 8 + sc _141),"1'" y="',"1(cnv yc + 8 + sc _5),"1'" font-size="',"1(cnv sc 12),"1'"> Unicode4 : ',"1(;@:(>@:(": each)each) uni41),"1 '</text></g>'
tm=. '<rect ',"1(s{::' class="u4"';' class="syb"'),"1 ' x="',"1(;"1": each <"0 (s * 12) + xc + 5),"1'" y="',"1(;"1": each <"0 [yc+6),"1'" width="',"1 xwv,"1'" rx="2"></rect>'
vals=.": ;@:,.@:(;"1@:,.@:((' '"_)`((9&u:)@:(9&u:))`(valclean@:{&a.)`((9&u:)@:(9&u:))@.(0 15 26 I.{.) each) each) uni41 NB. vals raw values cleaned to show box characters
tm=. ,tm ,"1 tt ,"1 '<text class="',"1 (s{::'v';'sy'),"1'" x="',"1(cnv (s * 12) + xc+6),"1'" y="',"1(cnv yc+19),"1'">',"1 vals ,"1 '</text>'
if. s do. (21.5+ >./  xw +&, xc);(32 + (18 * ({: ; uni4) e. 10;13)+{: ,yc); tm
    else. tt=. '<g class="tt"><rect class="t2" x="',(cnv 2 + sc _140),'" y="',(cnv 2 + sc _48),'" width="',(cnv sc 140),'" height="',(cnv sc 48),'" stroke-width="',(cnv sc 1),'" rx="',(cnv sc 3),'"></rect><text x="',(cnv sc _138),'" y="',(cnv sc _28),'" font-size="',(cnv sc 12),'"> Type : ',(datatype y),'<tspan x="',(cnv sc _138),'" dy="1.5em"> Shape : ',shape,'</tspan></text></g>'
          '<rect class="';((1-: {. $ y){'jd');'" width="';(10.5+ >./  xw +&, xc);'" height="';(32 + (18* (-.b) * ({: ; uni4) e. 10;13)+{: ,yc);'" rx="6"></rect>',tt,tm  end.
)

symsvg=: 4 : 0 NB. Symbols case: calls on litsvg, unisvg and vnisvg as needed to evaluate the labels. s flag ensures correct return of label format
's b'=. ({.,{:) x
ysvg=.  (1;0)&vg each 5 s: y 
bW=.8 + >./ bw +&, bx=. }:@(0 , +/\)"1 bw=.>./  >, <"1 [ 0 {::"1  >ysvg 
bh=. (1&>.@:{:@:$ y) # >./^:(2&<:@:#@:$)^:_  >./"1 [ 1 {::"1 > ysvg NB. >./^:(1&<:@:#@:$) swapped with , if the exception of 2 dimensions is covered
bH=.16 + bh +&{: by=. (1&>.@:{:@:$y)&# , (mask y) ({."1@:([ # +/\ @:(0&,)@:}:@:(#!.20^:_1)))  >, <"1($y)&$ bh
'bx bw bh by'=. ,.@,@(($y) $ ,) each bx ; bw ; bh ; by NB. may be smoothed a bit just normalizing the number of items of bw may be useful to look at the ysvg=. > , <"1 ysvg trick
slt=.,. , datatype each 5 s:  y
tt=.'<g class="tt"><rect class="t3" x="';"1 a;"1'" y="';"1(cnv 2 + sc _66);"1'" width="';"1(cnv sc 173);"1'" height="';"1(cnv sc 65);"1'" stroke-width="';"1(cnv sc 1);"1'" rx="';"1(cnv sc 3);"1'"></rect>';"1 '<text x="';"1 (a=.cnv (sc _3) + ".a);"1'" y="';"1(cnv sc _47);"1'" font-size="';"1(cnv sc 12);"1'"> Label Type : ';"1(;"1 slt);"1' <tspan x="';"1 a;"1'" dy="1.5em">Index : ';"1(;"1(":each ,. , 6 s: y));"1' </tspan><tspan x="';"1(a=.cnv + sc _171);"1'" dy="1.5em">';"1(": 0 s: 0);"1' Symbols Assigned </tspan></text></g>'
tm=.,. '<svg x="';"1 bx ;"1'" y="';"1 by ;"1'"><rect class="sr ';"1(;"1(('unicode';'unicode4')i.slt){'su';'sv';'sl');"1'" width="';"1 (": ,. , bw );"1'" height="';"1 (": ,. , bh);"1'" rx="3"></rect>';"1 tt ,"1 '<text class="s" x="2" y="18">`</text>';"1'"><svg>';"1  (ysvg=. ,. {. > , <"1 > , &.:> {: each ysvg),"1 <'</svg></svg>' NB. red background of symbol
shape=.;(''-:  $ y){"1((":  $ y);'atom')
tt=. ,'<g class="tt"><rect class="t2" x="',a,'" y="',(cnv 2 + sc _48),'" width="',(cnv sc 140),'" height="',(cnv sc 48),'" stroke-width="',(cnv sc 1),'" rx="',(cnv sc 3),'"></rect><text x="',a,'" y="',(cnv sc _28),'" font-size="',(cnv sc 12),'"> Type : ',(datatype y),'<tspan x="',(a=.cnv 2 + sc _140),'" dy="1.5em"> Shape : ',shape,'</tspan></text></g>'
tm=. ": each '<svg  x="4" y="8">';"1  tm ,"1<'</svg>'
'<rect class="';((1-: {. $ y){'jd');'" width="';bW;'" height="';bH;'" rx="6"> </rect>', tt, ; tm
)

bxsvg=: 4 : 0 NB. boxed cases - sends contents through the process and boxes those results
's b'=. ({.,{:) x   
bW=.16 + bw +&{: bx=. }: 0 , +/\  bw=.>./  > , <"1 [ 3 {::"1  ysvg=.  vg&> y 
bh=. (1&>.@:{:@:$ y) # >./^:(2&<:@:#@:$)^:_  >./"1 [ 5 {::"1 ysvg NB. >./^:(1&<:@:#@:$) swapped with , if the exception of 2 dimensions is covered
bH=.32 + bh +&{: by=. (1&>.@:{:@:$y)&# , (mask y) ({."1@:([ # +/\ @:(0&,)@:}:@:(#!.20^:_1)))  >, <"1($y)&$ bh 
'bx bw bh by'=. ,.@,@(($y)&$) each bx ; bw ; bh ; by NB. may be smoothed a bit just normalizing the number of items of bw may be useful to look at the ysvg=. > , <"1 ysvg trick
tm=. ({."1 ysvg),. ('x '&, each 1{"1 ysvg) ,.(2{"1 ysvg),. (<"0 bw) ,.(4{"1 ysvg),. (<"0 bh) ,. ,. {:"1 ysvg=. > , <"1 ysvg
shape=.;(''-:  $ y){"1((":  $ y);'atom')
tt=. '<g class="tt"><rect class="t2" x="',a,'" y="',(cnv 2 + sc _48),'" width="',(cnv sc 140),'" height="',(cnv sc 48),'" stroke-width="',(cnv sc 1),'" rx="',(cnv sc 3),'"></rect><text x="',a,'" y="',(cnv sc _28),'" font-size="',(cnv sc 12),'"> Type : ',(datatype y),'<tspan x="',(a=.cnv 2 + sc _140),'" dy="1.5em"> Shape : ',shape,'</tspan></text></g>'
tm=. ": each '<svg  x="';"1((4*b)+ 4+ bx);"1'" y="';"1(17+by);"1'" width="';"1 bw;"1'" height="';"1 bh;"1'">';"1  tm ,"1<'</svg>'
'<rect class="';((1-: {. $ y){'jd');'" width="';(bW- 8 * -. b);'" height="';bH;'" rx="6"> </rect>', tt, ; tm
)

nmsvg=: 4 : 0 NB. numeric cases - boolean, floating, rational, integer, complex, extended
typ=.{.x [ vals=. > , <"1  ": y  
yc=. ,. 20+ 18*(# i.@#)@mask y
shape=.;(''-:  $ y){"1((":  $ y);'atom')
tt=. '<g class="tt"><rect class="t2" x="',a,'" y="',(cnv 2 + sc _48),'" width="',(cnv sc 140),'" height="',(cnv sc 48),'" stroke-width="',(cnv sc 1),'" rx="',(cnv sc 3),'"></rect><text x="',a,'" y="',(cnv sc _28),'" font-size="',(cnv sc 12),'"> Type : ',x,'<tspan x="',(a=.cnv 2 + sc _140),'" dy="1.5em"> Shape : ',shape,'</tspan></text></g>'
if. (typer=.('fcr'i.typ){'ejr ')~:' ' do. vals=. vals rplc"1 typer ; '<tspan class="', (typer,'a'),"1 '">', typer ,'</tspan>' end.
tm=. ,('<text class="',typ,'" x="3.5" y="'),"1 (cnv yc),"1('">'),"1 vals ,"1 '</text>'
'<rect class="';((1-: {. $ y){'jd');'" width="';(7 + 9.6 * {:$":y);'" height="';(14 + 18 * # mask  y);'" rx="6"></rect>',tt,tm
)

findline =: 3 : 0    NB. WinSelect is a character index; WinText is entire window; if window contains non-ASCII, convert to unicode
  if. y do. }.(#~ -.@:(*./\)@:=&' ') ": > {: < ;. _2 (wd'sm get inputlog'), LF NB. pull the last line only for the monadic case Programmatic version
        else. (#~ -.@:(*./\)@:=&' ') ": ({. WinSelect_jqtide_) ((LF&taketo&.|.)@:{. , LF&taketo @:}.)  7 u: WinText_jqtide_  end.NB. The line that the cursor is on if 0 - Function key version
)

v_z_ =:   3 : '((1;coname 0$0) visual_jig_ 1:) y'

NB. variables for the Jig lab
result=:('0',CRLF,'1',LF,'2',TAB)
T1=: 1;2;({. 3 2j4);({. 4 2.4);({. 5 2x);({. 6 2r5)
T2=: ": i. 3 3
T3=: ": 3 3 $9 u: 128512 69 3101 128514
T4=: 'AB';(7 u: 67 68); 9 u: 69 70
'SA SB SC'=: s: '😀'; (7 u: 128512); 9 u: 128512
T5=: (2;  0 1 2) $. (3;9) $. 0 $.  3 5 8 $ (45 # 9),7
T6=: 2 1 1 1 55 $ 3
T7=: (i.1 3);i.3
T8=: 2 2 $ ((<'_ 1 1r2 1r3 1r4'),:(< x: % i. 5));((3 0 $ 4);<,. u:3101 );(0 0$1 0 1 1 0);(9 u: 16 + i.14)