# 4 - Rastgelelik
Müziğinizi ilginç kılmanın harika bir yolu rastgele numaralardan yararlanmaktır. Sonic Pi’ın müziğe rastgelelik katmak için muazzam yolları vardır, fakat başlamadan şok edici bir gerçeği öğrenmek gerekecek: Sonic Pi’da rastgelelik aslında gerçekten rastgele değildir. Bu da ne demek? Göreceğiz.


### Tekrar Edilebilirlik
Oldukça kullanışlı bir fonksiyon rrand size iki sayı arasında bir sayı üretecektir. Rastgele bir nota çalmayı 
```ruby
play rrand(50, 95)
```
Oh, a rastgele nota çalındı. 83.7527 notasını çaldı. Güzel bir rastgele nota. Bir dakika, az önce senin de tam çaldığın notayı mı tahmin ettim? Burada bir şeyler dönüyor. Kodu tekrar çalıştıralım. Yine aynı nota? Bu rastgele olamaz.

Cevap ise o gerçekten rastgele değil, sözde rastgele. Sonic Pi, tekrar edilebilecek rastgele sayılar üretir. Böylece hangi makinede çalarsanız çalın, rastgelelik içeren şarkınızın bile her makinede aynı çalışacağından emin olabilirsiniz.

Tabi ki, bir parçada her rastgele nota *83.7527* çıksaydı pek ilginç olmazdı. Fakat durum bu değil:
```ruby
loop do
  play rrand(50, 95)
  sleep 0.5
end 
```
Şükür! Sonunda rastgele duyuluyor. Rastgelelik fonksiyonları her çağırıldığında farklı bir değer üretir. Fakat baştan çalıştığında kodunuz yeniden sırayla ürettiği rastgele sayıları üretecektir her çalışta. Adeta zamanda geriye dönüp oynata hiç basmamışsınız gibi.
Hayaletli Ziller
Rastgeleliğin en güzel gösterimlerinden biri **:perc_bell** örneğini döngüye alan ve rastgele hızda ve bekleme süresiyle oynatan bu kod olabilir: 
```ruby
loop do
  sample :perc_bell, rate: (rrand 0.125, 1.5)
  sleep rrand(0.2, 2)
end
```

### Rastgele Kesim
Bir başka eğlenceli rastgelelik örneği ise synth’lerin kesimini rastgele belirlemektir. Bunu **:tb303** emülatörü ile denemek ideal olacaktır:
```ruby
use_synth :tb303

loop do
  play 50, release: 0.1, cutoff: rrand(60, 120)
  sleep 0.125
end
```

### Rastgelelik için tohum belirleme
Peki oluşturulan bu dizi rastgele numarayı beğenmezsek ne yapacağız? Rastgele numara oluşturmak için tamamen farklı bir başlangıç noktası belirlemek **use_random_seed** kullanarak mümkün. Varsayılan tohum 0’dır ve başka bir tohum seçildiğinde farklı bir rastgele tecrübe ortaya çıkacaktır.
```ruby
5.times do
  play rrand(50, 100)
  sleep 0.5
end
```
Bu kodu her çalıştırdığınızda aynı 5 dizi notu duyacaksınız. Başka bir dizi duymak için tohumu değiştirebilirsiniz:
```ruby
use_random_seed 40
5.times do
  play rrand(50, 100)
  sleep 0.5
end
```
Tohumu değiştirip sonucu dinleyerek beğendiğiniz bir dizi bulana kadar deneyebilirsiniz. Başkasıyla paylaşınca onlar da aynı diziyi sunacaklardır. 


### Choose (seç)
Sıkça uygulanan bir metod bir listeden rastgele bir eleman seçmektir. Örneğin, 60, 65 veya 72 seçeneklerinden birini seçmek istiyorsam 
choose bana bunlardan oluşan bir listeden seçim yaptırabilir. Önce numaraları listeye koyup ( *[60, 65, 72]* şeklinde) sadece choose demek yeterli olacaktır:
```ruby
choose([60, 65, 72])
```
Nasıl duyulduğuna bakalım:
```ruby
loop do
  play choose([60, 65, 72])
  sleep 1
end
```

### rrand
rrand’i çoktan gördük. Fakat bahsetmediğimiz özelliği yalnızca girilen iki sayı arasında bir numara veriyor olduğudur ve iki sayı dahil değildir. Bu asla bir tam sayı olmayacaktır fakat küsüratlı bir sayıdır. ***rrand(20, 110)*** fonksiyonunu kullandığımızda gelebilecek bazı sayılar:
•	87.5054931640625
•	86.05255126953125
•	61.77825927734375

### rrand_i
Bazen de küsüratlı bir değer yerine tam sayı elde etmek isteyeceksiniz. Burada rrand_i devreye giriyor. Rrand’dan tek farkı ise aralık için girilen değerler de muhtemel sonuca dahil. ***rrand_i(20, 110)*** komutunun çıkarabileceği bazı sayılar:
•	88
•	86
•	62

### rand
Bu ise 0 ile belirtilen maximum değer arasında bir küsüratlı sayı döndürecektir. Bir değer belirtilmemişse varsayılan olarak 0 ile 1 arasında bir değer sunar. Bu sebepten rastgele amp: değerleri seçmek için de elverişlidir:
```ruby
loop do
  play 60, amp: rand
  sleep 0.25
end
```

### rand_i
Aynı şekilde bu fonksiyon da belirtilen değerler arasında bir tamsayı döndürecektir.

### Zar (dice)
Yeri geldiğinde bir zat atışını simüle etmek isteyeceksiniz. Bu rrand_i fonksiyonunun alt limiti 1 olan bir varyasyonudur. dice fonksiyonunu çağırmak için kaç yüzeyli bir zar olduğunu belirtmeniz gerekecektir. Standart zarın 6 yüzü (**dice(6)**) vardır. Dilediğinizde bu sayıyı tıpkı oyunlardaki gibi 4, 12, 20, veya hatta 120 yüzeyli bir zar da kullanabilrsiniz.

### one_in
Son olarak da bir zarın en yüksek değerini atıp atamamayı simüle etme şansınız var. one_in fonksiyonu size bir bölü zarın yüzey sayısı oranında true (doğru) döndürecektir. Yani **one_in(6)** kodu size 1/6 olasılığında true, öbür türlü ise false (yanlış) verecektir. True ve false değerleri ileride işleyeceğimiz if ifadeleri için oldukça kullanışlı olacaktır. 
Haydi, şimdi kodumuzu rastgelelikle bulamaca çevirme zamanı.

