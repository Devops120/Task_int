#script input as org_name and get the repo url for each repo and print public or private

if [ $# -ne 1 ]; 
    then 
       echo "In Order to run the script , please provide a valid git repository name"
       exit;
    else 
       echo "Valided inputs successfully"
fi

#Projectname 
GHUSER=$1; 


#get the list of repos for the project 
curl "https://api.github.com/users/$GHUSER/repos?per_page=1000" | grep -o 'git@[^"]*' >$GHUSER.out

for i in `cat repos1.out`
do
repo_url=$i
repo=${repo_url##*/}
echo repo name is ${repo%%.*} and its url is $i and since it is able to fetch from internet it is public repo
done
