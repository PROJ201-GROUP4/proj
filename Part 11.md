# 11  MIDI

Once you’ve mastered converting code to music, you might wonder - 
Bir kere kodu müziğe çevirmede uzmanlaşınca, sırada ne var diye merak ederiniz. Bazen, Sonic Pi’in sözdizim ve ses sistemi size heyecan verir ve sizi daha yaratıcı bir pozisyona koyar. Aynı zamanda, kodu gerçek hayata geçirmek önemlidir. Ekstradan iki şey istiyoruz:

  1.Gerçek hayattaki aksiyonları Sonic Pi ile kodlayabilmek
  2.Sonic Pi’in güçlü zamanlama modelini ve semantiklerini gerçek hayattaki objeleri kontrol etmek ve yönetmek için kullanabilmek
 
Şanslıyız ki, 80lerden beri bu etkileşimi sağlayan bir protokol var. MIDI. Klavye, controller, sequencer and pro ses yazılımlarını kapsayan ve  MIDI’ı destekleyen inanılmaz sayıda araç gereç var. MIDI’ı data almak ve data göndermek için kullanabiliriz.
 Hadi daha fazla keşfedelim..
 
## 11.1 MIDI IN

Bu bölümde MIDI controller’ı Sonic Pi’a ses kontrolu için bilgi göndermek için nasıl kullanabileceğimizi öğreneceğiz. Haydi bir MIDI controller kapın!

###M IDI CONTROLLERI BAĞLAMAK

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

Bu bağlamayı başardınız demektir.

### MIDI Zaman Durumu




