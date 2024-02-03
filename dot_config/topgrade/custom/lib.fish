function commitIfChanged -a file
    if string length --quiet (git status --porcelain $file)
        git --no-pager diff $file
        git add $file
        git commit -m "chore: update buku bookmarks"
        echo "$file changes committed" >&2
    else
        echo "No changes detected in $file" >&2
    end
end
