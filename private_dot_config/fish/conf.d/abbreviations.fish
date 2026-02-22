if type -q eza
    abbr --add -g ls 'eza'
    abbr --add -g la 'eza --long --all'
end

if type -q bat
  abbr --add -g cat 'bat'
end

if type -q bundle
  abbr --add -g be 'bundle exec'
end

if type -q orka3
  abbr --add -g o3 'orka3'
end

if type -q gittower
  abbr --add -g g 'gittower .'
end

abbr --add -g o 'open .'

if type -q mise
  abbr --add -g mr 'mise run'
end
