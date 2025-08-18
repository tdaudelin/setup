# https://gist.github.com/vitorbritto/0555879fe4414d18569d
# NOTE: Does not perform backup of local DB data
function remove_local_mysql () {
  echo 'It is highly recommended you use mysqldump to backup your databases first.'
  read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

  # kill any existing mysql processes. '[m]' is a trick to not return the 'grep mysql' process
  echo 'Killing all mysql processes...'
  kill $(ps aux | grep '[m]ysql' | awk '{print $2}') &> /dev/null

  echo 'Uninstalling from Homebrew...'
  brew remove mysql
  brew cleanup

  # cleanup any leftover files
  echo 'Cleaning up files...'
  sudo rm /usr/local/mysql
  sudo rm -rf /usr/local/var/mysql
  sudo rm -rf /usr/local/mysql*
  sudo rm ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
  sudo rm -rf /Library/StartupItems/MySQLCOM
  sudo rm -rf /Library/PreferencePanes/My*

  echo 'Unloadin g previous MySQL Auto-Login...'
  launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

  echo 'Removing previous MySQL Preferences...'
  rm -rf ~/Library/PreferencePanes/My*
  sudo rm -rf /Library/Receipts/mysql*
  sudo rm -rf /Library/Receipts/MySQL*
  sudo rm -rf /private/var/db/receipts/*mysql*

  echo 'Finished!'
  echo 'You should manually remove previous MySQL Configuration.'
  echo 'Edit this file: /etc/hostconfig'
  echo 'Remove the line MYSQLCOM=-YES-'
}

function setup_mysql () {
  if ! (command_exists docker); then
    echo 'Docker must be installed first!'
    return false
  fi
  usage() {
    echo "usage: setup_mysql -v <version>"
  }
  while getopts "v:" o; do
    case "${o}" in
      v)
        VERSION=${OPTARG}
        # I should realy validate $VERSION here
        ;;
      *)
        usage
        ;;
    esac
  done
  shift "$((OPTIND-1))"

  if [ -z $VERSION ]; then
    echo "Missing -v">&2
    usage
    return 1
  fi

  MYSQL_DATA_DIR="/Users/$(whoami)/Develop/mysql_data/$VERSION"
  mkdir -p $MYSQL_DATA_DIR

  docker network create dev-network

  docker run \
    --restart always \
    --name mysql$VERSION \
    --net dev-network \
    -v $MYSQL_DATA_DIR:/var/lib/mysql \
    -p 3306:3306 \
    -d \
    -e MYSQL_ROOT_PASSWORD=[your_password] \
    mysql:8.0
}