 # 1.1 – Kodlamaya Başlamak
 ## SonicPi uygulamasının en heyecan verici kısmı kendi kodunuzu yazarken aynı zamanda da kendi müziğinizi yapmanızdır. Hazırsanız başlayalım.

### Hadi başlayalım, aşağıdaki kodu kopyalayıp boş alana yapıştır.

```
live_loop :flibble do
  sample :bd_haus, rate: 1
  sleep 0.5
end
live_loop :flibble do
  sample :bd_haus, rate: 1
  sleep 0.5
end

```

## Şimdi ‘’Run’’ butonunu basarak kodu çalıştır. Unutma ne zaman kodu durdurmak istersen ‘’Stop’’ butonuna basabilirsin. Ama şimdilik basma, onun yerine aşağıdaki adımları izle :
```
1.	Baterinin sesinin devam ettiğinden emin ol.
2.	Sleep değerini 0.5’ten daha büyük bir şeye çevir, mesela 1 olabilir.
3.	Tekrar ‘’Run’’ butonuna bas.
4.	Baterinin nasıl hızlandığını fark ettin mi ? 

```

## Tamam şimdi bu basit kısmı atladığımıza göre kodumuza biraz daha bir şeyler ekleyebiliriz.

### Buradaki koduna sample :bd_haus bir de bu kısmı ekle sample :ambi_choir, rate: 0.3. Kodunun böyle gözüküyor olması lazım.

```
live_loop :flibble do
  sample :ambi_choir, rate: 0.3
  sample :bd_haus, rate: 1
  sleep 1
end

```

### Şimdi biraz daha bu kod ile oyna, değerleri değiştirdiğine ne oluyor fark ettin mi? Daha büyük veya daha küçük bir değer girdiğinde ne olduğunu düşün. Mesela  rate: değerini :ambi_choir için değiştir(diyelim ki  0.29). Çok küçük bir ‘’sleep’’ değeri seçersen ne olur ? Bakalım çok büyük bir sayı girip kodunun hata vermesini sağlayabilecek misin ? (eğer daha büyük bir ‘’sleep’’ değeri seçip ‘’Run’’ butonuna basarsan bunu yapabilirsin). 

### Eğer satırların başına ‘’#’’ koyarsan o satır için not düşebilirsin.
```
live_loop :flibble do
  sample :ambi_choir, rate: 0.3
#  sample :bd_haus, rate: 1
  sleep 1
end
```

### Bilgisayarın, kodu okurken nasıl o satırı görmezden geldiğini fark ettin mi ? Buna ‘’comment’’ deniyor. Bu özelliği SonicPi’da kendine bir not bırakmak için kullanabilirsin.

### Şimdi son olarak aşağıdaki kodu kopyala ve boş alana yapıştır 
```
live_loop :guit do
  with_fx :echo, mix: 0.3, phase: 0.25 do
    sample :guit_em9, rate: 0.5
  end
#  sample :guit_em9, rate: -0.5
  sleep 8
end
```
```
live_loop :boom do
  with_fx :reverb, room: 1 do
    sample :bd_boom, amp: 10, rate: 1
  end
  sleep 8
end
``` 
### Çok fazla anlamak için uğraşma, onun yerine aşağıdaki adımları izleyip kodunda oynamalar yapabilirsin :
```
	Mavi ile yazılmış ‘’ rate’’ değerlerini değiştirerek farklılığı anlamaya çalış.
	‘’Sleep’’ değerlerini değiştirerek temponun nasıl değiştini hisset.
	Sample kısmındaki ‘’#’’ işareti kaldırarak arkada çalan gitarın keyfini çıkar.
	Mavi ile yazılmış ‘’mix’’ değerlerini 0’dan 1’e değiştir.
```
# 1.2 - Sonic Pi Arayüzü
```
	A – Kontroller ile oyna
	B – Kontrolleri değiştir
	C – Bilgi ve yardım sekmesi
	D – Kodların yazıldığı panel
	E - Tercih Paneli
	F - Log Paneli
	G – Yardım sistemi
	H - Scope Paneli
```

## A. Kontroller ile oynama
### Bu kırmızı butonlar kodu kontrol etmeni sağlayan ana butonlar. ‘’Run’’ butonu kodunu çalıştırırken ‘’Stop’’ butonu devam etmekte olan bütün kodları durdurur. ‘’ Save’’ butonu kodunu harici olarak bilgisayarına kaydederken ‘’Rec’’ butonu kodunu WAV dosyası olarak kaydeder.

## B. Kontrolleri değiştirme
### Bu kısımda kontrolleri değiştirebilirsin. Size + ile kodları büyütürken size – ile küçültebilirsin.
 

## C. Bilgi ve Yardım Sekmesi
### Bu mavi butonlar bilgi, yardım ve tercihler kısmına erişmeni sağlar. ‘’Info’’ kısmı bir SonicPi hakkında bir bilgi sekmesi açar. ‘’Help’’ kısmı (G sekmesindeki) yardım kısmını açarken ‘’Pref’’ kısmında ise basit tercihleri değiştirebileceğin olanak sunulur.

## D. Kod Paneli
### Bu kısım kodlarını yazıp, şarkılarını bestelediğin kısım. Burada yazdığın şeyler manasına göre otomatik olarak farklı renkler alacak. Örneğin mavi renkliler her zaman sayıları temsil ediyor.

## E. Tercih Paneli
### ‘’Prefs’’ butonu ile açabileceğin bu Tercih Paneli kısmında, SonicPi’yı istedğin gibi değiştirebilir ve üzerinde oynama yapabilirsin. ’’Mono Modunu’’ açabilir veya sesi ‘’Stereo’’ yapabilirsin. Müziğin sesini arttırabilir veya azaltabilirsin.

## F. Log Paneli
### Kodunu çalıştırdığın zaman bu kısımda kodun hakkında bilgiler ye almaya başlar. Her yazdığın ses için bu kısımda bir mesaj çıkar, böylece kodunda bir hata olursa anlaman daha kolay olur.

## G. Yardım Sistemi
### SonicPi arayüzünün en önemli kısımlarından birisi de yardım sistemidir. Bu kısıma sayfanın en altından ulaşabilirsiniz. ‘’Help’’butonuna basarak açık veya kapalı tutabilirsiniz. Mevcutta olan tüm synth örneklerine, kod örneklerine ve müzik örneklerine ulaşabilirsiniz. SonicPi uygulamasının sunmuş olduğu tüm ses efektlerine de buradan ulaşabilirsiniz. 

## H. Scope Paneli
### Scope paneli yazdığınız şarkıların görünmesini sağlar. Yazdığınız şarkıların ses dalgalarını buradan rahatça görebilirsiniz. Basit bir bip sesi kavisli bir görüntü bırakır. Burada aynı zamanda kısık ve yüksek ses arasındaki farkı görebilir, Lissajous scope kısmı ile kodladığınız sesler ile resim çizebilirsiniz. 

# 1.3 – Oynayarak öğrenmek
## Sonic Pi sizi kodlamaya teşvik ederken aynı zamanda kendi müziğinizi de yapmanızı sağlar. Buradaki en önemli kısım eğlencenin tadını çıkarmaktır, eğlenirken de bir bakmışsınız kodlamayı öğrenmişsiniz.







