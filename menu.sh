#!/usr/bin/env zsh
setopt KSH_ARRAYS   # 0-based array indexing
# ---------------------------------------------------------------------------
# menu.sh — reusable interactive checklist menu
#
# Usage:
#   source menu.sh
#   run_menu "My Title" MY_ITEMS_ARRAY
#
# MY_ITEMS_ARRAY must be a zsh array of "key|label|description" strings.
#
# After run_menu returns (user pressed i to confirm):
#   MENU_SELECTED  — array of keys the user selected (e.g. "brew" "docker")
#
# run_menu exits the process if the user presses q.
# ---------------------------------------------------------------------------

source "$(dirname "$0")/utils.sh"

# Public output — populated before run_menu returns
MENU_SELECTED=()

# ---------------------------------------------------------------------------
# Internal state (all prefixed _menu_ to avoid collisions)
# ---------------------------------------------------------------------------

_menu_items=()    # copy of the caller's items array
_menu_count=0
_menu_selected=() # parallel 0/1 flags
_menu_cursor=0
_menu_title=""

_menu_init() {
  _menu_title="$1"
  shift
  # Remaining args are the "key|label|description" item strings
  _menu_items=( "$@" )
  _menu_count=${#_menu_items[@]}
  _menu_selected=()
  local i
  for (( i=0; i<_menu_count; i++ )); do _menu_selected[i]=0; done
  _menu_cursor=0
}

# ---------------------------------------------------------------------------
# Selection helpers
# ---------------------------------------------------------------------------

_menu_toggle_all() {
  local i
  if _menu_any_selected; then
    for (( i=0; i<_menu_count; i++ )); do _menu_selected[i]=0; done
  else
    for (( i=0; i<_menu_count; i++ )); do _menu_selected[i]=1; done
  fi
}

_menu_toggle() {
  _menu_selected[$_menu_cursor]=$(( 1 - _menu_selected[$_menu_cursor] ))
}

_menu_any_selected() {
  local i
  for (( i=0; i<_menu_count; i++ )); do
    [[ "${_menu_selected[$i]}" -eq 1 ]] && return 0
  done
  return 1
}

_menu_collect_selected() {
  MENU_SELECTED=()
  local i key
  for (( i=0; i<_menu_count; i++ )); do
    if [[ "${_menu_selected[$i]}" -eq 1 ]]; then
      key="${_menu_items[$i]%%|*}"
      MENU_SELECTED+=( "$key" )
    fi
  done
}

# ---------------------------------------------------------------------------
# Rendering
# ---------------------------------------------------------------------------

_menu_draw_header() {
  local border="============================"
  printf "\n"
  printf "${BOLD}%s${RESET}\n" "$border"
  printf "${BOLD}  %s  ${RESET}\n" "$_menu_title"
  printf "${BOLD}%s${RESET}\n" "$border"
  printf "\n"
}

# Pass 1 on first call to save cursor position; 0 to redraw in-place.
_menu_draw_body() {
  local first="${1:-0}"
  local label description checkbox prefix i

  if [[ "$first" -eq 1 ]]; then
    tput sc
  else
    tput rc
    tput ed
  fi

  for (( i=0; i<_menu_count; i++ )); do
    label="${_menu_items[$i]#*|}"
    label="${label%%|*}"
    description="${_menu_items[$i]##*|}"

    if [[ "${_menu_selected[$i]}" -eq 1 ]]; then
      checkbox="${GREEN}[x]${RESET}"
    else
      checkbox="[ ]"
    fi

    if [[ "$i" -eq "$_menu_cursor" ]]; then
      prefix="${CYAN}${BOLD}> ${RESET}"
      printf "%s%s ${CYAN}${BOLD}%-28s${RESET} ${DIM}%s${RESET}\n" \
        "$prefix" "$checkbox" "$label" "$description"
    else
      prefix="  "
      printf "%s%s %-28s ${DIM}%s${RESET}\n" \
        "$prefix" "$checkbox" "$label" "$description"
    fi
  done

  printf "\n"
  printf "  ${DIM}↑/↓ move  |  space = toggle  |  a = toggle all  |  enter = install  |  q = quit${RESET}\n"
  printf "\n"
}

# ---------------------------------------------------------------------------
# Input
# ---------------------------------------------------------------------------

_menu_key=""
_menu_read_key() {
  local b0 b1 b2
  read -r -s -k1 b0
  if [[ "$b0" == $'\x1b' ]]; then
    read -r -s -k1 -t 0.1 b1 || true
    read -r -s -k1 -t 0.1 b2 || true
    if [[ "$b1" == "[" ]]; then
      case "$b2" in
        A) _menu_key="UP"    ; return ;;
        B) _menu_key="DOWN"  ; return ;;
        C) _menu_key="RIGHT" ; return ;;
        D) _menu_key="LEFT"  ; return ;;
      esac
    fi
    _menu_key=""
    return
  fi
  case "$b0" in
    ''|$'\n') _menu_key="ENTER" ;;
    ' ')      _menu_key="SPACE" ;;
    *)        _menu_key="$b0"   ;;
  esac
}

# ---------------------------------------------------------------------------
# Public entry point
#
#   run_menu <items_array_name> <title>
# ---------------------------------------------------------------------------

run_menu() {
  local title="$1"
  shift

  _menu_init "$title" "$@"

  cursor_hide
  trap 'cursor_show; printf "\n"' EXIT INT TERM

  _menu_draw_header
  _menu_draw_body 1

  while true; do
    _menu_read_key

    case "$_menu_key" in
      UP)
        _menu_cursor=$(( (_menu_cursor - 1 + _menu_count) % _menu_count ))
        ;;
      DOWN)
        _menu_cursor=$(( (_menu_cursor + 1) % _menu_count ))
        ;;
      SPACE)
        _menu_toggle
        ;;
      a|A)
        _menu_toggle_all
        ;;
      ENTER)
        if _menu_any_selected; then
          _menu_collect_selected
          cursor_show
          trap - EXIT INT TERM
          return 0
        fi
        ;;
      q|Q)
        cursor_show
        trap - EXIT INT TERM
        printf "\n"
        return 1
        ;;
    esac

    _menu_draw_body 0
  done
}
