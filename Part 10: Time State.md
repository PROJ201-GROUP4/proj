# 10 – Zaman Halleri
Çoğu zaman çeşitli threadler (iş parçaları) veya canlı döngüler arasında paylaşılan bilgiler içermek faydalı olacaktır. Örneğin, kullanılan anahtarı, BPM’i veya ‘karmaşıklık’ gibi daha soyut bilgileri paylaşmak isteyebilirsiniz. Yani, bir kodu başkalarıyla paylaştığımızda onlarınçalıştırınca ne duyacağını bildiğimizden emin olmak isteyeceksiniz. Kısım 5.6’nın sonunda neden değişkenler kullanarak threadler arası paylaşım yapmamamız gerektiğine kısaca değinmiştik. 

Sonic Pi’ın bu soruna çözümü ise global değişkenlerle kolayca çalışmayı sağlayan Time State (Zaman halleri) adlı özgün yöntemidir. Bu biraz karmaşık duyulabilir. Fakat tıpkı ilk notanızı çalmak gibi, Sonic Pi threadler arası hal paylaşımını oldukça kolay bir şekilde yapmanıza olanak sağlayacaktır, programınız hala deterministik koşullarla çalışacak şekilde tabi. 
get ve set ile tanışın.
 
10.1 – Set (Belirlemek) ve Get (Al)
Sonic Pi Time State adı verilen global hafıza deposuna sahiptir. Bununla yapabileceğiniz iki ana kullanımı bilgi set ‘lemek ve onu get ‘lemektir. 
Set (Belirlemek)
Time State içerisinde veri saklamak için iki şeyi bilmemiz gerekir:
1.	Saklamak istediğimiz bilgiyi,
2.	O veri için özgün bir isim (anahtar – key)

Örneğin, 3000 sayısını :intensity anahtarı ile saklamak istediğimizi varsayalım. set fonksiyonu ile bu mümkün:

set :intensity, 3000

Anahtarımız için herhangi bir ismi kullanabiliriz. Eğer o anahtar kelimeyle saklanan bir değer çoktan varsa, aynı kelime ile yeni bir değer atamak eski değerin üstüne yazacaktır.
set :intensity, 1000
set :intensity, 3000
Yukarıdaki örnekte, aynı anahtar kelimealtındaiki değer tutmaya çalıştığımız için, son set fonksiyonundaki değer kazanır. :intensity kelimesi ile saklanan değer 3000 olacaktır. 
Get (Al)
Time State içerisindeki bir veriyi çekmek ve kullanmak için ise bize o veriyi set ‘lerken kullanılan anahtar gerekir, ki son örnekte bu :intensity ‘dir. Şimdi tek yapmamız gereken get[:intensity] kodunu çalıştırmaktır. Sonucu yazdırarak sistem günlüğünde görebiliriz:

print get[:intensity] #=> prints 3000

Aklınızda bulunsun, set ile belirlenen bir veri aynı anahtar kelime ile değiştirilene veya Sonic Pi kapatılana kadar kayıtlı kalacaktır. 
Çoklu Threadler
Time State sisteminin bir avantajı da farklı threadler ve döngüler arasında güvenle kullanılabilmesidir. Örneğin, bir döngünüzde Time State’e yeni bir değişken tanımlayabilir, diğerinde de ona erişip kullanabilirsiniz. 
live_loop :setter do
  set :foo, rrand(70, 130)
  sleep 1
end

live_loop :getter do
  puts get[:foo]
  sleep 0.5
end



get and set ‘i threadler arası kullanmanın kullanmanın iyi taraflarından birisi de oynat’a her bastığınızda aynı sonucu elde edecek olmanızdır. Durmayın, deneyin:

{run: 0, time: 0.0}
 └─ 125.72265625

{run: 0, time: 0.5}
 └─ 125.72265625

{run: 0, time: 1.0}
 └─ 76.26220703125

{run: 0, time: 1.5}
 └─ 76.26220703125

{run: 0, time: 2.0}
 └─ 114.93408203125

{run: 0, time: 2.5}
 └─ 114.93408203125

{run: 0, time: 3.0}
 └─ 75.6048583984375

{run: 0, time: 3.5}
 └─ 75.6048583984375

Böylece kodumuzu her oynatanın aynı sonucu elde ettiğinden emin olabiliriz. 
A Simple Deterministic State System
Öğreticinin 5.6 kısmında neden değişken kullanmanın deterministik ve tekrar edilebilir kod yazmaktan alıkoyduğunu görmüştük:
##
## Bu kodu çalıştırırsanız 
## basılan listenin her zaman
## sıralı olmadığını göreceksiniz!

a = (ring 6, 5, 4, 3, 2, 1)

live_loop :shuffled do
  a = a.shuffle
  sleep 0.5
end

live_loop :sorted do
  a = a.sort
  sleep 0.5
  puts "sorted: ", a
end

 get ve set kullanarak ise bu problemin nasıl çözülebileceğine bakalım:

## Bu kod çalışırken
## basılan liste daima sıralı olur
set :a, (ring 6, 5, 4, 3, 2, 1)

live_loop :shuffled do
  set :a, get[:a].shuffle
  sleep 0.5
end

live_loop :sorted do
  set :a, get[:a].sort
  sleep 0.5
  puts "sorted: ", get[:a]
end

Dikkat ederseniz iki kod varyasyonu neredeyse aynı. Fakat ikinciyi çalıştırdığınızda Sonic pi’ın Time State sistemi sayesinde her çalıştığında aynı sonucu üreteceğinden emin olabilrsiniz. 

 
10.2 – Sync (Eşzamanlama)

5.7. kısım cue ve sync fonksiyonlarının threadlerin senkronizasyonunu ayarlamakta nasıl kullanıldığını işlemiştik. Fakat o kısımda belirtilmeyen şey bunun Time State sistemi sayesinde mümkün kılındığıydı. set aslında cue ‘nun bir varyasyonudur ve üzerine inşa edilmiş bir fonksiyondur, ayrıca Time State’e ekleyeceğimiz herhangi bir bilginin de senkronize edilmesini sağlar.
Event (olay) için Bekleme
Şimdi sync  fonksiyonunun Time State’e eklenecek yeni eventler için beklemesini nasıl sağlayacağımızı görelim: 

in_thread do
  sync :foo
  sample :ambi_lunar_land
end

sleep 2

set :foo, 1

Bu örnekte ilk olarak :foo event’inin Time State’e. Eklenmesini bekleyen bir threa oluşturduk. Sonra 2 vuruş bekleyip :foo ‘yu 1 olarak set ‘ledik. Bu komut sync ‘i tamamlamış olur ve thread bir sonraki komuta geçerek :ambi_lunar_land sample’ını çalmaya başlar.
Aklınızda bulunsun, sync her zaman gelecek eventleri bekler ve mevcut thread’i durdurur. 
Geleceğe değer atamak
Yukarıdaki örnekte :foo ‘yu 1 olarak belirleyip onunla hiçbir şey yapmamıştık. Bu değeri sync kullanarak mevcut thread içerisinden çekebiliriz:

in_thread do
  amp = sync :foo
  sample :ambi_lunar_land, amp: amp
end

sleep 2

set :foo, 0.5

set ve cue ile belirlenen değerlerin thread-uyumlu olması gerektiğine dikkat edin – yani statik (değiştirilemez) ringler, sayılar, semboller veya sabit string’ler. Öbür türlü Sonic Pi erör verecektir. 
 
10.3 – Model Eşleme
Time State’e veri yüklerken veya çekerken daha kompleks anahtarlar kullanmak da mümkün. Path (yol) denilen, URL stilinde stringler de kullanabilirsiniz "/foo/bar/baz" gibi.
Pathlerle çalışmaya başladığınızda Sonic Pi’ın sofistike model eşleştirme sistemi ile birebir path sunmak yerine benzer pathler kullanarak kolayca erişebiliriz.
Herhangi bir path parçası eşleştirme
3 parçalı bir path’e sahip bir event gelene kadar beklemek istediğimizi farz edelim:
sync "/*/*/*"
Bu kod, isimlerinden bağımsız olarak 3 parçalı herhangi bir path argümanını kabul edecektir. Mesela:
•	cue "/foo/bar/baz"
•	cue "/foo/baz/quux"
•	cue "/eggs/beans/toast"
•	cue "/moog/synths/rule"

Fakat daha fazla veya az parçalı pathler kale alınmayacaktır. Bunlar aramamızla örtüşmeyecektir:
•	cue "/foo/bar"
•	cue "/foo/baz/quux/quaax"
•	cue "/eggs"
Her * , herhangi bir içeriğe tekabül eder. Tek parçalı pathleri /* şeklinde veya 5 parçalıları /*/*/*/*/* şeklinde eşleştirebiliriz.
Kısmi parçaları eşleştirme
Eğer path’in bir parçasının adının nasıl başladığını veyabittiğini biliyorsak, bildiğimiz kısma ek olarak * kullanıp bulunmasını sağlayabiliriz. Misal: "/foo/b*/baz" komutu ilk parçası foo, üçüncüsü baz ve ikincisi ise b ile başlayan herhangi bir path ile örtüşecektir. Yani bunlarla örtüşebilir:
•	cue "/foo/bar/baz"
•	cue "/foo/baz/baz"
•	cue "/foo/beans/baz"
Fakat bunlarla uyuşmaz:
•	cue "/foo/flibble/baz"
•	cue "/foo/abaz/baz"
•	cue "/foo/beans/baz/eggs"
Aynı şekilde * başa da konulabilir, böylece bitişi bilinen bir path de aranılabilir. Örnek: 
"/foo/*zz/baz" 
İç içe gecik path parçaları eşleştirme
Bazen path’in kaç parçadan oluştuğunu bilmiyor olabiliriz. Bu durumda oldukça güçlü çift yıldızdan faydalanabiliriz: ** , şu şekilde: "/foo/**/baz" Bu ise bunlarla eşleşir:
•	cue "/foo/bar/baz"
•	cue "/foo/bar/beans/baz"
•	cue "/foo/baz"
•	cue "/foo/a/b/c/d/e/f/baz"
Tek harf eşleştirme
? karakterini kullanarak bilinmeyen tek bir karakterin eşleşmesini sağlayabilirsiniz. "/?oo/bar/baz" bunlarla eşleşecektir:
•	cue "/foo/bar/baz"
•	cue "/goo/bar/baz"
•	cue "/too/bar/baz"
•	cue "/woo/bar/baz"
Çoklu kelime eşleştirme
Bir kısmın birkaç alternatif kelimeden biri olacağını biliyor iseniz, { ve } semboller arasında bu seçenekleri listeleyebilirsiniz. "/foo/{bar,beans,eggs}/quux" yalnızca bu üçüyle eşleşir:
•	cue "/foo/bar/quux"
•	cue "/foo/beans/quux"
•	cue "/foo/eggs/quux"
Birden çok harf eşleştirme
Son olarak, birkaç harften birisiyle eşleştirmek istediğiniz kısma harf listesini [ ve ] semboller arasında belirtebilirsiniz. "/foo/[abc]ux/baz" yalnızca bunlarla eşleşir:
•	cue "/foo/aux/baz"
•	cue "/foo/bux/baz"
•	cue "/foo/cux/baz"
Ayrıca – karakteri ile bir harf aralığı da belirleyebilirsiniz. "/foo/[a-e]ux/baz" yalnızca bunlarla eşleşir:
•	cue "/foo/aux/baz"
•	cue "/foo/bux/baz"
•	cue "/foo/cux/baz"
•	cue "/foo/dux/baz"
•	cue "/foo/eux/baz"
Eşleştiricileri birlikte kullanma
sync veya get kullanırken yukarıdakileri istediğiniz gibi birleştirmekte özgürsünüz. Çılgın bir örnek inceleyelim:

in_thread do
  sync "/?oo/[a-z]*/**/ba*/{quux,quaax}/"
  sample :loop_amen
end

sleep 1

cue "/foo/beans/a/b/c/d/e/bark/quux/"
OSC Model Eşleştirme
Merak edenler eşleştirme prensipleri ve eşleşmenin nasıl gerçekleştiğine dair daha detaylı bilgiye bu linkten erişebilir: http://opensoundcontrol.org/spec-1_0

