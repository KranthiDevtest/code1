#!/bin/sh
# 
# github.sh
# - create a new repository in Github

# get user name
username=KranthiDevtest
if [ "$username" = "" ]; then
    echo "Could not find username, run 'git config --global github.user <username>'"
    invalid_credentials=1
fi

# get repo name
dir_name=`basename $(pwd)`
read -p "Do you want to use '$dir_name' as a repo name?(y/n)" answer_dirname
case $answer_dirname in
  y)
    # use currently dir name as a repo name
    reponame=$dir_name
    ;;
  n)
    read -p "Enter your new repository name: " reponame
    if [ "$reponame" = "" ]; then
        reponame=$dir_name
    fi
    ;;
  *)
    ;;
esac


# create repo
echo "Creating Github repository '$reponame' ..."
curl -u $username https://api.github.com/user/repos -d '{"name":"'$reponame'"}'
echo " done."

# create empty README.md
echo "Creating README ..."
touch README.md
echo " done."

# push to remote repo
echo "Pushing to remote ..."
git init
echo "testscript.sh" > .gitignore
echo ".gitignore" >> .gitignore
git config --global core.excudefiles ~/.gitignore_global
git add -A
git commit -m "first commit"
git remote rm origin
git remote add origin https://github.com/$username/$reponame.git
git push -u origin master
echo " done."

