function gitignore --argument-names cmd --description "A plugin for git"
    switch "$cmd"
        case -v --version
            echo "gitignore, version 0.1.0"
        case "" -h --help
            echo "Usage: gitignore clean              Remove files in gitignore from git cache"
            echo "       gitignore generate                Generate a basic gitignore file"
            echo "Options:"
            echo "       -v or --version  Print version"
            echo "       -h or --help     Print this help message"
        case clean
            git rm --cached `git ls-files -ic --exclude-from=.gitignore`
            echo ""
        case generate
            curl -L -s https://www.gitignore.io/api/rails,macos,visualstudiocode > .gitignore
            echo "Generated .gitignore file in" (pwd)
        case \*
            echo "Unknown command: $cmd"
            echo "Run 'gitignore --help' for usage"
    end
end
