# PROGRAMLAMA YAPILARI
 
Şu ana dek, play ve sample ile ses yaratmak; sleep ile basit melodi ve ritim yaratmak için temel kazanımları öğrendiniz. Kodlama dünyası size daha neler sunabilir düşünüyor olmalısınız.
Döngü, koşullar, fonksiyonlar ve threadler gibi basit kodlama yapıları, müziksel fikirlerinizi kodlamak için size çok güçlü araçlar sağlayacaklar. Temel yapılarla başlayalım.

## 5.1 BLOKLAR
Sonic Pi’da çok sık göreceğiniz yapılardan biri de bloklar. Blocklar büyük kod yığınlarını verimli bir şekilde kullanmamızı sağlar. Örneğin synth ve sample parametreleriyle, sadece bir satır üzerinde değişiklik yapabiliriz. Aynı zamanda, bazen sadece az sayıda satırdaki kodda değişiklik yapmak isteriz. Örneğin, bunu loopa sokmak veya 5 seferde 1 defa çalıştırmak gibi. Aşağıdaki örnek kodu inceleyelim.

```
play 50
sleep 0.5
sample :elec_plip
sleep 0.5
play 62

```

Kod parçaları üzerinde bir şey yapmak için, Sonic Pi’a  kod bloğunun nerede başlayıp bittiğini bildirmemiz gerekir. Başlangıç için “do” komutunu bitiş için ise “end” komutunu kullanırız. Örneğin:

do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
End
Aynı zamanda, Sonic Pi’a henüz bu başlangıç/bitiş bloğuyla ne yapacağımızı söylemedğimiz için işimizi tamamlamadık, denerseniz hata alacaksınız. Sonic Pi’a do komutundan önce özel bir kod yazacağız ve bu özel kodun bu eğitici yazıda kaç tane olduğunu göreceğiz. Şimdilik, “do” ve “end” komutlarının kod yığınına özel bir işlem yapacağıı bilmek önemli olduğunu bilelim.

## 5.2 Iteration and Loops
Şu ana kadar, “play” ve “sample” blocklarıyla birçok ses çıkarabilceğimiz üzerinde çalıştık. “Sleep” komutuyla da bu sesleri tetiklenceğinizi öğrendik. 
Gördüğünüz gibi, bu basit yapı blokları çok eğlenceli. Aynı zamanda, müzik ve bestelerinizde kodun gücünü kullanmaya başladığınızda eğlencede yeni bir boyut açılıyor. Bir sonraki bölümlerde, bu güçlü araçları keşfedeceğiz.

Tekrarlama

Hiç birden fazla tekrarlamak isteğiniz bir kod yazdınız mı? Mesela;
```
play 50
sleep 0.5
sample :elec_blup
sleep 0.5
play 62
sleep 0.25
```

What if we wished to repeat this 3 times? Well, we could do something simple and just copy and paste it three times:

```
play 50
sleep 0.5
sample :elec_blup
sleep 0.5
play 62
sleep 0.25
```

3 kez yazmak isteseydiniz 3 kez kopyala yapıştır yapabilirdiniz:

```
play 50
sleep 0.5
sample :elec_blup
sleep 0.5
play 62
sleep 0.25


play 50
sleep 0.5
sample :elec_blup
sleep 0.5
play 62
sleep 0.25

play 50
sleep 0.5
sample :elec_blup
sleep 0.5
play 62
sleep 0.25
```

Kod oldukça uzadı! Eğer bir kelimeyi ı :elec_plip1 e çevirmek isterseniz? Bütün orjinal kelimeyi ayrı ayrı bulmanız gerekecek. Daha önemlisi, eğer kodu 500 veya 1000 defa tekrarlamak isterseniz? Kod oldukça uzun ve büyük bir hale dönüşecek. 
Yineleme
Aslında kodu tekrarlamak “bunu 3 defa yap” demek kadar kolay.Eski arkadaşınız kod bloğunu hatırlıyor musunuz? Bu özel kodu 3 defa tekrarlamak için “3.times do” komutunu kullanabilir. Tekrarlamak istediğiniz kodun sonuna “end” eklemeyi unutmayın:

```
3.times do
  play 50
  sleep 0.5
  sample :elec_blup
  sleep 0.5
  play 62
  sleep 0.25
end
```


Şimdi, sizce de kopyala yapıştır yapmaktan daha kolay olmadı mı? Bu tekrarlayan uzun kodlar yapmak için kullanabilirsiniz:

```
4.times do
  play 50
  sleep 0.5
end

8.times do
  play 55, release: 0.2
  sleep 0.25
end

4.times do
  play 50
  sleep 0.5
end

```


İç içe tekrarlamalar
Şimdi, tekrarlamaların içinde de tekrarlama yaparak ilginç kod yapıları oluşturabiliriz.

```
4.times do
  sample :drum_heavy_kick
  2.times do
    sample :elec_blip2, rate: 2
    sleep 0.25
  end
  sample :elec_snare
  4.times do
    sample :drum_tom_mid_soft
    sleep 0.125
  end
end
```


Döngüler
If you want something to repeat a lot of times, you might find yourself using really large numbers such as 1000.times do. In this case, you’re probably better off asking Sonic Pi to repeat forever (at least until you press the stop button!). Let’s loop the amen break forever:

Eğer bir şeyi birçok kez tekrarlamak isterseniz, kendinizi çok büyük sayılar kullanırken bulabilirsiniz örneğin “1000.times do.” bu durumda, Sonic Pi bunu sonsuza dek yapmaya çalışır gibi olacaktır. Amen’i sonsuz döngüye soktuğumuzda: 

```
loop do
  sample :loop_amen
  sleep sample_duration :loop_amen
end
```

Bilmeniz gereken bir diğer şey ise, döngüler kod için kara delik gibi davranır. Döngüye girildiği anda, “stop” a basmadığınız sürece döngüden çıkamazsınız. Bu demektir ki, döngüden sonra bir kodunuz varsa, bu kodu göremeyeceksiniz bile. Örneğin bu döngüden sonraki cymbal asla çalmayacak:

```
loop do
  play 50
  sleep 1
end
```

sample :drum_cymbal_open

## 5.3 Koşul
Kendinizi yaparken bulabileceğiniz bir diğer şey ise, sadece random bir nota çalmak değil; aynı zamanda bir kodun sonucu üzerinden random bir karar vermektir. Örneğin, rastgele davul veya zil çalabilirsiniz. Bunu bir eğer “if” komutuyla da yapabiliriz.

Bozuk para atma
Hadi yazı tura atalım, yazı gelirse davul tura gelirse zil çalalım. Çok kolay! Bozuk para atmayı “one_in” fonksiyonu olarak yazalım. Bozuk para atmanın sonucunu davul veya zil çalma kararında kullanalım:

```
loop do

  if one_in(2)
    sample :drum_heavy_kick
  else
    sample :drum_cymbal_closed
  end

  sleep 0.5
  

end

```


Fark ettiyseniz eğer komutu 3 bölümden oluşmaktadır:
Sorulan soru
Çalışacak kodun ilk seçeneği (eğer cevap evetse)
Çalışacak kodun ikinci seçeneği (eğer cevap hayırsa)
Programa dillerinde, evet cevabı “true” terimiyle, hayır cevabı ise “false” terimiyle gösterilir. Yani bize doğru veya yanlış cevabını bulacak bir soru bulmamız gerekli, tıpkı ”one_in” in yaptığı gibi.
Fark ettiniz mi? İlk seçenek if ve else seçenekleri arasında, ikinci seçenek ise else ve end arasında yer alıyor. Örneğin:
```
loop do
 
  if one_in(2)
    sample :drum_heavy_kick
    sleep 0.5
  else
    sample :drum_cymbal_closed
    sleep 0.25
  end
 
end
```
 
Eğer:
Bazen, sadece bir satır kodu silmek istersiniz. Bu satırın sonuna “if” komutunun yerleştirilmesiyle mümkün olabilir. Örneğin:
use_synth :dsaw
 
```
loop do
  play 50, amp: 0.3, release: 2
  play 53, amp: 0.3, release: 2 if one_in(2)
  play 57, amp: 0.3, release: 2 if one_in(3)
  play 60, amp: 0.3, release: 2 if one_in(4)
  sleep 1.5
End
```
 

## 5.4 - Threadler
Şimdi, bas ile ritimin aynı anda çalmasını istiyorsunuz. Bunları nasıl aynı anda çalarsınız? İlk çözüm, manuel biçimde ikisini çalıştırmak. Aynı zamanda birçok elemanla bunu yaptığınızda bunu zamanlamak çok zor olabilir. Peki ya Sonic Pi otomatik bir şekilde bu ikisini çalabilirse? Thread denilen özel komutla bunu yapabilirsiniz.
Sonsuz Döngüler
 
Bu örneği basit tutmak için, bas ile ritimin aynı anda çaldığını hayal edin:

```
loop do
  sample :drum_heavy_kick
  sleep 1
end
```
 
```
loop do
  use_synth :fm
  play 40, release: 0.2
  sleep 0.5
End
```
Daha önceden de konuştuğumuz gibi, döngüler birer kara delik gibidir. Dur komutu olmadan bu delikten çıkamazsınız. Peki ya birden fazla döngüyü aynı anda nasıl çalıştırırsınız? İşte treadhler burada sizi kurtarır.
 
```
in_thread do
  loop do
    sample :drum_heavy_kick
    sleep 1
  end
end
```

``` 
loop do
  use_synth :fm
  play 40, release: 0.2
  sleep 0.5
end
```


Çalıştır butonuna bastığınızda, çalışması için yeni bir threadin oluşması sizi şaşırtabilir. Çalıştır butunona birden çok kez basmanın sesleri üst üste katmanlaması da bu yüzdendir.
Faaliyet Alanı
Sonic pi kullanmada uzmanlaşınca göreceksiniz ki, threadler müziğiniz için en önemli parçalar. Yaptıkları en önemli işlerden biri, anlık ayarları other threadlerden izole etmeleridir. Bu ne demek?use_synth kullanarak synthları değiş tokuş yaparken aslında sadece şuanli synth ile değiş tokuş yaparsınız. Diğer threadler değişmez. Örneğin:
play 50
sleep 1
 
```
in_thread do
  use_synth :tb303
  play 50
end
```
 

```
sleep 1
play 50
```

İkinci ses diğerlerinden farklı fark ettiniz mi? Use_synth komutu sadece threadin olduğu kodu etkiledi.
 
Kapsam
In_thread ile yeni bir thread yarattığınızda, yenisi otomatik olarak mevcut olan ayarlara sahip olacaktır. Bakalım:

```
use_synth :tb303
play 50
sleep 1

 
in_thread do
  play 55
end

```
Yeni threadler oluşturuldu ve öncekilerin ayarlarını sahiplendi fakat eskiler üzerinde hiçbir değişikliğe yol açmadı.
Threadlerin Adlandırılması

```
in_thread(name: :bass) do
  loop do
    use_synth :prophet
    play chord(:e2, :m7).choose, release: 0.6
    sleep 0.5
  end
end
 
in_thread(name: :drums) do
  loop do
    sample :elec_snare
    sleep 1
  end
end

```
Her isim için sadece bir threade izin verilir.
Threadlerle ilgili bilinmesi gereken son şey ise, verilen isimdeki threadlerden sadece bir tanesinin aynı anda çalışmasına izin verilir. Hadi keşfedelim:

```
in_thread do
  loop do
    sample :loop_amen
    sleep sample_duration :loop_amen
  end
end
```
 
Çalıştır butonuna birkaç kez basarsak, sesler birbirinin üstüne binecek. Bu nedenle eğer bir döngü var ise, üst üste 3 katman ses duyacaksınız.
Aynı zamanda isimlendirilmiş threadler durum biraz farklı:

```
in_thread(name: :amen) do
  loop do
    sample :loop_amen
    sleep sample_duration :loop_amen
  end
end
```
 
Çalıştıra birden fazla kez basmayı deneyin. Sadece bir amen duyacaksınız. Bir de şunu görün.
==> Skipping thread creation: thread with name :amen already exists.
Sonic pi amen isimli threadin zaten çaldığını ve var olduğunu, yeni bir thread oluşturulamayacağını söylüyor.
