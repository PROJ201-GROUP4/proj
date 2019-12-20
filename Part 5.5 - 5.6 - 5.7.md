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

Kod yazdığınız zaman bilgisayara bir şeyleri nasıl yapması gerektiğini söylemeyi düşünmek kolaydır. ( Bilgisayar anladığı sürece sıkıntı yok.) Ama kodu okuyanın sadece bilgisayar olmadığını hatırlamamız gerekiyor. İnsanlarda bu kodu okuyabilir ve kodun niye yazıldığını anlamaya çalışabilir. Ayrıca sizde yazdığınız kodu daha sonradan tekrar okumak isteyebilirsiniz ve kodu hangi amaçla yazdığınızı anlamak isteyebilirsiniz. Size kodun amacı çok bariz gelse bile diğer insanlar için hatta ilerideki siz için bilr kafa karıştırıcı olabilir.

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
Gnelleikle kodunuzda çok fazla tekrar görürsünüz ve tekrar eden kodun içerisinden bir şeyi değiştirmek istediğinizde çok fazla yerde değişim yapmak zorunda kalırsınız. Aşağıdaki koda bir bakalım:
```
sample :loop_amen
sleep sample_duration(:loop_amen)
sample :loop_amen, rate: 0.5
sleep sample_duration(:loop_amen, rate: 0.5)
sample :loop_amen
sleep sample_duration(:loop_amen)Copy
```
We’re doing a lot of things with :loop_amen! What if we wanted to hear what it sounded like with another loop sample such as :loop_garzul? We’d have to find and replace all :loop_amens with :loop_garzul. That might be fine if you have lots of time - but what if you’re performing on stage? Sometimes you don’t have the luxury of time - especially if you want to keep people dancing.

What if you’d written your code like this:
```
sample_name = :loop_amen
sample sample_name
sleep sample_duration(sample_name)
sample sample_name, rate: 0.5
sleep sample_duration(sample_name, rate: 0.5)
sample sample_name
sleep sample_duration(sample_name)Copy
```
Now, that does exactly the same as above (try it). It also gives us the ability to just change one line sample_name = :loop_amen to sample_name = :loop_garzul and we change it in many places through the magic of variables.

### Capturing Results
Finally, a good motivation for using variables is to capture the results of things. For example, you may wish to do things with the duration of a sample:
```
sd = sample_duration(:loop_amen)Copy
```
We can now use sd anywhere we need the duration of the :loop_amen sample.

Perhaps more importantly, a variable allows us to capture the result of a call to play or sample:
```
s = play 50, release: 8Copy
```
Now we have caught and remembered s as a variable, which allows us to control the synth as it is running:
```
s = play 50, release: 8
sleep 2
control s, note: 62Copy
```
We’ll look into controlling synths in more detail in a later section.

### Warning: Variables and Threads
Whilst variables are great for giving things names and capturing the results of things, it is important to know that they should typically only be used locally within a thread. For example, don’t do this:
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
In the above example we assign a ring of numbers to a variable a and then used it within two separate live_loops. In the first live loop every 0.5s we sort the ring (to (ring 1, 2, 3, 4, 5, 6)) and then print it out to the log. If you run the code, you’ll find that the printed list is not always sorted!. This may surprise you - especially that sometimes the list is printed as sorted, and sometimes it is not. This is called non-deterministic behaviour and is the result of a rather nasty problem called a race-condition. The problem is due to the fact that the second live loop is also manipulating the list (in this case shuffling it) and by the time the list is printed, sometimes it has just been sorted and sometimes it has just been shuffled. Both live loops are racing to do something different to the same variable and every time round a different loop ‘wins’.

There are two solutions to this. Firstly, don’t use the same variable in multiple live loops or threads. For example, the following code will always print a sorted list as each live loop has its own separate variable:
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
However, sometimes we do want to share things across threads. For example, the current key, BPM, synth etc. In these cases, the solution is to use Sonic Pi’s special thread-safe state system via the fns get and set. This is discussed later on in section 10.

## 5.7 Thread Senkronizasyonu

Once you have become sufficiently advanced live coding with a number of functions and threads simultaneously, you’ve probably noticed that it’s pretty easy to make a mistake in one of the threads which kills it. That’s no big deal, because you can easily restart the thread by hitting Run. However, when you restart the thread it is now out of time with the original threads.

### Inherited Time
As we discussed earlier, new threads created with in_thread inherit all of the settings from the parent thread. This includes the current time. This means that threads are always in time with each other when started simultaneously.

However, when you start a thread on its own it starts with its own time which is unlikely to be in sync with any of the other currently running threads.

### Cue and Sync
Sonic Pi provides a solution to this problem with the functions cue and sync.

cue allows us to send out heartbeat messages to all other threads. By default the other threads aren’t interested and ignore these heartbeat messages. However, you can easily register interest with the sync function.

The important thing to be aware of is that sync is similar to sleep in that it stops the current thread from doing anything for a period of time. However, with sleep you specify how long you want to wait while with sync you don’t know how long you will wait - as sync waits for the next cue from another thread which may be soon or a long time away.

Let’s explore this in a little more detail:
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
Here we have two threads - one acting like a metronome, not playing any sounds but sending out :tick heartbeat messages every beat. The second thread is synchronising on tick messages and when it receives one it inherits the time of the cue thread and continues running.

As a result, we will hear the :drum_heavy_kick sample exactly when the other thread sends the :tick message, even if the two threads didn’t start their execution at the same time:
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
That naughty sleep call would typically make the second thread out of phase with the first. However, as we’re using cue and sync, we automatically sync the threads bypassing any accidental timing offsets.

### Cue Names
You are free to use whatever name you’d like for your cue messages - not just :tick. You just need to ensure that any other threads are syncing on the correct name - otherwise they’ll be waiting for ever (or at least until you press the Stop button).

Let’s play with a few cue names:
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
Here we have a main cue loop which is randomly sending one of the heartbeat names :foo, :bar or :baz. We then also have three loop threads syncing on each of those names independently and then playing a different sample. The net effect is that we hear a sound every 0.5 beats as each of the sync threads is randomly synced with the cue thread and plays its sample.

This of course also works if you order the threads in reverse as the sync threads will simply sit and wait for the next cue
