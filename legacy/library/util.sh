# Add line to a file
# $1 - File Path
# $2 - Search Parameter
# $3 - Line to append
function _append_line() {
  local readonly FILE=$1
  local readonly SEARCH=$2
  local readonly LINE=$3

  if ! grep -qc $SEARCH "$FILE"
    then
    $LINE >> "$FILE"
  fi
}

# Add lines to profile files for all popular shell files
function _append_line_to_profiles() {
  local readonly SEARCH=$1
  local readonly LINE=$2
  _append_line ~/.bashrc $SEARCH "$LINE"
  _append_line ~/.profile $SEARCH "$LINE"
  _append_line ~/.zshrc $SEARCH "$LINE"
  _append_line ~/.zprofile $SEARCH "$LINE"

  if [ -f ~/.bash_profile ]
    then
    _append_line ~/.bash_profile $SEARCH "$LINE"
  fi

  if [ -f ~/.bash_login ]
    then
    _append_line ~/.bash_login $SEARCH "$LINE"
  fi
}

# What Operating System
function which_os(){
    case "$(uname -s)" in

       Darwin)
         echo 'mac'
         ;;

       Linux)
         echo 'linux'
         ;;

       CYGWIN*|MINGW32*|MSYS*|MINGW*)
         echo 'win'
         ;;

       *)
         echo 'other'
         ;;

    esac
}

# Create folder if doesn't exist
function create_folder_if_doesnt_exist() {
    if [ ! -d "$1" ]; then
      mkdir $1
    fi
}

# Setup the file structure for code
function set_up_file_structure () {
    create_folder_if_doesnt_exist ~/programming
}

function print_header() {
  echo ""
  echo "------------------------------------------------------------"
  echo $1
  echo "------------------------------------------------------------"
}

function print_info() {
  echo "+ $1"
}

function print_warn() {
  echo "- $1"
}

function print_error() {
  echo "[ERROR] $1"
}

function command_exists () {
  type $1 &> /dev/null
}

function zsh_custom () {
  echo ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
}
