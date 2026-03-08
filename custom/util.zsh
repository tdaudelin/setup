# Usage: if command_exists java; then ... fi
function command_exists () {
  type $1 &> /dev/null
}

function hash () {
  echo -n $1 | shasum -a 256 | awk '{print $1}'
}