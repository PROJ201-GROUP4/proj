# 8 – Veri Yapıları

Veri yapısı bir programcının alet takımında bulunan çok faydalı bir araçtır.

Bazen birden fazla şeyi temsil etmeniz ve kullanmanız gerekebilir. Örneğin, birbiri ardına çalan bir dizi notaya sahip olmayı daha kullanışlı bulabilirsiniz. Programlama dilleri tam olarak bunu yapmanızı sağlayacak veri yapılarına sahiptir.

Programcılara sunulan çok sayıda heyecan verici ve egzotik veri yapısı var- ve insanlar her zaman yeni veri yapıları icat edip bu sunulan yelpazeyi genişletiyor. Bununla beraber bizim şimdilik  basit veri yapısı olan listelerini inceleyeceğiz.

Şimdi listelere giriş yapıcaz. Listelerin temel biçimlerini ve ölçek ve akorları temsil ederken nasıl kullanıldığını ele alacağız.




## 8.1 - Listeler

Bu bölümde çok kullanışlı bir veri yapısı olan listeleri inceleyeceğiz. Rastgele sıralama bölümünde listeden çalmak için rastgele nota seçerken kısaca listelere değinmiştik.

play choose([50, 55, 62])


Bu bölümde ölçek ve akorları temsil ederken kullanabiliceğimiz listeleri inceleyeceğiz. Öncelikle, nasıl akorun nasıl çalındığını tekrar edelim. Unutmayın ki eğer sleep fonksiyonunu kullanmazsak yazdığımız bütün sesler aynı anda duyulur.

play 52
play 55
play 59

Bu kodu yazabiliceğimiz başka yollar da var. Şimdi onlara göz atalım.



### Bir Listeyi Oynatmak:

Bütün notaları bir listenin içine yerleştirebiliriz: [52, 55, 59]. Daha sonrasında bu listenin başına play fonksiyonunu yazmamız yeterlidir.

play [52, 55, 59]


Böyle yazıldığında daha rahat okunur bir kod elde etmiş oluyoruz. Ayrıca notaların listeye koyularak çalınması diğer parametrelerin kullanılmasını da engellemez.

play [52, 55, 59], amp: 0.3


Aynı zamanda geleneksel nota isimlerini de kullanabilirsiniz.

play [:E3, :G3, :B3]



### Bir Listeye Erişmek:

Listelerin bir diğer kullanışlı özelliği ise içerisinden bilgiyi alabilmemizdir. Bu kullağınıza biraz garip gelebilir ama aslında birinin size kitaptan 23. sayfayı açmanızı söylemesiyle aynıdır. Listelerde 23. indekste bulunan elemanın ne olduğunu öğrenebilirisiniz. Tek garip kısmı programlamada listelerin 1 yerine 0 ile başlamasıdır.

Liste indekslerinde 1,2,3 gibi saymak yerine 0,1,2 diye sayılır.

Aşağıdaki listeye göz atalım:

[52, 55, 59]


Bunda korkulacak hiçbir şey yok. Şimdi, listenin 2. elemanı nedir? Listenin 2. elemanı 55`tir. Şimdi bilgisayar bizim için bu cevabı verebilecek mi ona bakalım.

puts [52, 55, 59][1]


Eğer daha önce böyle bir şey görmediyseniz bu size biraz garip gelebilir. Ama bana güvenin görüldüğü kadar zor değil. Yukardaki satır üç parçadan oluşmaktadır : puts kelimesi ; 52, 55 ve 59`dan oluşan liste ve indeks [1].Öncellikle  Sonic Pi`yın sistemde cevabı yazdırmasını istediğimiz için puts kullanıyoruz. Daha sonra listeyi yazıyoruz ve son olarak yazdığımız indeks ile ikinci elemanının ne olduğunu soruyoruz. İndeksi köşeli parantez içine yazmamız lazım çünkü sayma işlemi 0`dan başlıyor,örneğin  ikinci eleman için olan indeks 1`dir.

#indexes:  0   1   2
           [52, 55, 59]


puts [52, 55, 59] [1] kodunu çalıştırmayı deneyin, sonucun 55 olduğunu görüceksiniz. İndeksi değiştirerek, listeyi daha uzun bir liste haline getirerek listeleri nasıl kodunuzda kullanabiliceğinizi deneyin. 




## 8.2 - Akorlar

Sonic Pi akor isimlerini içinde barındırır ve bu akorları liste olarak döndürür.

play chord(:E3, :minor)


Bu normal listelerden daha hoş görünüyor ( ve bazı insanlar için okunması daha kolay.) Şimdi Sonic Pi`yın içinde başka hangi akorları barındırdığına bakalım.

•	chord(:E3, :m7)
•	chord(:E3, :minor)
•	chord(:E3, :dim7)
•	chord(:E3, :dom7)



### Arpej:

play_pattern fonksiyonunu kullanarak akorları kolayca arpeje çevirebiliriz.

play_pattern chord(:E3, :m7)


Yukardaki örneğin çok yavaş çaldığını görüyoruz. play_pattern fonksiyonu listedeki her nota için play fonksiyonunu çağırmadan önce sleep 1 fonksiyonuyla birbirinden ayırıyor. Zamanlamayı ayarlamak için  ve hızı arttırmak için fonksiyonunu play_pattern_timed kullanabilirsiniz.

play_pattern_timed chord(:E3, :m7), 0.25


Hatta, zamanlamayla ilgili bir liste yaparak yaptığımız zamanlama listesini döngü şeklinde koda ekleyebilriz.

play_pattern_timed chord(:E3, :m13), [0.25, 0.5]


Bu fonksiyon aynı zamanda aşağıdaki fonksiyona denktir:

play 52
sleep 0.25
play 55
sleep 0.5
play 59
sleep 0.25
play 62
sleep 0.5
play 66
sleep 0.25
play 69
sleep 0.5
play 73

Hangi şekilde yazmayı tercih edersiniz?




## 8.3 - Ölçekler

Sonic Pi bize çok geniş bir ölçek aralığı sunar. C3 major ölçeğini çalmaya ne dersiniz?

play_pattern_timed scale(:c3, :major), 0.125, release: 0.1


Hatta daha oktavını değiştirebiliriz.

play_pattern_timed scale(:c3, :major, num_octaves: 3), 0.125, release: 0.1


Peki, bütün notaların pentatonik ölçekte çalmasına ne dersiniz?

play_pattern_timed (scale :c3, :major_pentatonic, num_octaves: 3), 0.125,
  release: 0.1


###  Random notalar:

Akorlar ve ölçekler, random bir seçeneği anlamlı bir hale getirmek için çok güzel yoldur.

use_synth :tb303
loop do
  play choose(chord(:E3, :minor)), release: 0.3, cutoff: rrand(60, 120)
  sleep 0.25
end


Akor isimlerini ve kesme aralığını değiştirmeyi deneyin.


### Akorları ve Ölçekleri Keşfetmek

Sonic Pi`yın sitesinde  hangi ölçek ve akorları içinde barındırdığını bulabilirsiniz.

## 8.4 - Rings

Standart listelerin bir diğer ilginç özelliği ringlerdir. Önceden programlama dili öğrendiyseniz ring buffers ve ring arrays kavramlarıyla 
karşılaşmışsınızdır. Biz kısaca bunlardan ringler olarak bahsedeceğiz.

Daha önceki bölümlerde indeks mekanizmasını kullanarak bir listeden nasıl istedğimiz bir elemanı elde edebiliceğimizi gördük.

puts [52, 55, 59][1]

Peki, 100. indeksi istersek ne olur? Görüldüğü üzere 100. indekste bir eleman yok. Sadece 3 elemanın olduğu bir listemiz var. Bu drurumda
Sonic Pi  nil döndürür. nil hiçbir şey anlamına gelir.

Bununla birlikte, elimizde bir sayaç olduğunu düşünelim.

counter = 0
notes = [52, 55, 59]

Elimizdeki bu sayacı liste içerisindeki bir notaya ulaşmak için kullanabiliriz.

puts notes[counter]

Şu an elimizde 52 var. Peki sayacımızın içindeki rakamı arttırısak ne olur?

counter = (inc counter)
puts notes[counter]

Çok iyi, şimdi de 55 elde ettik eğer bunu tekrar yaparsak da 59 elde ederiz. Peki 59 elde ettikten sonra tekrar aynı işlemi uygularsak ne
olur. Listemizdeki sayılar bittiği için bize nil verir. Peki ya bir şekilde listenin başına dönseydik ve her şey baştan başlasaydı? İşte bu
ringlerin ortaya çıktığı yer.



### Ring Yaratmak

İki şekilde ring yaratabiliriz. Ring fonksiyonu ile beraber ringin elemanları olucak sayıları parametre olarak alabilirirz.

(ring 52, 55, 59)

Ya da bir listenin sonuna .ring ekleyerek o listeyi bir ringe çevirebiliriz.

[52, 55, 59].ring


### Ringleri İndeksleme

Elinizde bir ringiniz varsa bunu listeyei kullandığınız gibi kullanabilirsiniz. Tek farkı indeksleme olayıdır. Ringin büyüklüğüne bağlı kalmak 
zorunda değilsiniz. İsterseniz büyüklüğünden daha büyük indeksler yazabilirsiniz isterseniz negatif indeksler yazabilirsiniz. Bütün indeksler
size ringten bir eleman vericektir.

(ring 52, 55, 59)[0] #=> 52
(ring 52, 55, 59)[1] #=> 55
(ring 52, 55, 59)[2] #=> 59
(ring 52, 55, 59)[3] #=> 52
(ring 52, 55, 59)[-1] #=> 59



### Ringleri Kullanma

Hali hazırdaki vuruşun numarasını göstermek için değişkenleri kullanıyoruz. Onun dışında ringlerin içinden notayı almak için ya da bunun gibi
kullanışlı olan bir şey yapmak için indeks kullanabiliriz.



### Ölçek ve Akorlar de Ringtir

Bilmemiz gereken bir diğer önemli şey ise ölçek ve akorları sunan listelerin birer ring olmasıdır. İndeks kullanarak bu listelerin içindeki
ölçek ve akorlara ulaşabilirsiniz.


### Ring Yapıcılar

ring fonksiyonu dışında da bize ring inşa edebilicek fonksiyonlar var.

->range sizi başlangıç ve bitiş noktasını ve adım ölçüsünü belirlemeye davet eder.
->bools 1`leri ve 0`ları kullanarak kısa ve öz bir şekilde boolean kullanımını sağlar.
->knit tekrarlanan değerler dizisini birbiri ardına bağlamanızı sağlar.
->spread Euclidean dağılımıyla bool ringleri yaratır.

## 8.5 - Ring Zincirleri

ring ve spread gibi yapıcılar dışında yeni bir ring oluşturmanın diğer bir yolu ise elimizde bulunan ringleri kullanarak yeni bir ring oluşturmaktır.


### Zincir Komutları

Bu komutları keşfetmek için aşağıdaki basit ring`i ele alalım.

(ring 10, 20, 30, 40, 50)

Peki ya bu ringi ters çevirmek istiyorsak ne yapmalıyız? Bir zincir komutu olan .reverse`ü ringin sonuna ekleyerek ringi tersten okuyabiliriz.

(ring 10, 20, 30, 40, 50).reverse  #=> (ring 50, 40, 30, 20, 10)

Peki ya ringteki ilk üç değeri istiyorsak?

(ring 10, 20, 30, 40, 50).take(3)  #=> (ring 10, 20, 30)

Son olarak, peki ya ring içindeki elemanların rastgele yerlerini değiştirmek istiyorsak?

(ring 10, 20, 30, 40, 50).shuffle  #=> (ring 40, 30, 10, 50, 20)


### Çoklu Zincirler

Yeni ring yaratmak için çok güçlü bir yoldur. Ama asıl gücü zincire birkaç tane komut eklendiğinde gelir.

Ringin içindeki elemanların yerlerini değiştirmeye sonra bir tanesini ringten çıkarmaya ve son olarak  3 elemanla yeni bir ring kurmaya ne 
dersiniz?

(ring 10, 20, 30, 40, 50) - ilk ringimiz
(ring 10, 20, 30, 40, 50).shuffle - yer değiştirir - (ring 40, 30, 10, 50, 20)
(ring 10, 20, 30, 40, 50).shuffle.drop(1) - ilk elemanı ringten çıkarır - (ring 30, 10, 50, 20)
(ring 10, 20, 30, 40, 50).shuffle.drop(1).take(3) - ilk üç elemanla yeni ring oluşturur- (ring 30, 10, 50)

Yukarda sadece komutları kullanarak yeni bir zincirler yarattık.Bu şekilde hiç yoktan ringler elde edebiliriz.

### Değişmezlik

Bu ringlerin güçlü ve önemli birtakım özellikleri var. Değişmezlik özellikleri vardır. Bu bu bölümde öğrendiğimiz zincir methodları ringleri değiştirmez
onun yerine yeni ringler yarattır. Bu threadler boyunca ring paylaşmada özgür olma ve başka bir thread`i etkilemeden aynı ringi kullanarak onları threadle zincirleyebilme
özgürlüğüne sahip oladuğu anlamına gelir.

### Sonic Pi`da bulunan Zincir Methodları

Çalabiliceğiniz zincir methodlarına örnekler;

.reverse - bir ringin tersini verir
.sort - sıralanmış bir ring yaratır
.shuffle - değerlerin yer değiştirdiği bir ring yaratır
.pick(3) - .choose u 3 kere çağırarak ortaya çıkan bir ring döndürür
.pick - .pick(3)ye benzerdir sadece olağan hali orjinal ringle aynı olmalıdır
.take(5) - sadece ilk 5 elemanı içeren yeni bir ring döndürür
.drop(3) - ilk 3 eleman hariç bütün elemanları bulunduran yeni bir ring döndürür
.butlast - son elemanı çıkararak yeni bir ring döndürür
.drop_last(3) - son 3 elemanı çıkararak yeni bir ring döndürür 
.take_last(6)- sadece son 6 elemanın olduğu yeni bir ring döndürür
.stretch(2) - ringteki her elemanı iki kere tekrar eder
.repeat(3) - bütün ringi 3 kere tekrar eder
.mirror - ringin ters halini ringin kendisine ekler 
.reflect - mirror gibidir fakat ortanca değeri tekrarlamaz 
.scale(2) - bütün elemanları 2 ile çarparak yeni bir ring döndürür



