# Stüdyo Efektleri
Sonic Pi'ın en güzel özelliklerinden biri seslere kolayca stüdyo efektleri ekleyebilmeniz. Örneğin parçanızın bir kısmına yankı eklemek isteyebilirsiniz, ya da sesin eko yapmasını isteyebilirsiniz.

Sonic Pi efekt ekleyebilmek için çok basit ama son derece güçlü bir yol sunuyor. Hatta bu efektleri birbirlerine bağlamanızı sağlıyor (böylece çaldığınız sese önce distortion, sonra eko daha sonra da yankı) ve bütün bu efektleri ayrı seçeneklerle kontrol edebiliyorsunuz. Efektlerin özelliklerini efektler çalışırken bile değiştirebilirsiniz. Örneğin basınızın yankı seviyesini parça süresince arttırabilirsiniz.

### Gitar Pedalları
Eğer bütün bunlar şu an karışık geliyorsa da kafaya takmayın. Biraz üzerine uğraştıktan sonra her şey daha anlaşılır bir hale gelicek. Biraz gitar pedallarından bahsedelim. Gitarınız için bir çok farklı efekt pedalı alabilirsiniz. Bazıları yankı eklerken bazıları sesi kirletebilir. Bir gitarist gitarını bu pedallardan birine, sonra o pedalı başka bir pedala bağlayabilir ve böylece hepsinin özelliklerini kullanabilir.
```
Guitar -> Distortion -> Reverb -> Amplifier 
```
Buna efekt zinciri denir. Sonic Pi da tam olarak bunu destekliyor. Ek olarak genelde her pedalın kontrolünü sağlayan farklı parçaları olur. Sonic Pi bunu da sağlar. Son olarak bir başkası efektler ile oynarken gitarı çalan bir gitarist hayal edin, Sonic Pi ile bunu da sağlayabilirsiniz ancak bunu yapmak için başkasına ihtiyacınız olmaz, ve işte burada bilgisayar işin içine girer.

Hadi efektleri keşfedelim!

## Efekt Eklemek
Bu bölümde bazı efektleri inceleyeceğiz: yankı ve eko. Bu efektleri nasıl kullanacağımızı, ayarlarını nasıl değiştireceğimizi ve bunları nasıl birleştireceğimizi öğreneceğiz.

Sonic Pi'ın efekt sistemi bloklar kullanmaktadır. O yüzden 5.1 bölümünü okumadıysanız önce küçük bir bakış atmak isteyebilirsiniz.

### Yankı
Eğer yankı efektini kullanmak istiyorsak "with_fx :reverb" komutunu kullanarak blok oluşturuyoruz:
```
with_fx :reverb do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end 
```
Şimdi bu kodu çaldığınızda sesin yankı oluşturarak çaldığını göreceksiniz. Güzel duyuluyor değil mi? Her şey yankı ile kulağa daha güzel gelir.
Şimdi bakalım blokun dışında kod yazarsak ne oluyor:
```
with_fx :reverb do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end

sleep 1
play 55 
```
Fark edeceğiniz gibi play 55 kodu yankı efektiyle çalmıyor, çünkü bu kod do/end şeklinde yazdığımız bloğun dışında ve efektimiz etki etmiyor.

Benzer olarak do/end bloğudan önce bir kodumuz olursa o kod da efektten etkilenmez
```
play 55
sleep 1

with_fx :reverb do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end

sleep 1
play 55 
```
### Eko 
Seçebileceğimiz bir sürü efekt var. Biraz ekoya ne dersiniz?
```
with_fx :echo do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end 
```
Sonic Pi'ın bir diğer önemli özelliği ise "özellikler" play ve sample komutlarında yaptığımız gibi efekt komutlarında da çalışmasıdır. Örneğin güzel bir eko özelliği onu bir "phase:" komutu ile birlikte çalmak. Gelin ekoyu daha yavaş hale getirelim:
```
with_fx :echo, phase: 0.5 do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end 
```
Ya da daha hızlı:
```
with_fx :echo, phase: 0.125 do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end 
```
Eko'nun "decay:" komutu ile daha uzun sürede bitmesini sağlayalım, 8 vuruş mesela:
```
with_fx :echo, phase: 0.5, decay: 8 do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end 
```
### İç İçe Efektler
Efektler iç içe yazılabilir. Bu da efektleri kolayca birbirlerine bağlayabilmenizi sağlar. Örneğin bir kod bloğunu hem yankı hem eko efektiyle aynı anda çalalım:
```
with_fx :reverb do
  with_fx :echo, phase: 0.5, decay: 8 do
    play 50
    sleep 0.5
    sample :elec_blup
    sleep 0.5
    play 62
  end
end 
```
Bu kod bloğu şu şekilde işliyor: İlk olarak "play 50" kodumuz içerdeki efekt olan eko'ya yollanıyor ve eko kazanıyor, sonrasında ise dışta kalan efekt olan reverb'e yollanıyor ve yankı özelliği de kazanıyor.

### Efektleri Keşfetmek
Sonic Pi üzerinde oynamanız için bir çok efekt barındırıyor. Bunları bulmak için yardım sisteminin en solunda kalan FX'e tıklayıp kullanabileceğiniz seçenekleri görebilirsiniz. Aşağıda bazı favori efektlerim bulunuyor:
- wobble, 
- reverb, 
- echo, 
- distortion, 
- slicer

Şimdi kendini kaybet ve farklı efektler deneyerek yeni sesler elde et!



