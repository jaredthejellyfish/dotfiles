function nvm_find_nvmrc
    set dir $PWD
    while test -n "$dir" -a ! -f "$dir/.nvmrc"
        set dir (dirname "$dir")
        if test "$dir" = "/"
            set dir ""
        end
    end
    if test -f "$dir/.nvmrc"
        echo "$dir/.nvmrc"
    end
end
