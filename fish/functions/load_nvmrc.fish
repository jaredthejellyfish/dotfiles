function load_nvmrc --on-variable PWD
    set node_version (nvm current)
    set nvmrc_path (nvm_find_nvmrc)

    if test -n "$nvmrc_path"
        set nvmrc_node_version (cat "$nvmrc_path")

        if test "$nvmrc_node_version" = "N/A"
            nvm install
        else if test "$nvmrc_node_version" != "$node_version"
            nvm use $nvmrc_node_version
        end
    else
        # Get the default version using 'nvm ls' and handle if no default version exists
        set default_node_version 'system'
        
        if test -z "$default_node_version"
            echo "No default Node.js version found. Please install a version or set a default."
        else if test "$node_version" != "$default_node_version"
            echo "Reverting to nvm default version"
            nvm use $default_node_version
        end
    end
end
