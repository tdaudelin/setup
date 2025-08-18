# Usage: if command_exists java; then ... fi
function command_exists () {
  type $1 &> /dev/null
}