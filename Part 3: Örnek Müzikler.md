# 3 – Örnek Müzikler

Müziğinizi yaratmanın bir başka yolu ise önceden kaydedilmiş seslerden yararlanmaktır. Hip-hop geleneğinde, biz bu önceden kaydedilmiş seslere örnekler (“samples”) deriz. Yani, bir mikrofon alıp, dışarı çıkıp yağmurun kaldırıma vuruşunun tatlı sesini kaydederseniz, bir örnek yaratmış olursunuz. 

Sonic Pi bu örneklerle bir sürü eğlenceli şey yapmanıza olanak tanır. Kullanıma serbest **130** örnekle gelmesi bir yana, aynı zamanda kendi örneklerinizi yapma ve işlemeye olanak tanır. Haydi inceleyelim…   

## 3.1 – Örnekleri Çalıştırma

Ses çıkarmak yalnızca bir başlangıçtı. Fazlasıyla eğlenceli bir seçenek ise önceden kaydedilmiş örnekleri kullanmak. Deneyin:

```ruby
sample :ambi_lunar_land
```

Sonic Pi çalabileceğiniz birçok örneği içinde barındırır. Tıpkı “***play***” komutunu kullandığınız gibi onları da kullanabilirsiniz. Birden çok örnek oynatmak isterseniz peşi sıra yazabilirsiniz:

```ruby
play 36
play 48
sample :ambi_lunar_land
sample :ambi_drone
```

Onları zamana yaymak isterseniz, ***sleep*** komutunu kullanabilirsiniz:

```ruby
sample :ambi_lunar_land
sleep 1
play 48
sleep 0.5
play 36
sample :ambi_drone
sleep 1
play 36
```

Sonic Pi’ın bir sonraki sesi çalmak için öncekinin bitmesini beklemediğine dikkat edin. sleep komutu seslerin yalnızca harekete geçişini etkiler. Bu da size sesleri kolayca katmanlaştırarak ilginç bir çakışma efekti elde etme imkanı sunar. Bu öğreticinin devamında “kılıflar” (envelopes) kullanarak seslerin süresini kontrol etmeyi öğreneceğiz.

### Örnekleri Keşfetme

Sonic Pi’ın içinde barındırdığı örnekleri keşfetmenin iki yolu vardır. İlki, bu yardım sistemini kullanmaktır. Bu yardım penceresinin en altındaki menüden örnekler (“samples”) seçeneğine tıklayın, kategori seçin ve mevcut seslerin bir listesini göreceksiniz.
Alternatif olarak ise otomatik tamamlama sistemini kullanabilirsiniz. Direkt bir örnek grubunun adını yazmaya başlayın: **sample :ambi** ve altta çıkacak menüde seçebileceğiniz örnek adları kendiliğinden belirecektir. Bu kategori önadlarını yazmaya başlamayı deneyin:
•	:ambi_
•	:bass_
•	:elec_
•	:perc_
•	:guit_
•	:drum_
•	:misc_
•	:bd_

> Şimdi örnekleri derlemelerinizde kullanmaya başlayın!

## 3.2 – Örnek parametreleri: Amp ve Pan

Synths’lerde gördüğümüz gibi, seslerimizi parametreler yardımıyla kolayca kontrol etmek mümkün. Örneklerde aynı parametrelerinde sisteminden yararlanır. Arkadaşlarımız **amp:** ve **pan:**’i hatırlayalım.

### Örnekleri Amp’leme

Örneklerin genliğini synth’ler için kullandığımız aynı yöntemle değiştirebilirsiniz:
```ruby
sample :ambi_lunar_land, amp: 0.5
```

### Örnekleri Pan’leme
Örnekler üzerinde **pan:** kullanmak da mümkün. Örneğin, şu şekilde “amen” örneğini sol kulaktan çalıp yarısına gelindiğinde sağ kulaktan da çalmaya başlamayı sağlayabilirsiniz:
```ruby
sample :loop_amen, pan: -1
sleep 0.877
sample :loop_amen, pan: 1
```

Dikkat ediniz ki 0.877, **:loop_amen** örneğinin saniye cinsinden uzunluğunun yarısıdır.

Son olarak, eğer birkaç **use_synth_defaults** kullanarak birkaç varsayılan ayar belirlediyseniz (ki bunu daha sonra göreceğiz), bu ayarlar sample tarafından görmezden gelinecektir.
 
## 3.3 – Örnekleri genişletme

Müzik yaratmak için birçok synth ve örnek oynatabilmeyi öğrendiğimize göre, bunları nasıl modifiye ederek müziğimizi ilginç ve benzersiz kılabileceğimize bir bakalım. Öncelikle örnekleri yayma (stretch) ve sıkıştırma (squash)‘ya bakalım.

### Örneklerin Gösterimi

Örnekler önceden kaydedilmiş, sayılar biçiminde saklanan seslerdir ve bu sayılar hoparlörün kozasının sesi çıkarmak için nasıl hareket edeceğini tanımlar. Koza içeri veya dışarı hareket edebilir, yani sayılar yalnızca kozanın ne kadar içeri veya dışarı hareket etmesi gerektiğini belirtir her bir birim zaman için. Sonic Pi saniyede binlerce sayı değerini bilgisayarınızın hoparlörüne doğru zamanda aktararak doğru sesi elde etmeyi sağlar. Fakat sayıların hoparlöre aktarıldığı hızı değiştirerek sesi değiştirmek de eğlenceli bir yöntemdir.

### “Hız” (Rate) Değiştirme 

Haydi şu ses üzerinde oynayalım **:ambi_choir**. Varsayılan hızı değiştirmek için sample’a **rate:** seçeneği uygulayabilirisiniz:
```ruby
sample :ambi_choir, rate: 1
```
Bu onu normal hızda çalar. Fakat o sayıyı istediğimiz sayıya çevirebiliriz. Örneğin 0.5:
```ruby
sample :ambi_choir, rate: 0.5
```
Wow! Neler oluyor? Aslına bakarsanız iki şey: İlki, örneğin çalma süresi iki katına çıkıyor, ikincisi ses bir oktav aşağıdan çalıyor. Detayına girecek olursak…

### Haydi Genişletelim

Genişletip sıkıştırması eğlenceli bir örneklerden biri “Amen Break”tir. Normal hızında onu bir drum ‘n’ bass parçasına eklediğimizi hayal edebiliriz:
```ruby
sample :loop_amen
```
Fakat hızını değiştirerek müziğin üslubunu değiştirebiliriz. Old school hip-hop tarzı için yarım hızı deneyin: 
```ruby
sample :loop_amen, rate: 0.5
```
Hızlandırırsak jungle bölgesine girmiş oluruz:
```ruby
sample :loop_amen, rate: 1.5
```

Son parti şakamız – Bakalım eksi bir hız kullanınca ne olacak:
```ruby
sample :loop_amen, rate: -1
```

Woah! *tersten oynatılıyor!*  Şimdi diğer değerleri deneyin ve ne çılgınlıklar yapabileceğinizi keşfedin.

 
## 3.4 – Kılıflı Örnekler

ADSR kılıfı kullanarak örneklerin müddeti ve genliğini kontrol etmek mümkün. Fakat örnekler için olan ADSR kılıfları synth’ler için farklı çalışır. Örneklerde kılıflar yalnızca müddeti ve genliği azaltmakta kullanılabilir. Örnek ise çalmayı ya bittiğinde ya da kılıf sona erdiğinde kesecektir. Yani oldukça uzun bir **release:** değeri girerseniz, örneğin süresi uzatılmayacaktır.

### Amen Kılıfları
 “Amen Break” adlı dostumuza dönelim:
 ```ruby
sample :loop_amen
```

hiçbir seçenek olmadan, tüm örneği tam seste duyarız. Örneğin bir saniye süresince artarak girmesini istersek **attack:** parametresini kullanabiliriz:
```ruby
sample :loop_amen, attack: 1
```
Veya daha kısa bir giriş için:
```ruby
sample :loop_amen, attack: 0.3
```

### Otomatik sürdürmek

ADSR kılıfının farklı olduğu kısım sürdürme (sustain) değeriyle alakalı. Standart kılıfta varsayılan sürdürme değeri 0’dır. Örneklerde ise bu değer sihirli bir değere sahiptir: örneğin kalanı için gereken süreye. Soni Pi akıllıca bu değeri hesaplar ve herhangi bir attack, decay veya release değerini göz önünde bulundurarak kullanır.

### Azalarak çıkma

Yukarıda anlatılanı keşfetmek için “Amen Break” i inceleyelim. Sonic Pi’ a uzunluğunu sorduğumuzda:
```ruby
print sample_duration :loop_amen
```

Basacağı değer **1.753310657596372**’dur ki bu örneğin saniye cinsinden uzunluğudur. Eğer release’i **0.75**’e ayarlarsak şaşırıtcı bir şey gerçekleşecektir:
```ruby
sample :loop_amen, release: 0.75
```

Örneğin ilk bir saniyesi tam seste çalacak, kalanı ise 0.75 saniyelik bir sürede azalarak bitecektir. Bu otomatik sürdürme özelliğidir.Kurulduğu üzere release her zaman sondan hesaplanır. Örnek 10.75 saniye olduğu takdirde ilk 10 saniye tam çalar ve son 0.75 saniye yine azalarak gider.

### Azalarak/Yükselerek girme ve çıkma
Hem **attack:** hem **release:’i** birlikte kullanarak örneğin hem yükselerek girmesi hem de azalarak çıkmasını sağlayabiliriz.
```ruby
sample :loop_amen, attack: 0.75, release: 0.75
```
Şarkının tüm uzunluğu 1.75 saniye olduğu için, attack ve release toplamı 1.5 olacak, ve sürdürme ise otomatik olarak kalan 0.25 saniyeye eşit olacaktır.

### Belirli bir sürdürme (sustain) değeri
**sustain:‘i** 0 gibi belirli bir değere eşitleyerek normal synth ADSR değerine rahatça geri dönebiliriz.
```ruby
sample :loop_amen, sustain: 0, release: 0.75
```
Şuan, örneğimiz toplamda yalnızca 0.75 saniye boyunca çalışıyor. **attack:** ve **decay:** ‘in varsayılan değerlerinde, örnek direk tam genlikte başlıyor, o genlikte 0 saniye durup 0.75 saniyelik bir release periyotunda 0 genliğe doğru iner.

### Vuruşlu ziller
Bu etkiyi iyiye yorarak uzun örnekleri daha kısa ve vuruşlu biçimlere sokabiliriz. **:drum_cymbal_open** örneğini düşünecek olursak: 
```ruby
sample :drum_cymbal_open
```
Zil sesinin belirli bir süre boyunca çaldığını duyabilirsiniz. Ancak, kılıf kullanarak onu daha vuruşlu duydurtabiliriz: 
```ruby
sample :drum_cymbal_open, attack: 0.01, sustain: 0, release: 0.1
```
Artık zile vurma efekti verip onun sürdürme periyodunu arttırarak kısalmasını sağlayabiliriz:
```ruby
sample :drum_cymbal_open, attack: 0.01, sustain: 0.3, release: 0.1
```
> Haydi gidip kılıfları diğer örneklere de uygulayarak eğlenme zamanı. Fazlasıyla ilginç sonuçlar için oynatma hızını da değiştirmeyi deneyin.
 
## 3.5 - Partial Samples

Bu kısım ile Sonic Pi’daki örnek oynatıcıyı incelemeyi tamamlıyoruz. Tekrar hatırlatalım. Şimdiye dek örnekleri nasıl çalacağımıza baktık:
```ruby
sample :loop_amen
```
Sonra da onların hızını nasıl değiştireceğimizi gördük, yarı hızda çalmak gibi:
```ruby
sample :loop_amen, rate: 0.5
```
Sonra şarkıyı nasıl yükselerek girecek şekilde ayarlayacağımızı:
```ruby
sample :loop_amen, rate: 0.5, attack: 1
```
Ayrıca bir örneğin başını nasıl vurgulu bir şekilde çalabileceğimizin **sustain:’**e belli bir değer biçip **attack** ve **release’i** kısa değerler şeklinde ayarlanmasıyla elde edildiğini öğrendik: 
```ruby
sample :loop_amen, rate: 2, attack: 0.01, sustain: 0, release: 0.35
```
Yine de, her zaman örneğin başından başlamak zorunda olmasak daha iyi olmaz mıydı? Veya sonunda bitirmek zorunda olmasak?

### Başlangıç noktası seçme
Örneği keyfi bir başlangıç noktasından başlatmak 0 ile 1 arasında bir başlangıç değeri atamakla mümkün. 0, şarkının başlangıcı; 1, bitişi ve 0.5 ise tam ortası demektir. Şimdi “Amen Break”in yalnızca son yarısını oynatmayı deneyelim:
```ruby
sample :loop_amen, start: 0.5
```
Son çeyreğine ne dersiniz:
```ruby
sample :loop_amen, start: 0.75
```

### Bitiş noktası seçme 
Benzer biçimde, örnek için belirli bir bitiş noktası seçmek de mümkün. Amen Break’i yarıda keselim:
```ruby
sample :loop_amen, finish: 0.5
```

### Başlangıç ve Bitişi Belirtme
Tabiki ikisini birleştirerek örneğin belirli bir kısmını da çaldırabiliriz. Mesela ortalarda küçük bir bölümünü:
```ruby
sample :loop_amen, start: 0.4, finish: 0.6
```
Ya başlangıç noktasını bitişten sonraki bir değer olarak seçersek ne olur?
```ruby
sample :loop_amen, start: 0.6, finish: 0.4
```
> Havalı! Şarkı tersten çalıyor.

### Hız ile birleştirmek

**rate:** adlı arkadaşımızı belirli bir kesimi seçtiğimiz bu özelliğe entegre edebiliriz. Örneğin ortalardan bir kısmı yavaşça çalmak için:
```ruby
sample :loop_amen, start: 0.5, finish: 0.7, rate: 0.2
```

### Kılıflarla birleştirmek
Son olarak hepsini ADSR kılıflarımızla birleştirerek ilginç sonuçlar elde edebiliriz:
```ruby
sample :loop_amen, start: 0.5, finish: 0.8, rate: -0.2, attack: 0.3, release: 1
```
 
## 3.6 – Dışarıdan Örnek Kullanma 
Sonic Pi ile yüklü gelen örnekler hızlıca başlamanız için yardımcı olsa da, başka kaydedilmiş sesler ile de çalışmayı denemek isteyebilirsiniz. Buna geçmeden önce eserinizin taşınabilirliği üzerine konuşalım.

### Taşınabilirlik
Şarkınızı tamamen yerleşik synth ve örnekler kullanarak yaparsanız, müziğinizi çoğaltmak için tek gereken şeyin güvenle kodunuz olduğunu belirtebiliriz. Bu harika. Böylece müziğinizi oldukça kolayca kodu paylaşarak yayabilirsiniz.

Ancak, kendi önceden kaydedilmiş örneklerinizi kullanırsanız, bu özelliği kaybedersiniz. Zira müziğinizi çoğaltmak için diğer insanların yalnızca kodunuza değil, örneklerinize de ihtiyacı olacaktır. Bu da diğerlerinin sizin müziğinizi manipüle etme, mixleme ve üzerinde denemeler yapmasını zorlaştıracaktır. Tabi ki kendi örneklerinizi kullanmaktan alı koymasın bu sizi, yalnızca aklınızda bulunması gereken bir durum.

### Yerel örnekler
Peki, bilgisayarınızdan nasıl belirli bir WAV, AIFF, veya FLAC dosyasını çalabilirsiniz? Tek yapmanız gereken dosya dizinini sample’a atmak olacaktır:
```ruby
# Raspberry Pi, Mac, Linux
sample "/Users/sam/Desktop/my-sound.wav"
# Windows
sample "C:/Users/sam/Desktop/my-sound.wav"
```
Sonic Pi otomatik olarak parçayı yükleyip çalacaktır. Ayrıca standart parameterelden de aynı şekilde yararlanabilirsiniz:
```ruby
# Raspberry Pi, Mac, Linux
sample "/Users/sam/Desktop/my-sound.wav", rate: 0.5, amp: 0.3
# Windows
sample "C:/Users/sam/Desktop/my-sound.wav", rate: 0.5, amp: 0.3
```

