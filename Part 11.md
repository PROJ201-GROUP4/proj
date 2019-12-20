# 11  MIDI

Once you’ve mastered converting code to music, you might wonder - 
Bir kere kodu müziğe çevirmede uzmanlaşınca, sırada ne var diye merak ederiniz. Bazen, Sonic Pi’in sözdizim ve ses sistemi size heyecan verir ve sizi daha yaratıcı bir pozisyona koyar. Aynı zamanda, kodu gerçek hayata geçirmek önemlidir. Ekstradan iki şey istiyoruz:

  1.Gerçek hayattaki aksiyonları Sonic Pi ile kodlayabilmek
  2.Sonic Pi’in güçlü zamanlama modelini ve semantiklerini gerçek hayattaki objeleri kontrol etmek ve yönetmek için kullanabilmek
 
Şanslıyız ki, 80lerden beri bu etkileşimi sağlayan bir protokol var. MIDI. Klavye, controller, sequencer and pro ses yazılımlarını kapsayan ve  MIDI’ı destekleyen inanılmaz sayıda araç gereç var. MIDI’ı data almak ve data göndermek için kullanabiliriz.
 Hadi daha fazla keşfedelim..
 
## 11.1 MIDI IN

Bu bölümde MIDI controller’ı Sonic Pi’a ses kontrolu için bilgi göndermek için nasıl kullanabileceğimizi öğreneceğiz. Haydi bir MIDI controller kapın!

### MIDI CONTROLLERI BAĞLAMAK

Harici MIDI’dan Sonic Pi’a bilgi almak için öncelikle onu bilgisayara bağlamalıyız, tabiki bunu USB bağlantısıyla yapacağız. Bağladıktan sonra, Sonic Pi’ı indirin ve IO bölümüne bir göz atın. Eğer cihazınız çıkmıyorsa, RESET MIDI butonuna basın ve bakın çıkıyor mu diye.
 
## MIDI Eventlerini Almak
 Cihazınız bağlandığında, Sonic Pi otomatik olarak eventleri alıyor olacak. Kendiniz de görebilirsiniz. Göremiyorsanız Preferences->Editor->Show & Hide ‘a girip Show cue log tuşunu açmalısınız. Çıkacak şey:

```
/midi/nanokey2_keyboard/0/1/note_off  [55, 64]
/midi/nanokey2_keyboard/0/1/note_on   [53, 102]
/midi/nanokey2_keyboard/0/1/note_off  [57, 64]
/midi/nanokey2_keyboard/0/1/note_off  [53, 64]
/midi/nanokey2_keyboard/0/1/note_on   [57, 87]
/midi/nanokey2_keyboard/0/1/note_on   [55, 81]
/midi/nanokey2_keyboard/0/1/note_on   [53, 96]
/midi/nanokey2_keyboard/0/1/note_off  [55, 64]
```

Bu mesaj bağlamayı başardınız demektir.

### MIDI Zaman Durumu
Bu olay ikiye ayrılıyor. Önce olayın adını şöyle görmelisiniz. /midi/nanokey2_keyboard/0/1/note_on . İkincisi olayların değerlerini şöyle : [18, 62]. İlginç bir şekilde bunlar zaman durumunda depolamamız gereken iki değer. Sonic pi otomatik olarak gelen MIDI olaylarını zaman durumuna alır. Yani, sonuncu MIDI değerini alabilirsiniz ve bir sonraki MIDI değerini syncleyebilirsiniz.


### Kontrol Kodu
MIDI ı bağladık. şimdi eğlenceli bölüme başlıyoruz. Hadi basit bir MIDI piyanosuna bakalım:

```
live_loop :midi_piano do
  note, velocity = sync "/midi/nanokey2_keyboard/0/1/note_on"
  synth :piano, note: note
end
```

Aşağıda bir takım problemler var. Öncelikle, do end arasında bir sonsuz bir live_döngümüz var. Bir Diğeri ise, bir sonraki eşleşen zaman durumunu beklemek için sync komutunu çağırıyoruz. Aradığımız MIDI mesajini temsil eden bir string kullanıyoruz. Fark ettiniz mi? Bu uzun string size Sonic Pi tarafından sağlandı, böylece siz tek tek yazmak zorunda kalmadınız. Olayda, her MIDI notu için iki değer var yani ve bu iki değere note ve velocity atıyoruz. Son olarak, :piano syntini tetikliyoruz.

Şimdi siz deneyin, kodu yazın ve synci sizin MIDI cihazınıza göre bir kelimeyle eşleştirin. Çalışan bir piyanonuz oldu. Birkaç problem daha var: klavyeye ne kadar sert basarsanız basın, notaların hepsi aynı yükseklikte. HIZ MIDI  değerini ve bunu yüksekliğe çevirerek kullanarak bunu düzeltebilirsiniz. Verilen mıdı ın değeri 0 ile 127 arasında, bu sayıyı 127 ile bölerek 0 ile 1 ‘e çevirin:

```
ive_loop :midi_piano do
  note, velocity = sync "/midi/nanokey2_keyboard/0/1/note_on"
  synth :piano, note: note, amp: velocity / 127.0
end

```
### Bekleme Süresini Kaldırma
Pause tuşunu kaldırmadan önce, neden orada olduğunu öğrenelim. Bütün synth ve Fx leri CPU'da tutmak için Sonic Pi 0.5 saniyelik bir default yaratır. Bu 0.5 lik gecikme :piano synthimize eklenir. Ayrıca, bu sadece play ve sleep ile oluşturulmuş kodları etkiler. Bu durumda, aslında harici MIDI cihazını kulllanarak :piano yu etkileriz bu nedenle Sonic Pi in bixim için zamanlamayı yapmasını istemeyiz. Use_real_time komutunu kullanarak, bu gecikme komutunu kapatabiliriz.

```
live_loop :midi_piano do
  use_real_time
  note, velocity = sync "/midi/nanokey2_keyboard/0/1/note_on"
  synth :piano, note: note, amp: velocity / 127.0
end

```

### Değerleri Almak
Son olarak, MIDI olayları doğrudan zaman durumuna geçtiğinden, son görülen değer için get komutunu da kullanabiliriz. Bu, eğer geri verilecek değer bulunamazsa mevcut threadi engellemez ve nil return eder. Herhangi bir zamandaki Herhangi bir threadi çağırmak içi get komutunu kullandığımızı hatırlayalım. Ayrıca time_warp komutu ile geçmiş olayları da çağırabiliriz.

### Sıra Sizde
Herhangi bir MIDI Cihazından istedğiniz değeri almak için sync ve get komutlarını kullanabilirsiniz. MIDI cihazının ne yapacağına da siz karar verin.

## 11.2 MIDI OUT
Ek olarak, alınılan MIDI olaylarının yanında, harici donanım synth, klavye ve diğer cihazları kontrol etmek için de MIDI olaylarını gönderebiliriz.Sonic Pi aşağıdaki gibi mesajlar sağlar.

Nota - midi_note_on
Note yok - midi_note_off
Değişikliği kontrol etme - midi_cc
Pitch bend - midi_pitch_bend
Clock ticks - midi_clock_tick

Bunlar gibi daha birçok mesaj var.

### MIDI Cihazına Bağlanma
Bir harici cihaza MIDI mesaji iletmek için, önce onu bağlamalıyız.  Eğer USB bağlıyorsanız, gönderdiğiniz cihazı bağlamak da ayni aşamayla gerçekleşir. Aynı zamanda, eğer klasik DIN bağlantısı kullanıyorsanız, bilgisayarınızın MIDI out portuna bağladığınızdan emin olun. Burada MIDI cihazının listelendiğini görmelisiniz

### MIDI Cihazı Seçme
Otomatik olarak Sonic Pi bütün bağlanan cihazlara her bir MIDI cihazını yollayacak. Bu çalışma sürecini kolaylaştırıyor. Aynı zamanda, cihazınız bazen MIDI kanallarına farklı davranabilir. Bazen ayno anda birden fazla cihaz bağlamak istersiniz. Daha karışık düzenlerde, hangi cihazın hangi mesajı alacağı konusunda seçici olabilirsiniz.

Hangi cihaza yollayacağınızı port: opt ile belirtirsiniz:

```
midi_note_on :e3, port: "moog_minitaur"
```

We can also specify which channel to send to using the channel: opt (using a value in the range 1-16):

Hangi kanala yollayacağınızı ise channel: ile:
```
midi_note_on :e3, channel: 3

```

Tabi ki ikisini aynanda da kullanabilirsiniz: 

```
midi_note_on :e3, port: "moog_minitaur", channel: 5
```

### MIDI STUDYO

Son olarak, yapacağımız bir diğer eğlenceli şey ise, ses outputunu MIDI’a bağlamak.  midi_* fns kodu ile synthlerinizi kontrol edip, live_audio ve FX kullanarak sesi yönetebilirsiniz:
 
 ```
 with_fx :reverb, room: 1 do
  live_audio :moog
end

live_loop :moog_trigger do
  use_real_time
  midi (octs :e1, 3).tick, sustain: 0.1
  sleep 0.125
end
 ```















