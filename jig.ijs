NB.  This add-on will select appropriate version of J 

3 : 0 ''
test=: 3 : 0 ''
if. IFJHS do. echo 'jig is only supported on jQt IDE at this time' return. end.
select. t=.4 {. 9!:14 ''
case. 'j903' do. load '~addons/debug/jig/jig903.ijs'
case. 'j901';'j902';'j903' do. load '~addons/debug/jig/jig900.ijs'
case. 'j805';'j806';'j807' do. load '~addons/debug/jig/jig800.ijs' 
case.        do. echo 'jig only supported for j805, j806, j807, j901, j902 and j903.' end.
)
