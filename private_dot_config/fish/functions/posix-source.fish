function posix-source
    for i in (cat $argv)
        if echo "$i" | grep -q '^\s*#'
            continue
        end

        set arr (string split -m1 = $i)
	
        if test -z $arr[1]
            continue
        end
        set -gx $arr[1] $arr[2]
    end
end
