define :kick1 do
  sample :drum_heavy_kick
  sleep 0.5
end

define :hat do
  sleep 0.25
  sample :drum_cymbal_closed
  sleep 0.25
end

define :hat2 do
  sleep 0.25
  sample :drum_cymbal_closed
  sleep 0.125
  sample :drum_cymbal_closed
  sleep 0.375
  sample :drum_cymbal_closed
  sleep 0.25
end

define :melody do
  use_synth :piano
  3.times do
    play :A4
    sleep 0.5
    play :A4
    sleep 0.25
    play :E4
    sleep 0.25
    play :C5
    sleep 1.25
    play :D5
    sleep 0.25
    play :C5
    sleep 0.25
    play :E4
    sleep 0.25
    play :C5
    sleep 0.25
    play :E4
    sleep 0.25
    play :A4
    sleep 0.5
  end
  play :D5
  sleep 0.5
  play :C5
  sleep 0.5
  play :A4
  sleep 0.5
  play :E4
  sleep 0.5
  play :G4
  sleep 0.5
  play :C5
  sleep 0.25
  play :B4
  sleep 0.25
  play :C5
  sleep 0.5
  
end

define :bass do
  sample :bass_hard_c, attack: 1, amp: 0.25
  sleep 4
end


define :intro do
  in_thread do
    loop do
      kick1
    end
    
  end
  
  sleep 4
  
  in_thread do
    loop do
      hat
    end
  end
  
  sleep 4
  
  4.times do
    in_thread do
      melody
    end
    
    bass
  end
  
end

define :part1 do
  in_thread do
    loop do
      sample :drum_cymbal_pedal
      sleep 0.5
    end
  end
  
  in_thread do
    sleep 0.5
    loop do
      sample :drum_snare_hard
      sleep 1
    end
  end
  
  in_thread do
    sleep 0.25
    loop do
      sample :drum_tom_mid_hard , amp: 0.1
      sleep 0.5
    end
  end
  
  in_thread do
    loop do
      sample :drum_cymbal_open, amp: 0.1
      sleep 4
    end
  end
  in_thread do
    sleep 3.9
    loop do
      sample :drum_snare_soft
      sleep 4
    end
  end
  
  in_thread do
    
    
    
    use_synth :chipbass
    4.times do
      play :A4
      sleep 0.5
      play :A4
      sleep 0.25
      play :E4
      sleep 0.25
      play :C5
      sleep 1.25
      play :D5
      sleep 0.25
      play :C5
      sleep 0.25
      play :E4
      sleep 0.25
      play :C5
      sleep 0.25
      play :E4
      sleep 0.25
      play :A4
      sleep 0.5
    end
    play :D5
    sleep 0.5
    play :C5
    sleep 0.5
    play :A4
    sleep 0.5
    play :E4
    sleep 0.5
    play :G4
    sleep 0.5
    play :C5
    sleep 0.25
    play :B4
    sleep 0.25
    play :C5
    sleep 0.5
    
  end
  
  in_thread do
    with_fx :flanger do
      with_fx :wobble do
        use_synth :chiplead
        4.times do
          play :A4
          sleep 0.5
          play :A4
          sleep 0.25
          play :E4
          sleep 0.25
          play :C5
          sleep 1.25
          play :D5
          sleep 0.25
          play :C5
          sleep 0.25
          play :E4
          sleep 0.25
          play :C5
          sleep 0.25
          play :E4
          sleep 0.25
          play :A4
          sleep 0.5
        end
        play :D5
        sleep 0.5
        play :C5
        sleep 0.5
        play :A4
        sleep 0.5
        play :E4
        sleep 0.5
        play :G4
        sleep 0.5
        play :C5
        sleep 0.25
        play :B4
        sleep 0.25
        play :C5
        sleep 0.5
        
      end
      
    end
    
  end
end

define :part2 do
  in_thread do
    loop do
      sample :drum_cymbal_pedal
      sleep 0.5
    end
  end
  
  in_thread do
    sleep 0.5
    loop do
      sample :drum_snare_hard
      sleep 1
    end
  end
  
  in_thread do
    sleep 0.25
    loop do
      sample :drum_tom_mid_hard , amp: 0.1
      sleep 0.5
    end
  end
  
  in_thread do
    loop do
      sample :drum_cymbal_open, amp: 0.1
      sleep 4
    end
  end
  in_thread do
    sleep 3.9
    loop do
      sample :drum_snare_soft
      sleep 4
    end
  end
  
  in_thread do
    
    
    
    use_synth :chiplead
    4.times do
      play :A4
      sleep 0.5
      play :A4
      sleep 0.25
      play :E4
      sleep 0.25
      play :C5
      sleep 1.25
      play :D5
      sleep 0.25
      play :C5
      sleep 0.25
      play :E4
      sleep 0.25
      play :C5
      sleep 0.25
      play :E4
      sleep 0.25
      play :A4
      sleep 0.5
    end
    play :D5
    sleep 0.5
    play :C5
    sleep 0.5
    play :A4
    sleep 0.5
    play :E4
    sleep 0.5
    play :G4
    sleep 0.5
    play :C5
    sleep 0.25
    play :B4
    sleep 0.25
    play :C5
    sleep 0.5
    
  end
  
  in_thread do
    
    in_thread do
      loop do
        sample :drum_cymbal_pedal
        sleep 0.5
      end
    end
    
    in_thread do
      sleep 0.5
      loop do
        sample :drum_snare_hard
        sleep 1
      end
    end
    
    in_thread do
      sleep 0.25
      loop do
        sample :drum_tom_mid_hard , amp: 0.1
        sleep 0.5
      end
    end
    
    in_thread do
      loop do
        sample :drum_cymbal_open, amp: 0.1
        sleep 4
      end
    end
    in_thread do
      sleep 3.9
      loop do
        sample :drum_snare_soft
        sleep 4
      end
    end
    
    in_thread do
      
      
      
      use_synth :fm
      3.times do
        play :A4
        sleep 0.5
        play :A4
        sleep 0.25
        play :E4
        sleep 0.25
        play :C5
        sleep 1.25
        play :D5
        sleep 0.25
        play :C5
        sleep 0.25
        play :E4
        sleep 0.25
        play :C5
        sleep 0.25
        play :E4
        sleep 0.25
        play :A4
        sleep 0.5
      end
      play :D5
      sleep 0.5
      play :C5
      sleep 0.5
      play :A4
      sleep 0.5
      play :E4
      sleep 0.5
      play :G4
      sleep 0.5
      play :C5
      sleep 0.25
      play :B4
      sleep 0.25
      play :C5
      sleep 0.5
      
    end
    
    in_thread do
      with_fx :bitcrusher do
        with_fx :whammy do
          use_synth :dark_ambience
          4.times do
            play :A4
            sleep 0.5
            play :A4
            sleep 0.25
            play :E4
            sleep 0.25
            play :C5
            sleep 1.25
            play :D5
            sleep 0.25
            play :C5
            sleep 0.25
            play :E4
            sleep 0.25
            play :C5
            sleep 0.25
            play :E4
            sleep 0.25
            play :A4
            sleep 0.5
          end
          play :D5
          sleep 0.5
          play :C5
          sleep 0.5
          play :A4
          sleep 0.5
          play :E4
          sleep 0.5
          play :G4
          sleep 0.5
          play :C5
          sleep 0.25
          play :B4
          sleep 0.25
          play :C5
          sleep 0.5
          
        end
        
      end
      
    end
    
    
    
  end
end




intro
part1
intro
part2
stop

