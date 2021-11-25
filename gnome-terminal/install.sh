#!/usr/bin/env bash
dir=$(dirname "$0")

declare -a schemes
schemes=($(cd $dir/colors && echo * && cd - > /dev/null))

source $dir/src/tools.sh
source $dir/src/profiles.sh
source $dir/src/dircolors.sh

show_help() {
  echo "Usage: install.sh [-h] [-s <scheme>] [-p <profile>]"
  echo
  echo "Options"
  echo "  -h, --help"
  echo "    Show this information"
  echo "  -s scheme, --scheme scheme, --scheme=scheme"
  echo "    Color scheme to be used (will be asked otherwise)"
  echo "  -p profile, --profile profile, --profile profile"
  echo "    Gnome Terminal profile to overwrite (will be asked otherwise)"
  echo "  --install-dircolors, --skip-dircolors"
  echo "    Do or skip the dircolors installation in a non interactive mode"
}

validate_scheme() {
  local profile=$1
  in_array $scheme "${schemes[@]}" || die "$scheme is not a valid scheme" 2
}

set_profile_colors() {
  local profile=$1
  local scheme=$2
  local scheme_dir=$dir/colors/$scheme

  local bg_color_file=$scheme_dir/bg_color
  local fg_color_file=$scheme_dir/fg_color
	local cursor_bg_color_file=$scheme_dir/cursor_bg_color
	local cursor_fg_color_file=$scheme_dir/cursor_fg_color
	local font_file=$scheme_dir/font
	local scrollbar_file=$scheme_dir/scrollbar

  if [ "$newGnome" = "1" ]
    then local profile_path=$dconfdir/$profile

    dconf write $profile_path/palette "$(to_dconf < $scheme_dir/palette)"

    dconf write $profile_path/background-color "'$(cat $bg_color_file)'"
    dconf write $profile_path/foreground-color "'$(cat $fg_color_file)'"
    dconf write $profile_path/cursor-background-color "'$(cat $cursor_bg_color_file)'"
    dconf write $profile_path/cursor-foreground-color "'$(cat $cursor_fg_color_file)'"
    dconf write $profile_path/font "'$(cat $font_file)'"
    dconf write $profile_path/scrollbar-policy "'$(cat $scrollbar_file)'"
		
		dconf write $profile_path/use-system-font "false"
		dconf write $profile_path/cursor-colors-set "true"
    dconf write $profile_path/audible-bell "false"
		dconf write $profile_path/use-theme-colors "false"

  else
    local profile_path=$gconfdir/$profile

    gconftool-2 -s -t string $profile_path/palette "$(to_gconf < $scheme_dir/palette)"

    gconftool-2 -s -t string $profile_path/background_color $(cat $bg_color_file)
    gconftool-2 -s -t string $profile_path/foreground_color $(cat $fg_color_file)
    gconftool-2 -s -t string $profile_path/cursor-background-color $(cat $cursor_bg_color_file)
    gconftool-2 -s -t string $profile_path/cursor-foreground-color $(cat $cursor_fg_color_file)
		gconftool-2 -s -t string $profile_path/font $(cat $font_file)
		gconftool-2 -s -t string $profile_path/scrollbar-policy $(cat $scrollbar_file)

		gconftool-2 -s -t bool $profile_path/use-system-font false
		gconftool-2 -s -t bool $profile_path/cursor-colors-set true
		gconftool-2 -s -t bool $profile_path/audible-bell false
    gconftool-2 -s -t bool $profile_path/use_theme_colors false
  fi
}

interactive_help() {
  echo
  echo -en "This script will ask you which color scheme you want, and which "
  echo -en "Gnome Terminal profile to overwrite.\n"
  echo
  echo -en "Please note that there is no uninstall option yet. If you do not "
  echo -en "wish to overwrite any of your profiles, you should create a new "
  echo -en "profile before you run this script. However, you can reset your "
  echo -en "colors to the Gnome default, by running:\n"
  echo
  echo "    Gnome >= 3.8 dconf reset -f /org/gnome/terminal/legacy/profiles:/"
  echo "    Gnome < 3.8 gconftool-2 --recursive-unset /apps/gnome-terminal"
  echo
  echo -en "By default, it runs in the interactive mode, but it also can be "
  echo -en "run non-interactively, just feed it with the necessary options, "
  echo -en "see 'install.sh --help' for details.\n"
  echo
}

interactive_select_scheme() {
  echo "Please select a color scheme:"
  select scheme
  do
    if [[ -z $scheme ]]
    then
      die "ERROR: Invalid selection -- ABORTING!" 2
    fi
    break
  done
  echo
}

interactive_confirm() {
  local confirmation

  echo    "You have selected:"
  echo
  echo    "  Scheme:  $scheme"
  echo    "  Profile: $(get_profile_name $profile) ($profile)"
  echo
  echo    "Are you sure you want to overwrite the selected profile?"
  echo -n "(YES to continue) "

  read confirmation
  if [[ $(echo $confirmation | tr '[:lower:]' '[:upper:]') != YES ]]
  then
    die "ERROR: Confirmation failed -- ABORTING!"
  fi

  echo    "Confirmation received -- applying settings"
}

while [ $# -gt 0 ]
do
  case $1 in
    -h | --help )
      show_help
      exit 0
    ;;
    --scheme=* )
      scheme=${1#*=}
    ;;
    -s | --scheme )
      scheme=$2
      shift
    ;;
    --profile=* )
      profile=${1#*=}
    ;;
    -p | --profile )
      profile=$2
      shift
    ;;
    --install-dircolors )
      install_dircolors=true
    ;;
    --skip-dircolors )
      install_dircolors=false
    ;;
  esac
  shift
done

if [[ -z "$scheme" ]] || [[ -z "$profile" ]]
then
  interactive_help
fi

if [[ -n "$scheme" ]]
  then validate_scheme $scheme
else
  interactive_select_scheme "${schemes[@]}"
fi

if [[ -n "$profile" ]]
  then if [ "$newGnome" = "1" ]
    then profile="$(get_uuid "$profile")"
  fi
  validate_profile $profile
else
  if [ "$newGnome" = "1" ]
    then check_empty_profile
  fi
  interactive_select_profile "${profiles[@]}"
  interactive_confirm
fi

set_profile_colors $profile $scheme

if [ -n "$install_dircolors" ]
    then if "$install_dircolors"
        then copy_dircolors
    fi
else
    check_dircolors || warning_message_dircolors
fi