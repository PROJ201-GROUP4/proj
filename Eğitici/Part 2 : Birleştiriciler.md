# PART 2: BİRLEŞTİRİCİ

  Tamam bu kadar intro yeterli. Biraz sese bakalım

  Bu bölümde brleşlerin (synth) çalıştırılması ve değiştirilmesini inceleyeceğiz. Brleş,ses çıkaran bir şey için süslü bir kelime olan 
  birleştiricinin kısaltılmış hali.
  Genelde brleşleri kullanmak biraz komplikedir, özellikle Eurorack modülleri gibi analog brleşler bir kablo karmaşası ile birbirlerine
  bağlandığı için bizi zor duruma sokar. Fakat, Sonic Pi bize bu brleşleri daha basit ve ulaşılabilir bir şekilde sunmaktadır.

  Sonic Pi arayüzünün basitliğine aldanmayın. Eğer ses üzerinde daha sofistike değişiklikler yapmayı planlıyorsanız göründüğünden
  çok daha derinlere gidebilirsiniz.Kemerlerinizi bağlayın!

## PART 2.1: İLK BİPLERİNİZ
  Aşağıdaki koda bakın:
  ```
  play 70
  ```
  İşte her şey burada başlıyor.Durma, kodu kopyalayıp uygulamanın üstündeki pencereye yapıştır (Çalıştır butonunun altındaki büyük 
  beyaz boşluk).Şimdi, Çalıştır butonuna bas.
  
  BİP!
  
  Etkileyici.Tekrar bas. Ve tekrar. Ve tekrar...
  
  Vay, şahane. Eminim bunu bütün gün yapabilirsin. Ama dur, kendini sonsuz bir bip döngüsünde kaybetmeden önce, sayıyı değiştirmeyi dene
  ```
  play 75
  ```
  Aradaki farkı duydun mu ? Daha düşük bir sayı dene: 
  ```
  play 60
  ```
  Gördüğün üzere, daha düşük sayılar daha kalın sesler çıkarırken yüksek sayılar daha ince sesler çıkarıyor. Tıpkı piyano gibi,
  piyanonun sol tarafındaki tuşlar kalın ve sağ tarafındaki tuşlar ince sesler çıkarıyor. Ayrıca kullandığımız sayılar aslında piyanodan
  bağımsız değil. play 47 aslında piyanodaki 47. notayı çal anlamına geliyor. Bu da demek oluyor ki play 48 bir nota yükseltiyor.
  
  4. oktavdaki C akoru 60 numaraya denk geliyor. Hadi çalmayı dene: 
  ```
  play 60
  ```
  Merak etme eğer bu şu an sana bir şey ifade etmiyorsa, ilk başladığımda bana da bir şey ifade etmiyordu. Şu an tek önemli olan
  düşük sayıların kalın yüksek sayıların ince sesler çıkardığını bilmen.
  
###  AKORLAR
  
  Nota çalmak bir miktar eğlenceli, ama bir kaçını aynı anda çalmak çok daha iyi.Dene bakalım:
  ```
  play 72
  play 75
  play 79
  ```
  Jazımsı! Sonuç olarak, birden fazla play yazdığında, hepsi aynı anda çalıyor. Kendin dene, hangi notalar birlikte güzel hangileri 
  de berbat ses çıkarıyor. Gözlemle, araştır ve kendin için bul.
  
### MELODİ
  
  Evet, nota ve akor çalmak eğlenceli, ama melodi çalmak? Ya notaları aynı anda değil de arka arkaya çalmak istiyorsan? Bu da kolay
  sadece notalar arasında uyumalısın (sleep):
  ```
  play 72
  sleep 1 
  play 75
  sleep 1 
  play 79
  ```
  Ne kadar güzel, minik bir arpej. Peki sleep 1 komutundaki 1 ne demek? Bu sayı uyuma süresi anlamına geliyor. Tam olarak 1 darbe
  süresinde uyumak anlamına geliyor. Arpejimizi daha hızlı yapmak istiyorsak ne yapmalıyız? O zaman da daha kısa uyku komutları
  kullanmalıyız. Yarısını (0.5) kullanmaya ne dersiniz.
  ```
  play 72
  sleep 0.5
  play 75
  sleep 0.5
  play 79
  ```
  Nasıl daha hızlı çaldığını fark ettin mi? Şimdi kendin dene, zamanı değiştir - farklı zaman ve notalar kullan.
  
  Denenebilecek başka bir şey de play 52.3 ve play 52.63 gibi ara notalar çalmak. Bütün notalara takılı kalmaya hiç gerek yok.
  Biraz dene ve eğlenmene bak.
  
###  GELENEKSEL NOTA İSİMLERİ
  
  Birazcık müzik bilgisi olanlar olarak (eğer değilseniz de önemli değil, eğlenmek için bilmenize gerek yok) C ve F# gibi nota isimleri
  kullanarak melodi yazmak isteyebilirsiniz. SonicPi arkanızda! Aşağıdaki şekilde yapabilirsiniz
  ```
  play :C
  sleep 0.5
  play :D
  sleep 0.5
  play :E
  ```
  Notanızın pembe olması için harften önce ":" koymayı unutmayın. Ayrıca notanın ardından sayı ekleyerek kullanmak istediğiniz
  oktavı belirtebilirsiniz.
  ```
  play :C3
  sleep 0.5
  play :D3
  sleep 0.5
  play :E4
  ```
  Eğer bir notayı daha tiz yapmak isterseniz nota harfinden sonra "s" eklemeyi deneyin, play :Fs3 gibi ve bemol yapmak isterseniz
  "b" ekleyin, play :Eb3 gibi.
  
  Şimdi kendini kaybet ve kendi tonlarını yapmanın tadını çıkar!
  
 ## Birleştirici Ayarları: Genlik ve Pan
  İstediğiniz notayı çalmanıza izin verdiği gibi, SonicPi ses oluşturmanız ve sesi kontorl etmeniz için size bir sürü seçenek sunuyor. Bunların bir çoğunu bu öğreticide anlatacağız. Şimdilik sadece en yararlı ikisini açıklayacağız: _genlik_ ve _pan_. Önce gelin bunların ne olduğuna bakalım.
  
 ### Seçenekler
  
  Sonic Pi birleştiricileri için bir sürü seçeneği desteklemektedir. Seçenekler "play" kodu ile çaldığınız ve kulağımıza gelen sese etki eder. Her birleştiricinin sesi güzelleştirmek için kullanılan kendine özel seçenekleri vardır. Ancak, "amp:" gibi bazı seçenekler bir çok sese etki eder.
  
  Seçeneklerin iki büyük parçası vardır, isimleri ve değerleri. Örneğin, "peynir:" adında bir seçeneğiniz olabilir ve bunun değerini 1'e eşitlemek isteyebilirsiniz.
  Seçenekler "play" kodundan sonra virgül kullanılarak çalıştırılır.
 ``` 
 play 50, peynir: 1
  ```
  (peynir: gerçek bir seçenek değil, sadece örnek göstermek için kullandık.)
  
  Virgül kullanarak birden fazla seçenek çağırabilisiniz:
 ``` 
 play 50, peynir: 1, fasulyeler: 0.5
 ```
  Seçeneklerin sırası fark etmiyor, peynir ve fasulyelerin yerini değiştirebilirsiniz.
  
  Birleştiriciler tarafından tanınmayan seçenekler görmezden gelinir (saçma seçenek isimleri olan peynir ve fasulyeler gibi!)
  
  Eğer bir seçeneği yanlışlıkla birden fazla kez kullanırsanız son çağırdığınız değer uygulanır.
  ```
  play 50, fasulyeler: 0.5, peynir: 1, yumurtalar: 0.1, fasulyeler: 2
  ```
  Sonic Pi'daki çoğu şey seçenekleri kabul ediyor, bu yüzden seçenekleri öğrenmek için birazcık zaman ayırmanız kullanmanıza yeticektir. Şimdi biraz ilk seçeneğimiz "amp:" ile oynayalım!
  
  ### Genişlik
  
  Genişlik sesin yüksekliğinin bilgisayarda gösterilmiş halidir. _Yüksek genişlik yüksek ses_ ve _düşük genişlik düşük ses_ yaratır. Zaman ve notaları belirtirmiş gibi, Sonic Pi genişlik değerlerini belirtmek için de sayılar kullanır. 0 genişlik sessizliğe neden olur (hiçbir şey duyamazsın) ve 1 de sesi normal yükseklik değerinde çalar. Genişliği 2, 10, 100 bile yapabilirsin. Ancak seslerin genişliği çok yüksek olursa, Sonic Pi bir kompresör ile bu sesleri bastırarak kulakların zarar görmesini engeller. Bu durum sesin boğuk ve garip çıkmasına sebep olabilir. Bu yüzden düşük genişlikler kullanmayı deneyin. Bu bastırmayı önlemek için 0 ile 0.5 arasındaki genişlikleri tercih edin.
  
  Sesin genişliğini değiştirmek için, amp: seçeneğini kullanabilirsiniz. Örneğin yarım genişlikte çalmak için 0.5'i kullanın.
  ```
  play 60, amp: 0.5 
  ```
  Sesin genişliğini iki katına çıkarmak için 2 kullanın.
  ```
  play 60, amp: 2
  ```
  "amp:" seçeneği sadece çağırıldığı "play" komutunun genişliğini değiştirir. Diğer "play" komutlarına etki etmez.
  ```
  play 60, amp: 0.5 
  sleep 0.5 
  play 65
  ```
  Tabi ki her "play" komutu için farklı bir amp: değeri kullanabilirsiniz.
  ```
  play 50, amp: 0.1
  sleep 0.25
  play 55, amp: 0.2
  sleep 0.25
  play 57, amp: 0.4
  sleep 0.25
  play 62, amp: 1
 ```
  ### Pan
  Kullanması keyifli bir diğer seçeneğimiz ise sesin çıkış kaynağını kontrol eden "pan:" komutu. Sesi sola yönlendirmek sesi sol hoparlörden, sağa yönlendirmek ise sesi sağ hoparlörden duymak anlamına gelir. Sonic Pi'da sesi tamamen sona yönlendirmek için "-1", ortada tutmak için "0" ve sağa yönlendirmek için "1" değerlerini kullanırız. Ancak tabi ki -1 ve 1 arasındaki herhangi bir değeri kullanabiliriz.
  
  Şimdi bir sesi sol hoparlörden çalalım:
  ```
  play 60, pan: -1
  ```
  Şimdi ise sağ hoparlörden çalalım:
  ```
  play 60, pan: 1
  ```
  Son olarak da iki hoparlörü birlikte kullanalım:
  ```
  play 60, pan: 0
  ```
  Evet artık gidip sesi yönlendirmenin tadını çıkarabilirsin!
  
  ## Birleştiricileri Değiştirmek
  Şu ana kadar bipler oluştururken yeterince eğlendik. Ancak büyük ihtimalle klasik bip sesinden sıkılmaya başladın. Sonic Pi'ın tek sunduğu bu mu? Tabi ki canlı kodlamada sadece bip sesleri çalmaktan daha fazlası var ve bu bölümde Sonic Pi'ın bize sunduğu diğer heyecan verici sesleri keşfedeceğiz.
  
  ### Birleştiriciler
  Sonic Pi birleştirici diye adlandırdığı bir sürü enstrüman içeriyor. Örneğin örnekler (samples) önceden kaydedilmiş sesler içeriyor, birleştiriciler nasıl kontrol ettiğinize göre yeni sesler oluşturabiliyor (bunu bu bölümde detaylı bir şekilde inceleyeceğiz). Sonic Pi'da bulunan birleştiriciler oldukça güçlü ve bunları keşfedip denerken oldukça fazla eğleneceksiniz. Öncelikle kullanılması için bir birleştiriciyi nasıl seçeceğimizi öğrenelim.
  
  Bu güzel seslerden biri _saw wave_ - gelin deneyelim:
  ```
  use_synth :saw
  play 38
  sleep 0.25
  play 50
  sleep 0.25
  play 62
  ```
  Peki ya iki sesi karıştırmaya ne dersin? Önce biri sonra diğeri:
  ```
  use_synth :saw
  play 38
  sleep 0.25
  play 50
  sleep 0.25
  use_synth :prophet
  play 57
  sleep 0.25
  ```
  Şimdi aynı anda:
  ```
  use_synth :tb303
  play 38
  sleep 0.25
  use_synth :dsaw
  play 50
  sleep 0.25
  use_synth :prophet
  play 57
  sleep 0.25
  ```
  Fark ettiğiniz üzere "use_synth" komutu sadece ondan sonraki "play" komutlarına etki ediyor. Bunu büyük bir şalter gibi düşünün, "play" komutu ona hangi birleştirici işaret ediyorsa onun sesini çıkarır. Bu şalteri yeni bir birleştiriciye "use_synth" komutu ile işaret edebilirsiniz.
  
  ### Birleştiricileri Keşfetmek
  Sonic Pi'ın size hangi birleştiricileri sunduğunu görmek için ekranın altındaki yardım penceresindeki Birleştirici seçeneğini kullanabilirsiniz. Seçmek için 20den fazla seçeneğin bulunuyor. Benim favorilerim aşağıda:
  - :prophet
  - :dsaw
  - :fm
  - :tb303
  - :pulse
  Şimdi biraz müziğin sırasında birleştiriciler arasında geçiş yapmanın tadını çıkar!
  
  ## Sesi Kontrol Et!
  
  Önceki bölümlerde "sleep" komutu ile seslerin arasındaki boşlukları nasıl ayarlayıp kullanabileceğimizi öğrenmiştik. Ancak şu ana kadar seslerin çalma süresini kontrol etmemiştik.
  
  Sonic Pi bize iki oldukça yararlı kontrol mekanizması sağlıyor:
  -sesin süresini ayarlamak
  -sesin genişliğini ayarlamak
  
  ### Süre
  Süre çaldığımız sesin çalmaya devam ettiği uzunluğu belirtiyor. Daha büyük bir uzunluk sesi daha uzun süre boyunca duyacağımız anlamına geliyor.
  
  ### Genişlik
  
  Her duyulabilir ses sessiz başlar ve biter ve bu iki süre içerisinde sessiz olmayan bölümler içerir. Bu sessiz olmayan bölümlerin ses yüksekliklerini değiştirebilirsiniz. Tıpkı gitar amfisinin sesini kısıp açmak gibi. Örneğin sessiz başlayıp, yavaşça ses seviyesini maksimuma çıkarıp o durumda beklettikten sonra hızlıca ses seviyesini 0'a çekmek gibi. Şimdi bu ses ayarlarına bir göz atalım.
  
  ### Salınım Etabı
  
  Özellikle belirtilmesi gerekmeden çalışan tek ses ayarı salınım süresidir. Bu birleştiricinin oluşturduğu sesin kesilmesi için geçen süredir. Bütün birleştiriciler için bu süre 1 vuruştur (60 BPM'de 1 saniye):
  ```
  play 70
  ```
  Bu nota 1 saniye boyunca duyulabilir. Hadi durma, say bakalım.
  ```
  play 60, release: 2
  ```
  Burada ise aynı ses 2 saniye boyunca duyulabilir.
  
  ### Atak Etabı
  
  Özellikle belirtilmedikçe bu ayar 0'dır yani ses yüksekliği 0'dan 1'e direk yükselir. Ancak siz sesin yavaşça yüksekliğinin artmasını istiyor olabilirsiniz. Bunun için "attack:" opsiyonunu deneyebilirsiniz. Bir deneyelim:
  ```
  play 60, attack: 2
  sleep 3
  play 65, attack: 0.5
  ```
  Birden fazla özelliği aynı anda kullanabilirsiniz. Örneğin kısa bir atak ve uzun bir salınım için şu kodu dene:
  ```
  play 60, attack: 0.7, release: 4
  ```
  ### Devamlılık Etabı
  
  Atak ve salınım süresini spesifik bir şekilde belirleyebildiğin gibi, aynı zamanda sesin devam edeceği süreyi de belirleyebilirsin. Bu sesin maksimum yükseklikte çalacağı süreyi belirtir.
  ```
  play 60, attack: 0.3, sustain: 1, release: 1
  ```
  Devamlılık süresi daha güzel bir giriş veya çıkış yapabilmek için oldukça önemlidir. Tabi ki attack: ve release: özelliklerini 0 yapıp sesi daima maksimum genişlikte çalabilirsiniz, fakat salınım süresinin 0 olması sesin güzel duyulmamasına yol açabilir bu yüzden 0.2 gibi düşük bir değer kullanmak daha mantıklı olur.
  
  ### Düşüş Etabı
  
  Ekstra bir kontrol olarak aynı zamanda düşüş süresi de belirtebilirsiniz. Bu etap atak ve salınım etabı arasında olup sesin atak seviyesinden düşüş seviyesine indiği süreyi belirtir. Özellikle belirtilmediği sürece decay: seçeneğinin değeri 0'dır ve hem atak hem düşüş seviyesi 1'dir bu yüzden düşüş etabının görülebilmesi için bu seviyelerin spesifik olarak belirlenmesi gerekmektedir.
  ```
  play 60, attack: 0.1, attack_level: 1, decay: 0.2, sustain_level: 0.4, sustain: 1, release: 0.5
  ```
  ### Düşüş Seviyesi
  Özellikle belirtilmediği sürece düşüş seviyesi devamlılık seviyesi ile aynıdır fakat siz düşüş seviyesini tam kontrol elde etmek için farkı değerlere eşitleyebilirsiniz.
  ```
  play 60, attack: 0.1, attack_level: 1, decay: 0.2, decay_level: 0.3, sustain: 1, sustain_level: 0.4, release: 0.5
  ```
  ## Özet
  Kısaca özetlemek gerekirse ses ayarlarımız şunlardır:
  1. attack - sesin genişliğinin 0'dan attack_level'a çıktığı süre,
  2. decay - genişliğin attack_level'dan decay_level'a giderken geçen süre,
  3. sustain - genişliğin decay_level'dan sustain_level'a giderken geçen süre,
  4. release - genişliğin sustain_level'dan 0'a inerken geçen süre
  
  Çaldığımız sesin süresinin üstte belirtilen ses ayarlarının sürelerinin toplamı olduğunu bilmek önemli bir detay. Örneğin altta verilen örneğin süresi 0.5 + 1 + 2 + 0.5 = 4 vuruştur:
  ```
  play 60, attack: 0.5, attack_level: 1, decay: 1, sustain_level: 0.4, sustain: 2, release: 0.5 
  ```
  
  
  
  
  
  
  
  
