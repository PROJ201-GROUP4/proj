3 – Örnek Müzikler

Müziğinizi yaratmanın bir başka yolu ise önceden kaydedilmiş seslerden yararlanmaktır. Hip-hop geleneğinde, biz bu önceden kaydedilmiş seslere örnekler (“samples”) deriz. Yani, bir mikrofon alıp, dışarı çıkıp yağmurun kaldırıma vuruşunun tatlı sesini kaydederseniz, bir örnek yaratmış olursunuz. 

Sonic Pi bu örneklerle bir sürü eğlenceli şey yapmanıza olanak tanır. Kullanıma serbest 130 örnekle gelmesi bir yana, aynı zamanda kendi örneklerinizi yapma ve işlemeye olanak tanır. Haydi inceleyelim…   

3.1 – Örnekleri Çalıştırma

Ses çıkarmak yalnızca bir başlangıçtı. Fazlasıyla eğlenceli bir seçenek ise önceden kaydedilmiş örnekleri kullanmak. Deneyin:
 
Playing beeps is only the beginning. Something that’s a lot of fun is triggering pre-recorded samples. Try it:
sample :ambi_lunar_land

Sonic Pi çalabileceğiniz birçok örneği içinde barındırır. Tıpkı “play” komutunu kullandığınız gibi onları da kullanabilirsiniz. Birden çok örnek oynatmak isterseniz peşi sıra yazabilirsiniz:

play 36
play 48
sample :ambi_lunar_land
sample :ambi_drone

Onları zamana yaymak isterseniz, sleep komutunu kullanabilirsiniz:

sample :ambi_lunar_land
sleep 1
play 48
sleep 0.5
play 36
sample :ambi_drone
sleep 1
play 36

Sonic Pi’ın bir sonraki sesi çalmak için öncekinin bitmesini beklemediğine dikkat edin. sleep komutu seslerin yalnızca harekete geçişini etkiler. Bu da size sesleri kolayca katmanlaştırarak ilginç bir çakışma efekti elde etme imkanı sunar. Bu öğreticinin devamında “kılıflar” (envelopes) kullanarak seslerin süresini kontrol etmeyi öğreneceğiz.

Örnekleri Keşfetme

Sonic Pi’ın içinde barındırdığı örnekleri keşfetmenin iki yolu vardır. İlki, bu yardım sistemini kullanmaktır. Bu yardım penceresinin en altındaki menüden örnekler (“samples”) seçeneğine tıklayın, kategori seçin ve mevcut seslerin bir listesini göreceksiniz.
Alternatif olarak ise otomatik tamamlama sistemini kullanabilirsiniz. Direkt bir örnek grubunun adını yazmaya başlayın: sample :ambi ve altta çıkacak menüde seçebileceğiniz örnek adları kendiliğinden belirecektir. Bu kategori önadlarını yazmaya başlamayı deneyin:
•	:ambi_
•	:bass_
•	:elec_
•	:perc_
•	:guit_
•	:drum_
•	:misc_
•	:bd_

Şimdi örnekleri derlemelerinizde kullanmaya başlayın!
3.2 – Örnek parametreleri: Amp ve Pan

Synths’lerde gördüğümüz gibi, seslerimizi parametreler yardımıyla kolayca kontrol etmek mümkün. Örneklerde aynı parametrelerinde sisteminden yararlanır. Arkadaşlarımız amp: ve pan:’i hatırlayalım.

Örnekleri Amp’leme

Örneklerin genliğini synth’ler için kullandığımız aynı yöntemle değiştirebilirsiniz:
sample :ambi_lunar_land, amp: 0.5
Örnekleri Pan’leme
Örnekler üzerinde pan: kullanmak da mümkün. Örneğin, şu şekilde “amen” örneğini sol kulaktan çalıp yarısına gelindiğinde sağ kulaktan da çalmaya başlamayı sağlayabilirsiniz:

sample :loop_amen, pan: -1
sleep 0.877
sample :loop_amen, pan: 1

Dikkat ediniz ki 0.877 :loop_amen örneğinin saniye cinsinden uzunluğunun yarısıdır.

Son olarak, eğer birkaç use_synth_defaults kullanarak birkaç varsayılan ayar belirlediyseniz (ki bunu daha sonra göreceğiz), bu ayarlar sample tarafından görmezden gelinecektir.
 
3.3 – Örnekleri genişletme

Müzik yaratmak için birçok synth ve örnek oynatabilmeyi öğrendiğimize göre, bunları nasıl modifiye ederek müziğimizi ilginç ve benzersiz kılabileceğimize bir bakalım. Öncelikle örnekleri yayma (stretch) ve sıkıştırma (squash)‘ya bakalım.

Örneklerin Gösterimi

Örnekler önceden kaydedilmiş, sayılar biçiminde saklanan seslerdir ve bu sayılar hoparlörün kozasının sesi çıkarmak için nasıl hareket edeceğini tanımlar. Koza içeri veya dışarı hareket edebilir, yani sayılar yalnızca kozanın ne kadar içeri veya dışarı hareket etmesi gerektiğini belirtir her bir birim zaman için. Sonic Pi saniyede binlerce sayı değerini bilgisayarınızın hoparlörüne doğru zamanda aktararak doğru sesi elde etmeyi sağlar. Fakat sayıların hoparlöre aktarıldığı hızı değiştirerek sesi değiştirmek de eğlenceli bir yöntemdir.
“Hız” (Rate) Değiştirme 

Haydi şu ses üzerinde oynayalım :ambi_choir. Varsayılan hızı değiştirmek için sample’a rate: seçeneği uygulayabilirisiniz:

sample :ambi_choir, rate: 1

Bu onu normal hızda çalar. Fakat o sayıyı istediğimiz sayıya çevirebiliriz. Örneğin 0.5:

sample :ambi_choir, rate: 0.5

Wow! Neler oluyor? Aslına bakarsanız iki şey: İlki, örneğin çalma süresi iki katına çıkıyor, ikincisi ses bir oktav aşağıdan çalıyor. Detayına girecek olursak…
Haydi Genişletelim

Genişletip sıkıştırması eğlenceli bir örneklerden biri “Amen Break”tir. Normal hızında onu bir drum ‘n’ bass parçasına eklediğimizi hayal edebiliriz:

sample :loop_amen

Fakat hızını değiştirerek müziğin üslubunu değiştirebiliriz. old school hip-hop tarzı için yarım hızı deneyin: 

sample :loop_amen, rate: 0.5

Hızlandırırsak jungle bölgesine girmiş oluruz:

sample :loop_amen, rate: 1.5

Son parti şakamız – Bakalım eksi bir hız kullanınca ne olacak:
sample :loop_amen, rate: -1
Woah! tersten oynatılıyor!  Şimdi diğer değerleri deneyin ve ne çılgınlıklar yapabileceğinizi keşfedin.

 
3.4 – Kılıflı Örnekler

ADSR kılıfı kullanarak örneklerin müddeti ve genliğini kontrol etmek mümkün. Fakat örnekler için olan ADSR kılıfları synth’ler için farklı çalışır. Örneklerde kılıflar yalnızca müddeti ve genliği azaltmakta kullanılabilir. Örnek ise çalmayı ya bittiğinde ya da kılıf sona erdiğinde kesecektir. Yani oldukça uzun bir release: değeri girerseniz, örneğin süresi uzatılmayacaktır.
Amen Kılıfları
 “Amen Break” adlı dostumuza dönelim:
sample :loop_amen

hiçbir seçenek olmadan, tüm örneği tam seste duyarız. Örneğin bir saniye süresince artarak girmesini istersek attack: parametresini kullanabiliriz:

sample :loop_amen, attack: 1

Veya daha kısa bir giriş için:
sample :loop_amen, attack: 0.3
Otomatik sürdürmek

ADSR kılıfının farklı olduğu kısım sürdürme (sustain) değeriyle alakalı. Standart kılıfta varsayılan sürdürme değeri 0’dır. Örneklerde ise bu değer sihirli bir değere sahiptir: örneğin kalanı için gereken süreye. Soni Pi akıllıca bu değeri hesaplar ve herhangi bir attack, decay veya release değerini göz önünde bulundurarak kullanır.

Azalarak çıkma

Yukarıda anlatılanı keşfetmek için “Amen Break” i inceleyelim. Sonic Pi’ a uzunluğunu sorduğumuzda:
print sample_duration :loop_amen

Basacağı değer 1.753310657596372’dur ki bu örneğin saniye cinsinden uzunluğudur. Eğer release’i 0.75’e ayarlarsak şaşırıtcı bir şey gerçekleşecektir:

sample :loop_amen, release: 0.75

Örneğin ilk bir saniyesi tam seste çalacak, kalanı ise 0.75 saniyelik bir sürede azalarak bitecektir. Bu otomatik sürdürme özelliğidir.Kurulduğu üzere release her zaman sondan hesaplanır. Örnek 10.75 saniye olduğu takdirde ilk 10 saniye tam çalar ve son 0.75 saniye yine azalarak gider.

Azalarak/Yükselerek girme ve çıkma
Hem attack: hem release:’i birlikte kullanarak örneğin hem yükselerek girmesi hem de azalarak çıkmasını sağlayabiliriz.

sample :loop_amen, attack: 0.75, release: 0.75

Şarkının tüm uzunluğu 1.75 saniye olduğu için, attack ve release toplamı 1.5 olacak, ve sürdürma ise otomatik olarak kalan 0.25 saniyeye eşit olacaktır.
Explicit sustain
We can easily get back to our normal synth ADSR behaviour by manually setting sustain: to a value such as 0:
sample :loop_amen, sustain: 0, release: 0.75Copy
Now, our sample only plays for 0.75 seconds in total. With the default for attack: and decay: at 0, the sample jumps straight to full amplitude, sustains there for 0s then releases back down to 0 amplitude over the release period - 0.75s.
Percussive cymbals
We can use this behaviour to good effect to turn longer sounding samples into shorter, more percussive versions. Consider the sample :drum_cymbal_open:
sample :drum_cymbal_openCopy
You can hear the cymbal sound ringing out over a period of time. However, we can use our envelope to make it more percussive:
sample :drum_cymbal_open, attack: 0.01, sustain: 0, release: 0.1Copy
You can then emulate hitting the cymbal and then dampening it by increasing the sustain period:
sample :drum_cymbal_open, attack: 0.01, sustain: 0.3, release: 0.1Copy
Now go and have fun putting envelopes over the samples. Try changing the rate too for really interesting results.
 
3.5 - Partial Samples

Bu kısım ile Sonic Pi’daki örnek oynatıcıyı incelemeyi tamamlıyoruz. Tekrar hatırlatalım. Şimdiye dek örnekleri nasıl çalacağımıza baktık:
sample :loop_amen

Sonra da onların hızını nasıl değiştireceğimizi gördük, yarı hızda çalmak gibi:
sample :loop_amen, rate: 0.5

Sonra şarkıyı nasıl yükselerek girecek şekilde ayarlayacağımızı:
sample :loop_amen, rate: 0.5, attack: 1

Ayrıca bir örneğin başını nasıl vurgulu bir şekilde çalabileceğimizin sustain:’e belli bir değer biçip attack ve release’i kısa değerler şeklinde ayarlanmasıyla elde edildiğini öğrendik: 

sample :loop_amen, rate: 2, attack: 0.01, sustain: 0, release: 0.35

Yine de, her zaman örneğin başından başlamak zorunda olmasak daha iyi olmaz mıydı? Veya sonunda bitirmek zorunda olmasak?
Başlangıç noktası seçme
Örneği keyfi bir başlangıç noktasından başlatmak 0 ile 1 arasında bir başlangıç değeri atamakla mümkün. 0, şarkının başlangıcı; 1, bitişi ve 0.5 ise tam ortası demektir. Şimdi “Amen Break”in yalnızca son yarısını oynatmayı deneyelim:
sample :loop_amen, start: 0.5

Son çeyreğine ne dersiniz:
sample :loop_amen, start: 0.75
Bitiş noktası seçme 
Benzer biçimde, örnek için belirli bir bitiş noktası seçmek de mümkün. Amen Break’i yarıda keselim:
sample :loop_amen, finish: 0.5
Başlangıç ve Bitişi Belirtme
Tabiki ikisini birleştirerek örneğin belirli bir kısmını da çaldırabiliriz. Mesela ortalarda küçük bir bölümünü:
sample :loop_amen, start: 0.4, finish: 0.6

Ya başlangıç noktasını bitişten sonraki bir değer olarak seçersek ne olur?
sample :loop_amen, start: 0.6, finish: 0.4

Havalı! Şarkı tersten çalıyor.
Hız ile birleştirmek

rate: adlı arkadaşımızı belirli bir kesimi seçtiğimiz bu özelliğe entegre edebiliriz. Örneğin ortalardan bir kısmı yavaşça çalmak için:

sample :loop_amen, start: 0.5, finish: 0.7, rate: 0.2
Kılıflarla birleştirmek
Son olarak hepsini ADSR kılıflarımızla birleştirerek ilginç sonuçlar elde edebiliriz:
sample :loop_amen, start: 0.5, finish: 0.8, rate: -0.2, attack: 0.3, release: 1

 
3.6 – Dışarıdan Örnek Kullanma 
Sonic Pi ile yüklü gelen örnekler hızlıca başlamanız için yardımcı olsa da, başka kaydedilmiş sesler ile de çalışmayı denemek isteyebilirsiniz. Buna geçmeden önce eserinizin taşınabilirliği üzerine konuşalım.
Taşınabilirlik
Şarkınızı tamamen yerleşik synth ve örnekler kullanarak yaparsanız, müziğinizi çoğaltmak için tek gereken şeyin güvenle kodunuz olduğunu belirtebiliriz. Bu harika. Böylece müziğinizi oldukça kolayca kodu paylaşarak yayabilirsiniz.

Ancak, kendi önceden kaydedilmiş örneklerinizi kullanırsanız, bu özelliği kaybedersiniz. Zira müziğinizi çoğaltmak için diğer insanların yalnızca kodunuza değil, örneklerinize de ihtiyacı olacaktır. Bu da diğerlerinin sizin müziğinizi manipüle etme, mixleme ve üzerinde denemeler yapmasını zorlaştıracaktır. Tabi ki kendi örneklerinizi kullanmaktan alı koymasın bu sizi, yalnızca aklınızda bulunması gereken bir durum.
Yerel örnekler
Peki, bilgisayarınızdan nasıl belirli bir WAV, AIFF, veya FLAC dosyasını çalabilirsiniz? Tek yapmanız gereken dosya dizinini sample’a atmak olacaktır:

# Raspberry Pi, Mac, Linux
sample "/Users/sam/Desktop/my-sound.wav"
# Windows
sample "C:/Users/sam/Desktop/my-sound.wav"

Sonic Pi otomatik olarak parçayı yükleyip çalacaktır. Ayrıca standart parameterelden de aynı şekilde yararlanabilirsiniz:

# Raspberry Pi, Mac, Linux
sample "/Users/sam/Desktop/my-sound.wav", rate: 0.5, amp: 0.3
# Windows
sample "C:/Users/sam/Desktop/my-sound.wav", rate: 0.5, amp: 0.3

