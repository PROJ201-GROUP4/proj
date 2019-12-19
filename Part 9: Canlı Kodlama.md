# Canlı Kodlama

Sonic Pi'ın en eğlenceli yönlerinden biri de size canlı bir şekilde müzik yazma ve değiştirme fırsatı vermesi, canlı bir gitar performansı gibi. Canlı kodlamanın öbür avantajı ise müziği oluştururken geri bildirim alabilmek (örneğin basit bir döngü yaratıp ses istediğiniz hale gelene kadar üzerinde oynamak gibi). Ancak, asıl avantajı sahneye Sonic Pi ile çıkıp ortamı hareketlendirmeye başlayabilmeniz.

Bu bölümde kodunuzu dinamik performanslara çevirmenin gerekliliklerini göreceğiz.

Sıkı tutunun...

Evet şu an eğlenebilmemizi sağlayacak kadar Sonic Pi öğrendik. Bu bölümde önceki bütün bölümlerden parçalar alıp sizin canlı olarak kendi müziğinizi bestelemenizi ve bunu bir şova çevirmenizi sağlayacağız. Bunun için 3 ana unsura ihtiyacımız var:

  - Ses oluşturan kod yazma becerisi - Hazır!
  - Fonksiyon yazma becerisi - Hazır!
  - Adlandırılmış "thread" kullanma becerisi - Hazır!

Tamamdır, hadi başlayalım. İlk seslerimizi canlı kodlayalım. Öncelikle çalmak istediğimiz kodu içeren bir fonksiyona ihtiyacımız var. Ayrıca bu fonksiyonu çağırıcağımız bir döngüye ihtiyacımız var
```
define :my_loop do
  play 50
  sleep 1
end

in_thread(name: :looper) do
  loop do
    my_loop
  end
end 
```
Eğer bu size karmaşık geliyorsa, geriye gidin, thread ve fonksiyonlarla ilgili bölümleri tekrar okuyun. Eğer bu başlıkları kafanızda oturtabildiyseniz zaten karmaşık gelmemiştir.
Yukarıda 50. notayı çalan ve 1 vuruş boyunca uyuyan bir fonksiyonumuz var ve :looper adını verdiğimiz bir "thread" bu my_loop fonksiyonunu durmadan çağırıp döngüye sokuyor.
Eğer bu kodu çalıştırırsanız 1 vuruş arayla kendini durmadan tekrar eden 50. notayı duyacaksınız.

### Kodu Değiştirmek
İşte eğlence tam olarak burada başlıyor. Bir önceki bölümdeki kod çalışmaya devam ederken 50 yi farklı bir sayıya, diyelim ki 55, çevirip tekrar çalıştır butonuna bastığınızda ses değişir.Canlı olarak!

Bu yaptığımız işlem yeni bir katman oluşturmadı çünkü kullandığımız adlandırılmış "thread" aynı ada sahip bir tane çalıştırmaya izin veriyor. Ayrıca, ses değişti çünkü fonksiyonu yeniden tanımladık. :my_loop fonksiyonuna yeni bir tanım verdik ve :looper bir sonraki çalışımızda yeni tanımı çalmaya başladı.

Tekrar değiştirmeyi deneyin, notayı ve uyuma süresini değiştirin.Ya da yeni bir birleştirici ekleyin. Örneğin kodumuzu şu hale getirelim:
```
define :my_loop do
  use_synth :tb303
  play 50, release: 0.3
  sleep 0.25
end 
```
Şu an ses daha ilgi çekici geliyor, fakat bunu daha ilgi çekici hale getirebiliriz. Her seferinde aynı notayı çalmak yerine bu sefer bir akor çalmayı deneyelim:
```
define :my_loop do
  use_synth :tb303
  play chord(:e3, :minor), release: 0.3
  sleep 0.5
end 
```
Peki ya bu akordan farklı notalar çalsak:
```
define :my_loop do
  use_synth :tb303
  play choose(chord(:e3, :minor)), release: 0.3
  sleep 0.25
end 
```
Son olarak da biraz davul ekleyelim:
```
define :my_loop do
  use_synth :tb303
  sample :drum_bass_hard, rate: rrand(0.5, 2)
  play choose(chord(:e3, :minor)), release: 0.2
  sleep 0.25
end 
```
İşte şimdi işler daha eğlenceli hale geliyor!
Ancak hemen fonksiyonlar ve "thread"'ler kullanıp canlı kodlamaya başlamadan önce bir sonraki bölümde canlı döngüler (live_loop) bölümünü de okuyun, Sonic Pi'daki kodlama şeklinizi tamamen değiştirecek...

## Canlı Döngüler

Pekala, bu bölüm tam bir cevher. Eğer sadece bir bölüm okuyacaksanız o bölüm bu olmalı. Eğer canlı kodlamanın gereklilikleri bölümünü okuduysanız canlı döngü (live_loop) daha fazla kod yazma gerektirmeden oradakileri yapmanın yolu.

Eğer bir önceki bölümü okumadıysanız, live_loop Sonic Pi ile coşmanın en iyi yolu.
Hadi çalalım. Aşağıdaki kodu yeni bir kanala yaz:
```
live_loop :foo do
  play 60
  sleep 1
end 
```
Şimdi Çalıştır tuşuna bas. Her vuruşta basit bir bip sesi duyuyorsun, hiç eğlenceli değil. Ancak henüz Dur butonuna basma. 60'ı 65 haline getir ve tekrardan Çalıştır butonuna bas.
Vay canına bir vuruş bile kaçırmadan ses otomatik olarak değişti. İşte bu canlı kodlama!
Neden daha bas haline getirmiyosun? Sadece çalarken kodunu güncelle:
```
live_loop :foo do
  use_synth :prophet
  play :e1, release: 8
  sleep 8
end
```
Şimdi Çalıştır butonuna bas.
Biraz davul ekleyelim:
```
live_loop :foo do
  sample :loop_garzul
  use_synth :prophet
  play :e1, release: 8
  sleep 8
end 
```
Notayı e1'den c1 e değiştir:
```
live_loop :foo do
  sample :loop_garzul
  use_synth :prophet
  play :c1, release: 8
  sleep 8
end 
```
Şimdi beni takip etmeyi bırak ve kendi başına bi şeyler dene! Eğlenmene bak!

## Çoklu Canlı Döngüler
Aşağıdaki döngüyü gözden geçirelim:
```
live_loop :foo do
  play 50
  sleep 1
end 
```
Neden :foo adına ihtiyaç olduğunu merak etmiş olabilirsin. Bu isim önemli çünkü döngünün diğer döngülerden farklı olduğunu belirtiyor.

_Aynı ada sahip iki döngü asla aynı anda çalışamaz._ 

Bu da eğer birden fazla döngünün aynı anda çalmasını istiyorsak onlara farklı isimler vermemiz gerektiğini gösteriyor.
```
live_loop :foo do
  use_synth :prophet
  play :c1, release: 8, cutoff: rrand(70, 130)
  sleep 8
end

live_loop :bar do
  sample :bd_haus
  sleep 0.5
end 
```
Şimdi iki döngüyü de özgürce geliştirebilir ya da değiştirebilirsin ve bir sıkıntı yaşamazsın.

### Canlı Döngüleri Senkronize Etmek

Çoktan fark etmişsinizdir ki canlı döngüler otomatik olarak sıra mekanizmasıyla birlikte çalışıyor. Biz de bu sıraları senkronize ederek bir şeyi durdurmamız gerekmeden uyumlu hale getirebiliriz.
Şu düzgün senkronize edilmemiş kodu göz önünde bulunduralım:
```
live_loop :foo do
  play :e4, release: 0.5
  sleep 0.4
end

live_loop :bar do
  sample :bd_haus
  sleep 1
end 
```
Bakalım zamanlamayı kodu durdurmadan düzeltebilecek miyiz. Öncelikle, :foo döngüsündeki sleep komutunu 1 ile uyumlu hale getirelim, 0.5 işimizi görücektir:
```
live_loop :foo do
  play :e4, release: 0.5
  sleep 0.5
end

live_loop :bar do
  sync :foo
  sample :bd_haus
  sleep 1
end
```
Vay canına, her şey çok daha uyumlu çalıştı - hiç bir şeyi durdurmadan.
Şimdi git ve canlı döngüler ile canlı kodla!

### Tiklemek

Canlı kodlama yaparken kendinizi bolca çembersel bi şekilde döngü oluştururken bulacaksınız. Melodi oluşturmak için notalarla, ritim oluşturmak için uyuma komutlarıyla, vb.

#### Tikleyen Çemberler
Sonic Pi size çemberle oluşturabilmeniz için "tik sistemi" denilen çok kullanışlı bir araç sağlıyor. Çemberler hakkında konuştuğumuz bölümde sürekli artan bir sayaçtan bahsetmiştik, tıpkı anlık vuruş sayısı gibi. Tik sistemi aynı şeyi çemberlerde yapabilmemizi sağlıyor. Aşağıdaki örneğe bir göz atalım:
```
counter = 0
live_loop :arp do
  play (scale :e3, :minor_pentatonic)[counter], release: 0.1
  counter += 1
  sleep 0.125
end 
```
Bu kod parçası aşağıdaki ile aynı işlemi yapmaktadır:
```
live_loop :arp do
  play (scale :e3, :minor_pentatonic).tick, release: 0.1
  sleep 0.125
end 
```
Burada sadece E3 minör skalasını alıyor ve her elementi sırayla çalıyoruz. Bu işlem skala belirttikten sonra ".tick" ekleyerek yapılıyor. Bu tik kullanıldığı canlı döngüye aittir, yani her canlı döngünün kendi tik'i olabilir:
```
live_loop :arp do
  play (scale :e3, :minor_pentatonic).tick, release: 0.1
  sleep 0.125
end

live_loop :arp2 do
  use_synth :dsaw
  play (scale :e2, :minor_pentatonic, num_octaves: 3).tick, release: 0.25
  sleep 0.25
end 
```
### Tik
"Tick"'i aynı zamanda standart bir değer olarak kullanıp index haline getirebiliriz:
```
live_loop :arp do
  idx = tick
  play (scale :e3, :minor_pentatonic)[idx], release: 0.1
  sleep 0.125
end
```
Ancak, sonuna ".tick" komutu kullanarak tik oluşturmak daha mantıklıdır. "Tick"'i farklı bir tanınma atamak çember dışında bir şey için kullanılacağı zaman daha yararlı olmaktadır.

### Bak

Tick'in diğer bir muhteşem yanı ise her seferinde yeni bir değer döndürmekten de öte, her çağırıldığında "bir sonraki değeri" vermesidir. Dosyalardaki diğer "tick" örneklerine bakarak başka kullanım yöntemlerini de görebilirsin. Ancak, şimdilik önemli olan nokta bazen anlık "tick" değerini görmek istememiz ve bunun için "look" komutunu kullanabilmemiz. Bunu başka bir değere look atayarak ya da çemberin sonuna ".look" ekleyerek sağlayabiliriz.

### Tikleri İsimlendirmek

Bazen bazı döngülerde birden fazla "tick"e ihtiyacın olabilir, bu durumlarda tick'lerine farklı isimler vermelisin:
```
live_loop :arp do
  play (scale :e3, :minor_pentatonic).tick(:foo), release: 0.1
  sleep (ring 0.125, 0.25).tick(:bar)
end 
```
Yukarıda verilen kod parçasında birden fazla tick komutumuz var ve bunların düzgün çalışabilmesi için bu komutlara farklı isimler vererek birbirinden bağımsız hale getirmemiz gerekiyor.

#### Fazla Karmaşıklaştırmayın
Tik sisteminin çoğu gücü kullanmaya yeni başladığınızda pek işinize yaramaz. Her şeyi bu bölümde deneyip öğrenmeye çalışmayın. Sadece tek bir çemberde tik sistemini kullanmaya yoğunlaşın. Bu size yeterli eğlenceyi ve tik sistemini kullanmanın kolaylığını anlamanızı sağlayacaktır.







