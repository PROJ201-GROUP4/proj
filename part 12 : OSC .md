
# 12-OSC
MIDI dışında Sonic Pi yın içinden ve dışından bilgi almak için kullanılan bir diğer yöntem ise OSC- Open Sound Conrol- denilen bir protokoldür. Bu sizin dış programlara mesaj göndermenizi ya da dış programlardan mesaj göndermenizi sağlar. 

Örneğin, başka bir programlama dilini kullanarak program yazabilirsiniz. Bu OSC ye gönderilir ve OSC tarafından teslim alınır ve bunu sonucunda da direkt Sonic Pi da yazdığınız programı çalıştırabilirsiniz. Ne kullanacağınız ise sizin hayal gücünüze kalmış.

## 12.1 - OSC Alışı

By default when Sonic Pi is launched it listens to port 4559 for incoming OSC messages from programs on the same computer. This means that without any configuration, you can send Sonic Pi an OSC message and it will be displayed in the cue log just like incoming MIDI messages. This also means that any incoming OSC message is also automatically added to the Time State which means you can also use get and sync to work with the incoming data - just like with MIDI and synchronising live_loops - see sections 5.7 and 10.2 to recap how this works.

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
For security reasons, by default Sonic Pi does not let remote machines send it OSC messages. However, you can enable support for remote machines in Preferences->IO->Network->Receive Remote OSC Messages. Once you’ve enabled this, you can receive OSC messages from any computer on your network. Typically the sending machine will need to know your IP address (a unique identifier for your computer on your network - kind of like a phone number or an email address). You can discover the IP address of your computer by looking at the IO section of the preferences pane. (If your machine happens to have more than one IP address, hovering the mouse over the listed address will pop up with a list of all known addresses).

Note, some programs such as TouchOSC for iPhone and Android support sending OSC as a standard feature. So, once you’re listening to remote machines and know your IP address you can instantly start sending messages from apps like TouchOSC which enable you to build your own custom touch controls with sliders, buttons, dials etc. This can provide you with an enormous range of input options.

## 12.2 - OSC Gönderme
In addition to receiving OSC and working with it using Time State, we can also send out OSC messages in time with our music (just like we can send out MIDI messages in time with our music). We just need to know which IP address and port we’re sending to. Let’s give it a try:
```
use_osc "localhost", 4559
osc "/hello/world"Copy
```
If you run the code above, you’ll notice that Sonic Pi is sending itself an OSC message! This is because we set the IP address to the current machine and the port to the default OSC in port. This is essentially the same as posting a letter to yourself - the OSC packet is created, leaves Sonic Pi, gets to the network stack of the operating system which then routes the packed back to Sonic Pi and then it’s received as a standard OSC message and is visible in the cue logger as the incoming message "/osc/hello/world. (Notice how Sonic Pi automatically prefixes all incoming OSC messages with /osc.)

### OSC yi Diğer Programlara Göndermek

Tabii ki, kendimize OSC mesajları göndermek eğlenceli olabilir ama bu o kadar da kullanışlı değil. Gerçek faydası mesajları diğer programlara göndermeye başladığımızda başlar:

```
use_osc "localhost", 123456
osc "/hello/world"Copy
```
In this case we’re assuming there’s another program on the same machine listening to port 123456. If there is, then it will receive a "/hello/world OSC message with which it can do what it wants.

Eğer program başka bir makinede de çalışıyorsa, bizim o makinenin IP adresini bilmeye ihtiyacımız var ki "localhost" yerine kullanabilelim:
```
use_osc "192.168.10.23", 123456
osc "/hello/world"Copy
```
Şimdi yerel ağlara hatta internete bağlanabilen her türlü alete OSC mesajı gönderebiliriz.
