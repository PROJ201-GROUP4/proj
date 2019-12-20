
# 12-OSC
MIDI dışında Sonic Pi yın içinden ve dışından bilgi almak için kullanılan bir diğer yöntem ise OSC- Open Sound Conrol- denilen bir protokoldür. Bu sizin dış programlara mesaj göndermenizi ya da dış programlardan mesaj göndermenizi sağlar. 

Örneğin, başka bir programlama dilini kullanarak program yazabilirsiniz. Bu OSC ye gönderilir ve OSC tarafından teslim alınır ve bunu sonucunda da direkt Sonic Pi da yazdığınız programı çalıştırabilirsiniz. Ne kullanacağınız ise sizin hayal gücünüze kalmış.

## 12.1 - OSC Alışı

Sonic Pi başlatıldığında, aynı bilgisayardaki programlardan gelen OSC mesajları için 4559 numaralı bağlantı noktasını dinler. Bu, herhangi bir konfigürasyon olmadan Sonic Pi'ye bir OSC mesajı gönderebileceğiniz ve gelen MIDI mesajlarında olduğu gibi işaret günlüğünde görüntüleneceği anlamına gelir. Bu aynı zamanda, gelen herhangi bir OSC mesajının da Zaman Durumuna otomatik olarak ekleneceği anlamına gelir; bu, aynı zamanda MIDI ve aynı şekilde live_loops senkronizasyonu gibi gelen verilerle çalışmak için get ve sync'i kullanabileceğiniz anlamına gelir - bunun nasıl çalıştığını özetlemek için 5.7 ve 10.2 bölümlerine bakın .

### Temel OSC Dinleyicisi 

Haydi temel bir OSC dinleyeyicisi yaratalım:
```
live_loop :foo do
  use_real_time
  a, b, c = sync "/osc/trigger/prophet"
  synth :prophet, note: a, cutoff: b, sustain: c
endCopy
```
Bu örnekte "/osc/trigger/prophet" şeklinde yazılan OSC yolu tanımladık. Bu herhangi bir geçerli OSC yolu olabilir.(all letters and numbers are supported and the / is used like in a URL to break up the path to multiple words). The /osc prefix is added by Sonic Pi to all incoming OSC messages, so we need to send an OSC message with the path /trigger/prophet for our sync to stop blocking and the prophet synth to be triggered.

### OSC yi Sonic Pi ya Göndermek

OSC kütüphanesi olan herhangi bir programlama dilinden Sonic Pi ya OSC gönderilebilir. Örneğin, Eğer OSC yi Python dan gönderiyorsak şöyle bir şey yapmamız gerekebilir:
```
from pythonosc import osc_message_builder
from pythonosc import udp_client

sender = udp_client.SimpleUDPClient('127.0.0.1', 4559)
sender.send_message('/trigger/prophet', [70, 100, 8])Copy
```
Ya da, eğer Clojuredan OSC gönderiyorsak REPL deb böyle bir şey yapmamız gerekebilir:
```
(use 'overtone.core)
(def c (osc-client "127.0.0.1" 4559))
(osc-send c "/trigger/prophet" 70 100 8)Copy
```
### Dış Makinelerden OSC Alışı

Güvenlik nedenleriyle, varsayılan olarak Sonic Pi, uzak makinelerin OSC mesajları göndermesine izin vermez. Bununla birlikte, uzak makineler için desteği Tercihler-> IO-> Şebeke-> Uzak OSC Mesajlarını Al'dan alabilirsiniz. Bunu etkinleştirdikten sonra, ağınızdaki herhangi bir bilgisayardan OSC mesajlarını alabilirsiniz. Genellikle gönderen makinenin IP adresinizi bilmesi gerekir (ağınızdaki bilgisayarınız için benzersiz bir tanımlayıcı - bir telefon numarası veya bir e-posta adresi gibi). Bilgisayarınızın IP adresini, tercihler bölmesinin IO bölümüne bakarak keşfedebilirsiniz. (Makinenizde birden fazla IP adresi varsa, fareyi listelenen adrese getirmeniz bilinen tüm adreslerin bir listesi ile açılır).

Unutmayın, iPhone ve Android için TouchOSC gibi programlar OSC'nin standart bir özellik olarak gönderilmesini desteklemektedir. Böylece, uzaktaki makineleri dinleyip bir kez IP adresinizi öğrendikten sonra, anında kendi özel dokunmatik kontrollerinizi sürgü, düğme, kadran vb. İle oluşturmanıza olanak sağlayan TouchOSC gibi uygulamalardan mesaj göndermeye hemen başlayabilirsiniz. giriş seçenekleri.

## 12.2 - OSC Gönderme

OSC almaya ve Time State kullanarak çalışmasına ek olarak, müziğimizle zamanında OSC mesajları da gönderebiliriz (tıpkı müziğimizle birlikte MIDI mesajları gönderebildiğimiz gibi). Sadece hangi IP adresine ve portuna gönderdiğimizi bilmemiz gerekiyor. Bir deneyelim:

```
use_osc "localhost", 4559
osc "/hello/world"Copy
```

Yukarıdaki kodu çalıştırırsanız, Sonic Pi'nin kendisine bir OSC mesajı gönderdiğini fark edeceksiniz! Bunun sebebi IP adresini mevcut makineye ve portu porttaki varsayılan OSC'ye ayarlamamızdır. Bu aslında kendinize bir mektup göndermekle aynıdır - OSC paketi yaratılır, Sonic Pi'den çıkar, işletim sisteminin ağ yığınına girer, ardından paketlenmiş olanı Sonic Pi'ye yönlendirir ve daha sonra standart bir OSC mesajı olarak alınır ve cue logger'da gelen mesaj olarak görünür "/ osc / hello / world. (Sonic Pi'nin gelen tüm OSC mesajlarının / osc ile otomatik olarak nasıl öneklendiğine dikkat edin.)

### OSC yi Diğer Programlara Göndermek

Tabii ki, kendimize OSC mesajları göndermek eğlenceli olabilir ama bu o kadar da kullanışlı değil. Gerçek faydası mesajları diğer programlara göndermeye başladığımızda başlar:

```
use_osc "localhost", 123456
osc "/hello/world"Copy
```
Bu durumda, aynı makinede 123456 numaralı bağlantı noktasını dinleyen başka bir program olduğunu varsayıyoruz. Varsa, istediği şeyi yapabileceği bir "/ merhaba / dünya OSC mesajı alacaksınız.

Eğer program başka bir makinede de çalışıyorsa, bizim o makinenin IP adresini bilmeye ihtiyacımız var ki "localhost" yerine kullanabilelim:
```
use_osc "192.168.10.23", 123456
osc "/hello/world"Copy
```
Şimdi yerel ağlara hatta internete bağlanabilen her türlü alete OSC mesajı gönderebiliriz.
