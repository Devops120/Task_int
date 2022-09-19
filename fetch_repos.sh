#!/bin/bash

## script input as org_name and get the repo url for each repo and print public or private

if [ $# -ne 1 ]
then
    echo "In Order to run the script , please provide a valid git repository name"
    exit;
else
    echo "Valided inputs successfully"
fi

# Projectname
GHUSER=$1

# get the list of repos for the project
page_index=1

# loop until there is no data fetched from URL
while :;
do
    data=$(curl "https://api.github.com/users/$GHUSER/repos?per_page=100&page=$page_index" | jq -r ".[] | [.ssh_url, .name] | @tsv")

    # exit when there is no data
    [[ -z "$data" ]] && exit 0

    # loop every repo
    while read repo_info
    do
        repo_url=$(awk '{print $1}' <<< $repo_info)
        repo_name=$(awk '{print $2}' <<< $repo_info)
        echo "repo name is '$repo_name' and its url is '$repo_url' and since it is able to fetch from internet it is public repo"
    done <<< "$data"

    page_index=$((page_index + 1))
done
