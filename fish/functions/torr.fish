function torr
  if test -z $argv
    echo "Usage: torr [magnet_link]"
    return 1
  end

  set input_string $argv[1]


  aria2c --seed-time='0' $input_string

end
