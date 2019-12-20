use_random_seed Time.now.to_i

speed_coef = [0.25,0.5,0.75,1,1.25,1.5].choose

define :randomnotes do
  use_synth [:hoover, :blade, :dpulse].choose
  play rrand(50,100)
end


define :intro do
  
  use_synth [:hoover, :blade, :dpulse].choose
  
  play :E5
  sleep 1*speed_coef
  play :B4
  sleep 1*speed_coef
  play :C5
  sleep 0.25*speed_coef
  play :D5
  sleep 0.25*speed_coef
  play :C5
  sleep 0.25*speed_coef
  play :B4
  sleep 0.25*speed_coef
  play :A4
  sleep 1*speed_coef
  play :Gs4
  sleep 0.5*speed_coef
  play :Gs4
  sleep 0.25*speed_coef
  play :F4
  sleep 0.25*speed_coef
  play :Gs4
  sleep 0.5*speed_coef
  play :A4
  sleep 0.5*speed_coef
  play :B4
  sleep 1*speed_coef
  play :Gs4
  sleep 0.25*speed_coef
  play :A4
  sleep 0.25*speed_coef
  play :Gs4
  sleep 0.25*speed_coef
  play :A4
  sleep 0.25*speed_coef
  play :B4
  sleep 2*speed_coef
  
  use_synth [:hoover, :blade, :dpulse].choose
  
  play :E5
  sleep 1*speed_coef
  play :B4
  sleep 1*speed_coef
  play :C5
  sleep 0.25*speed_coef
  play :D5
  sleep 0.25*speed_coef
  play :C5
  sleep 0.25*speed_coef
  play :B4
  sleep 0.25*speed_coef
  play :A4
  sleep 1*speed_coef
  play :Gs4
  sleep 1*speed_coef
  play :F4
  sleep 0.75*speed_coef
  play :D4
  sleep 0.25*speed_coef
  play :E4
  sleep 1*speed_coef
  play :B4
  sleep 0.25*speed_coef
  play :A4
  sleep 0.25*speed_coef
  play :Gs4
  sleep 0.25*speed_coef
  play :F4
  sleep 0.25*speed_coef
  play :E4
  sleep 2*speed_coef
  
  
end

define :hizli do
  
  use_synth :piano
  
  
  play :E5
  sleep 0.125*speed_coef
  play :D5
  sleep 0.125*speed_coef
  play :E5
  sleep 0.25*speed_coef
  play :B4
  sleep 0.125*speed_coef
  play :A4
  sleep 0.125*speed_coef
  play :B4
  sleep 0.25*speed_coef
  play :Gs4
  sleep 0.125*speed_coef
  play :F4
  sleep 0.125*speed_coef
  play :Gs4
  sleep 0.25*speed_coef
  play :Gs4
  sleep 0.25*speed_coef
  play :F4
  sleep 0.25*speed_coef
  play :E4
  sleep 0.25*speed_coef
  play :F4
  sleep 0.25*speed_coef
  play :F4
  sleep 0.125*speed_coef
  play :E4
  sleep 0.125*speed_coef
  play :D4
  sleep 0.25*speed_coef
  play :D4
  sleep 0.25*speed_coef
  play :F4
  sleep 0.125*speed_coef
  play :E4
  sleep 0.25*speed_coef
  play :E4
  sleep 0.5*speed_coef
  play :Gs4
  sleep 0.125*speed_coef
  play :A4
  sleep 0.125*speed_coef
  play :Gs4
  sleep 0.125*speed_coef
  play :A4
  sleep 0.125*speed_coef
  play :B4
  sleep 0.25*speed_coef
  play :E5
  sleep 0.125*speed_coef
  play :D5
  sleep 0.125*speed_coef
  play :E5
  sleep 0.25*speed_coef
  play :B4
  sleep 0.125*speed_coef
  play :A4
  sleep 0.125*speed_coef
  play :B4
  sleep 0.25*speed_coef
  play :Gs4
  sleep 0.125*speed_coef
  play :F4
  sleep 0.125*speed_coef
  play :Gs4
  sleep 0.25*speed_coef
  play :Gs4
  sleep 0.25*speed_coef
  play :F4
  sleep 0.25*speed_coef
  play :E4
  sleep 0.25*speed_coef
  play :E4
  sleep 0.5*speed_coef
  play :Gs4
  sleep 0.5*speed_coef
  play :B4
  sleep 0.5*speed_coef
  play :E5
  sleep 0.25*speed_coef
  play :E5
  sleep 0.25*speed_coef
  
end



in_thread do
  loop do
    sample :drum_bass_hard
    sleep 0.25*speed_coef
  end
end

in_thread do
  loop do
    sample :bass_thick_c
    sleep 2*speed_coef
  end
end


play intro
sleep 1*speed_coef
2.times do
  play hizli
end




