Linux and git Bash

Git bash allows you to run Linux commands natively in Windows DOS prompt

cd (changes directory)

cd ~ (changes to home directory)

cd .. (moves up one directory)

cd /D/ (change to D:\ drive)

ls (lists files in folder)

pwd (shows current directory)

mkdir <FOLDERNAME> (creates new directory)

touch <FILENAME> (creates a file)

open . (opens the current folder. MAC SPECIFIC) or explorer . (opens the specific file. WINDOWS SPECIFIC)

mv sample.txt test (moves the file "sample.txt" to a subfolder named "test")

mv sample.txt example.txt (renames the file)

When typing a file or directory name, we can use the tab key to auto-complete that file or directory name.

~~~
git init - creates a new repository by creating a new .git directory
git add <file> -- adds file(s) to the Staging area (pre-commit)
git status -- will display diff b/w staging area and repo
git commit -- takes all changes in staging area and commits them
git push -- takes your local changes and pushes to remote repo
git pull -- get latest changes from remote repo
git clone -- copies remote repo to your local folder
git --version
touch -- creates new files ("touch index.html" will create a new empty file)
~~~~