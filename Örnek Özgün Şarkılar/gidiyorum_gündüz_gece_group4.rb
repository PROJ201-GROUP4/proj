define :intro do
  
  use_synth :hoover
  play :F4
  sleep 0.25
  play :G4
  sleep 0.25
  play :G4
  sleep 0.5
  play :F4
  sleep 0.125
  play :E4
  sleep 0.125
  play :D4
  sleep 0.25
  play :F4
  sleep 0.25
  play :E4
  sleep 0.5
  play :D4
  sleep 0.25
  play :D4
  sleep 0.5
  play :D4
  sleep 0.5
  
  
  
  use_synth :hoover
  play :A4
  sleep 0.25
  play :G4
  sleep 0.25
  play :A4
  sleep 0.25
  play :F4
  sleep 0.25
  play :G4
  sleep 0.5
  play :F4
  sleep 0.125
  play :E4
  sleep 0.125
  play :D4
  sleep 0.25
  play :F4
  sleep 0.25
  play :E4
  sleep 0.5
  play :D4
  sleep 0.25
  play :D4
  sleep 0.5
  play :D4
  sleep 0.5
end


define :bilmiyorum do
  use_synth :chiplead
  sleep 0.5
  play :B4
  sleep 0.25
  play :C5
  sleep 0.25
  play :C5
  sleep 0.25
  play :B4
  sleep 0.25
  play :C5
  sleep 0.5
  play :C5
  sleep 0.25
  play :B4
  sleep 0.5
  play :A4
  sleep 0.25
  play :C5
  sleep 0.25
  play :B4
  sleep 0.25
  play :B4
  sleep 0.5
  
  
  play :C5
  sleep 0.25
  play :A4
  sleep 0.5
  play :G4
  sleep 0.25
  play :G4
  sleep 0.25
  play :A4
  sleep 0.25
  play :A4
  sleep 0.5
  play :A4
  sleep 0.5
  play :G4
  sleep 0.25
  play :F4
  sleep 0.25
  play :A4
  sleep 0.25
  play :G4
  sleep 0.25
  play :G4
  sleep 0.5
  
  play :G4
  sleep 0.5
  play :F4
  sleep 0.125
  play :E4
  sleep 0.125
  play :D4
  sleep 0.25
  play :G4
  sleep 0.25
  play :E4
  sleep 0.25
  play :F4
  sleep 0.5
  play :F4
  sleep 0.5
  play :E4
  sleep 0.25
  play :D4
  sleep 0.25
  play :F4
  sleep 0.25
  play :E4
  sleep 0.75
  play :E4
  sleep 0.5
  play :D4
  sleep 0.25
  play :C4
  sleep 0.25
  play :E4
  sleep 0.25
  play :D4
  sleep 0.25
  play :D4
  sleep 0.5
  play :D4
  sleep 1
end

in_thread do
  loop do
    sample :drum_heavy_kick
    sleep 0.5
    sample :drum_heavy_kick
    sleep 0.25
    sample :drum_heavy_kick
    sleep 0.25
    sample :drum_heavy_kick
    sleep 0.25
    sample :drum_heavy_kick
    sleep 0.5
  end
end

in_thread do
  loop do
    sample :drum_bass_hard
    sleep 1
  end
end


3. times do
  play intro
  play bilmiyorum
end

