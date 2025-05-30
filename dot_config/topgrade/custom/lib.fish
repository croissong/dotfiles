function commitIfChanged -a file -a msg
    if string length --quiet (git status --porcelain $file)
        git --no-pager diff --ignore-all-space $file
        git add $file
        git commit -m "chore: update $msg"
        echo "$file changes committed" >&2
    else
        echo "No changes detected in $file" >&2
    end
end
