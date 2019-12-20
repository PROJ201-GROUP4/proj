## 5.5 Fonksiyonlar

Kod yazmaya başladığınız zaman, yazdığınız kodları daha toplu ve anlaşılılabilir yazmak için yollar arasınız. 
Fonksiyonlar bu konuda size yardımcı olacak çok güçlü bir yoldur. Fonksiyonlar elimizdeki bir grup koda isim vermemizi sağlar.
Haydi fonksiyonları inceleyelim.


### Fonksiyonları Tanımlamak:
```
define :foo do
  play 50
  sleep 1
  play 55
  sleep 2
end
```
Yukarıda ismi foo olan yeni bir fonksiyon tanımladık. Bu işlemi eski arkadaşımız do/end bloğu ve define fonksiyonuyla yaptık.
Define fonksiyonu sonrasında da fonksiyona vermek istediğimiz ismi yazdık. Fonksiyona foo ismini vermek zorunda değilsiniz. 
Anlamlı ya da anlamsız herhangi bir isim verebilirsiniz ama anlamlı bir isim vermeniz işinizi daha kolaylaştırabilir.

Fonksiyonunuzun başına : işaretini koymayı unutmayın.


### Fonksiyonları Çağırmak
```
define :foo do
  play 50
  sleep 1
  play 55
  sleep 0.5
end

foo

sleep 1

2.times do
  foo
end
```
Yarattığımız fonksiyonu istersek tekrarlama bloklarının içinde kullanabiliriz istersek play ya da sample fonksiyonlarının yazdığı 
herhangi bir yerde kullanabiliriz. Bu, bizim kendimizi ifade etmemiz için güzel bir yol sunar ve bestemizde kullanmak için anlamlı
kelimeler yaratmamızı sağlar.



## 5.6 Değişkenler

Bir şeyler için isim yaratmak, yazdığımız kod için yapabiliceğimiz kullanışlı bir şeydir. Sonic Pi bu durumu çok kolaylaştırır: kullanmak istediğin ismi yazıyorsun ve eşittir işaretini (=) koyarak hatırlamak isteğin şeyi yazıyorsun:

```
sample_name = :loop_amenCopy
```

Şimdi, sample_name değişkenini yazdığımız zaman :loop_amen sembolünü hatırlıyoruz. Bundan sonra :loop_amen i kulanmak istediğimizde sample_name değişkenini kullanabiliriz. Örneğin:

```
sample_name = :loop_amen
sample sample_nameCopy
```
Sonic Pi da değişkenleri kullanmamızın üç temel sebebi var: iletişimin anlamı, tekrarları yönetmek ve bir şeylerin sonucunu yakalamak.

## İletişimin Anlamı

Kod yazdığınız zaman bilgisayara bir şeyleri nasıl yapması gerektiğini söylemeyi düşünmek kolaydır. ( Bilgisayar anladığı sürece sıkıntı yok.) Ama kodu okuyanın sadece bilgisayar olmadığını hatırlamamız gerekiyor. İnsanlarda bu kodu okuyabilir ve kodun niye yazıldığını anlamaya çalışabilir. Ayrıca sizde yazdığınız kodu daha sonradan tekrar okumak isteyebilirsiniz ve kodu hangi amaçla yazdığınızı anlamak isteyebilirsiniz. Size kodun amacı çok bariz gelse bile diğer insanlar için hatta ilerideki siz için bile kafa karıştırıcı olabilir.

Başkalarının okurken kodunuzu anlamasını sağlayacak bir diğer yöntem ise yorum yazmak. Diğer bir yöntem ise anlamlı değişken isimleri kullanmak. Şu örneğe bir bakın:`
```
sleep 1.7533Copy
```
Neden 1.7533 sayısını kullandık? Bu sayı nerden geldi? Ne demek? Aşağıdaki koda bakalım:

```
loop_amen_duration = 1.7533
sleep loop_amen_durationCopy
```
Şimdi neden 1.7533 olduğunu daha iyi anlayabiliyoruz: Bu sample :loop_amen in süresi! Tabii ki niye basit bir şekilde yazmadığımızı sorabilirsiniz:
```
sleep sample_duration(:loop_amen)Copy
```
Tabii ki bu da kodun amacını gösteren güzel bir iletişim yöntemi.

### Tekrarları Yönetmek
Genellikle kodunuzda çok fazla tekrar görürsünüz ve tekrar eden kodun içerisinden bir şeyi değiştirmek istediğinizde çok fazla yerde değişim yapmak zorunda kalırsınız. Aşağıdaki koda bir bakalım:
```
sample :loop_amen
sleep sample_duration(:loop_amen)
sample :loop_amen, rate: 0.5
sleep sample_duration(:loop_amen, rate: 0.5)
sample :loop_amen
sleep sample_duration(:loop_amen)Copy
```

:loop_amen ile çok fazla şey yapıyoruz. Peki ya başka bir sample la yazdığımız kodun nasıl duyulduğunu merak edersek? Mesela :loop_amen yerine :loop_garzul kullanmak istersek? :loop_amenin olduğu bütün yerleri bulup :loop_garzulla değiştirmemiz gerekir. Eğer çok fazla vaktiniz varsa bu yöntemle yapabilirsiniz ama ya bir sahnede performans gösteriyorsanız? Bazen zaman lüksünüz olmayabilir özellikle insanların dans etmeye devam etmesini istiyorsanız.


Peki ya kodu bu şeklide yazsanız:
```
sample_name = :loop_amen
sample sample_name
sleep sample_duration(sample_name)
sample sample_name, rate: 0.5
sleep sample_duration(sample_name, rate: 0.5)
sample sample_name
sleep sample_duration(sample_name)Copy
```

Gördüğünüz gibi yukarıdaki kodla aynı sesi çıkarıyor. Hatta  sadece bir satırı değiştirerek :loop_amen yerine :loop_garzulu çalmamızı sağlıyor. Değişkenlerin büyülü özelliği sayesinde birden fazla yerde çalan sample ı değiştirmiş oluyoruz.

## Sonuçları Yakalamak

Sonunda, bir şeylerin sonucunu yakalarken değişkenleri kullanma konusunda bir motivasyonumuz var. Örneğin bir sample süresince bir şeyler yapmak isteyebilirsiniz:
```
sd = sample_duration(:loop_amen)Copy
```
Şimdi sd yi :loop_amen sample ını kullanmak istediğimiz yer yere yazabiliriz.

Hatta , değişken bizim play ya da sample çağrılarının sonucunu yakalamımızı sağlar:
```
s = play 50, release: 8Copy
```

s bir değişken olarak elimizde ki bu da bize synth yürütülürken onu kontrol etmemizi sağlar:

```
s = play 50, release: 8
sleep 2
control s, note: 62Copy
```

Daha sonraki bölümlerde synthleri kontrol etmeye daha detaylı bakacağız.

### Uyarı: Değişkenler ve Threadler 

Her ne kadar değişkenler bir şeylere isim vermek için ve bir şeylerin sonucunu yakalamak için kullanışlı da olsa threadlerde local bir şekilde  kullanılması gerektiklerini unutmamak önemlidir. Örneğin, bunu yapmayın:
```
a = (ring 6, 5, 4, 3, 2, 1)

live_loop :shuffled do
  a = a.shuffle
  sleep 0.5
end

live_loop :sorted do
  a = a.sort
  sleep 0.5
  puts "sorted: ", a
endCopy
```
Yukarıdaki örnekte a değişkenine bir sayı halkası atarız ve sonra iki ayrı live_loops içinde kullanırız. Her 0,5 saniyede ilk canlı döngüde, halkayı sıralar (((1, 2, 3, 4, 5, 6))) ve ardından günlüğe yazdırırız. Kodu çalıştırırsanız, yazdırılan listenin her zaman sıralanmadığını görürsünüz. Bu sizi şaşırtabilir - özellikle de bazen liste sıralı olarak basılır, bazen de değil. Buna deterministik olmayan davranış denir ve yarış koşulu olarak adlandırılan oldukça kötü bir sorunun sonucudur. Sorun, ikinci canlı döngünün de listeyi (bu durumda karıştırmak) manipüle etmesi ve listenin yazdırıldığı zamana göre, bazen sadece sıralandı ve bazen karıştırıldı. Her iki canlı döngü de aynı değişkenden farklı bir şey yapmak için yarışıyor ve her seferinde farklı bir döngüde 'kazanıyor'.

Bunun iki çözümü var. Öncellikle, çoklu looplarda ve treadlerde aynı değişkeni kullanmayın. Örneğin her loopun kendine özel değişkeni varsa kod her zaman sıralı bir liste yazdırıcaktır:

```
live_loop :shuffled do
  a = (ring 6, 5, 4, 3, 2, 1)
  a = a.shuffle
  sleep 0.5
end

live_loop :sorted do
  a = (ring 6, 5, 4, 3, 2, 1)
  a = a.sort
  sleep 0.5
  puts "sorted: ", a
endCopy
```
Ama, bazen treadler arasında bazı şeyleri paylaşmak isteyebiliriz. Örneğin current key, BPM, synth vb. Bu durumlarda, Sonic Pi yın güvenli thread durum sistemini çözüm olarak kullanabiliriz. Bu konu 10. bölümde tartışılıcak.

## 5.7 Thread Senkronizasyonu

Yeterince gelişmiş bir anda bir dizi fonksiyon ve iş parçacığı ile canlı kodlama yaptıktan sonra, onu öldüren iş parçacıklarından birinde hata yapmanın oldukça kolay olduğunu fark etmişsinizdir. Bu hiç önemli değil çünkü Run'ı tıklatarak iş parçacığını kolayca başlatabilirsiniz. Ancak, iş parçacığını yeniden başlattığınızda, şimdi özgün iş parçacıkları ile zaman aşımına uğradı.

### Kalıtsal Zaman
Daha önce tartıştığımız gibi, in_thread ile oluşturulan yeni konular, ana dizinin tüm ayarlarını devralır. Bu şimdiki zamanı içerir. Bu, aynı anda başlatıldığında, ipliklerin her zaman birbirleriyle zaman içinde olduğu anlamına gelir.

Ancak, bir iş parçacığını kendi başına başlattığınızda, şu anda çalışan diğer iş parçacıklarından biriyle eşit olması muhtemel olmayan kendi zamanıyla başlar.

### Çağrı ve Zaman Uyumu

Sonic Pi, cue ve sync işlevleriyle bu soruna bir çözüm sunar.

cue, diğer tüm konulara kalp atışı mesajları göndermemizi sağlar. Varsayılan olarak, diğer başlıklar ilgilenmez ve bu kalp atışı iletilerini görmezden gelir. Ancak, senkronizasyon işleviyle kolayca ilgi çekebilirsiniz.

Dikkat edilmesi gereken en önemli şey, senkronizasyonun, mevcut iş parçacığını bir süre boyunca herhangi bir şey yapmasını engellediği için uykuya benzer olmasıdır. Ancak, uyku ile ne kadar süre bekleyeceğinizi, ne kadar süre bekleyeceğinizi bilemeyeceğinizi, ne kadar süre bekleyeceğinizi bilmiyorsunuz - eşitleme, yakında veya uzun bir süre uzakta olabilecek başka bir diziden gelecek olan ipucunu bekler.

Bunu biraz daha ayrıntılı olarak inceleyelim:
```
in_thread do
  loop do
    cue :tick
    sleep 1
  end
end

in_thread do
  loop do
    sync :tick
    sample :drum_heavy_kick
  end
endCopy
```
Burada iki tane iş parçacığımız var - biri metronom gibi davranıyor, ses çalmıyor, ancak dışarı atıyor: her atışı kalp atışı mesajlarını işaretleyin. İkinci iş parçacığı kene iletilerinde eşitlenir ve bir ileti aldığında işaret iş parçacığının zamanını devralır ve çalışmaya devam eder.

Sonuç olarak, iki iş parçacığı aynı anda yürütmeye başlamamış olsa bile, tam olarak diğer iş parçacığı şunları gönderdiğinde: drum_heavy_kick örneğini duyacağız:
```
in_thread do
  loop do
    cue :tick
    sleep 1
  end
end

sleep(0.3)

in_thread do
  loop do
    sync :tick
    sample :drum_heavy_kick
  end
endCopy
```
Bu yaramaz uyku çağrısı tipik olarak ikinci ipliği birinci ile faz dışı hale getirir. Ancak, cue ve sync kullandığımızdan, herhangi bir yanlışlıkla zamanlama ofsetini atlayarak konuları otomatik olarak senkronize ediyoruz.

### Çağrı İsimleri

İpucu iletileriniz için istediğiniz adı kullanmakta özgürsünüz - yalnızca: işaretleyin. Başka herhangi bir iş parçacığının doğru adla eşitlendiğinden emin olmanız gerekir - aksi halde her zaman beklerler (veya en azından Durdur düğmesine basana kadar).

Birkaç çağrı adı ile oynayalım:
```
in_thread do
  loop do
    cue [:foo, :bar, :baz].choose
    sleep 0.5
  end
end

in_thread do
  loop do
    sync :foo
    sample :elec_beep
  end
end

in_thread do
  loop do
    sync :bar
    sample :elec_flip
  end
end

in_thread do
  loop do
    sync :baz
    sample :elec_blup
  end
endCopy
```
Burada rastgele kalp atışı adlarından birini gönderen bir ana işaret döngüsü var: foo,: bar veya: baz. Daha sonra, bu adların her biri üzerinde bağımsız olarak eşitlenen ve sonra farklı bir numuneyi çalan üç döngü parçamız var. Net etki, senkronizasyon ipliklerinin her biri işaret ipliği ile rastgele senkronize edildiği ve örneğini oynattığı için her 0.5 atımda bir ses duymamızdır.

Bu, aynı zamanda, eğer iş parçacığı ters sırayla sıralanırsa, eşitleme iş parçacıkları basitçe oturacak ve bir sonraki işaret için bekleyecektir.
