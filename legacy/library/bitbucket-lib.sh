# Download all repos from slugs from bitbucket
function download_all_repos_from_slug() {
    
    # check if team directory exists
    create_folder_if_doesnt_exist "~/dev/$TEAM"
    cd $TEAM

    NEXT_URL=$GIT_REPO
    
    while [ ! -z $NEXT_URL ]
    do
        curl -u $USER $NEXT_URL > repoinfo.json
        jq -r '.values[] | .links.clone[1].href' repoinfo.json > ../repos.txt
        NEXT_URL=`jq -r '.next' repoinfo.json`
 
        for repo in `cat ../repos.txt`
        do
            echo "Cloning" $repo
            if echo "$repo" | grep -q ".git"; then
                command="git"
            else
                command="hg"
            fi
            $command clone $repo
        done
    done

}
