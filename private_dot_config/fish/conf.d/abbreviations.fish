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
