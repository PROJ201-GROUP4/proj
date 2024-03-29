# 7.1 - Controlling Running Synths
## Şu ana kadar sadece yeni sesler üretmek ile uğraştık, ancak Sonic Pi ürettiğimiz bu sesleri manipüle etmemizi de sağlıyor.
```
s = play 60, release: 5
```

### Burada ‘’run-local’’ kodumuz var. ‘’s’’ ile gösterdiğimiz bu değişkene diğer fonksiyonlar gibi ulaşamıyoruz , ‘’s’’ tanımladığımız zaman, kontrol kısmından kontrol edebiliriz.
```
s = play 60, release: 5
sleep 0.5
control s, note: 65
sleep 0.5
control s, note: 67
sleep 3
control s, note: 72
```
### Burada dikkat edilmesi gereken şey, 4 tane ayrı synth’i kontrol etmek yerine, bir synth’in perdesini (akor) 3 kere değiştiriyoruz. ‘’Control’’ komutu ile amp: , cutoff: ve pan: gibi komutları değiştirebiliriz. 

## Kontrol edilemeyen seçenekler
## Bazı ayarları, sytnh’i ayarladıktan sonra değiştiremiyoruz. Değiştirebileceğin etmenleri ‘’Ayarlar’’ kısmında görebilirsin.

# 7.2 – Efektleri Kontrol etmek

## Efektleri biraz farklı bir yöntemle de olsa kontrol etmek mümkün.
```
with_fx :reverb do |r|
  play 50
  sleep 0.5
  control r, mix: 0.7
  play 55
  sleep 1
  control r, mix: 0.9
  sleep 1
  play 62
end
```

### Değişkenleri kullanmak yerine ‘’goalpost’’ do/end bloğundaki ‘’goalpost’’ parametresini kullanıyoruz. Çizgi ile ayrılmış kısmın içine oraya ait özel bir isim yazarak efekti do/end kısmında çalıştırabiliyoruz.

# 7.3 - Sliding Seçeneği
## Synthleri keşfedip efekleri değiştirirken ‘’_slide’’ adlı komutu görmüş hatta çalıştırmayı deneyip başarısız olmuş olabilirsin. Çünkü onlar normal bir parametre değil. Onlar özel bir seçenek olup synthleri az önce kontrol ettiğin gibi kontrol ettiğinde kullanabilirsin. 
```
s = play 60, release: 5
sleep 0.5
control s, note: 65
sleep 0.5
control s, note: 67
sleep 3
control s, note: 72
```

 ### Burada sytnh’in akorunun her seferinde değiştiğini görebilirsin. ‘’Note’’ değişkenini kontrol ettiğimiz için, ‘’slide’’ kısmına eklemek için ‘’note_slide’’ yazmamız gerekiyor.
```
s = play 60, release: 5, note_slide: 1
sleep 0.5
control s, note: 65
sleep 0.5
control s, note: 67
sleep 3
control s, note: 72
```

### ‘’Slide’’ komutunun hızı ‘’note_slide : 0.2’’yazarak arttırabiliriz veya tam tersi şeklinde azaltabiliriz.
## ‘’Slide’’ yapışkan olabilir !
### ‘’_slide’’ komutunu ayarladıktan sonra sürekli her paramterede kullanılacağı için, ‘’Slide’’ komutunu durdurmak için ‘’Slide’’ değerini 0 yapmayı unutma.

## Efektleri kaydırmak 
### Efektleri ‘’_slide’’ ile kaydırmak mümkün:
```
with_fx :wobble, phase: 1, phase_slide: 5 do |e|
  use_synth :dsaw
  play 50, release: 5
  control e, phase: 0.025
end
```


