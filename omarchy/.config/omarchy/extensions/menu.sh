# Overwrite parts of the omarchy-menu with user-specific submenus.
# See $OMARCHY_PATH/bin/omarchy-menu for functions that can be overwritten.
#
# WARNING: Overwritten functions will obviously not be updated when Omarchy changes.
#
# Example of minimal system menu:
#
# show_system_menu() {
#   case $(menu "System" "  Lock\n󰐥  Shutdown") in
#   *Lock*) omarchy-lock-screen ;;
#   *Shutdown*) omarchy-system-shutdown ;;
#   *) back_to show_main_menu ;;
#   esac
# }


show_main_menu() {
  go_to_menu "$(menu "Go" "󰀻  Apps\n󱓞  Trigger\n  Style\n  Setup\n󰉉  Install\n󰭌  Remove\n  Update\n  System")"
}

show_setup_menu() {
  local options="  Audio\n  Wifi\n󰂯  Bluetooth\n󱐋  Power Profile\n  System Sleep\n󰍹  Monitors"
  [[ -f ~/.config/hypr/bindings.conf ]] && options="$options\n  Keybindings"
  [[ -f ~/.config/hypr/input.conf ]] && options="$options\n  Input"
  options="$options\n󰱔  DNS\n  Security\n  Config"

  case $(menu "Setup" "$options") in
  *Audio*) omarchy-launch-audio ;;
  *Wifi*) omarchy-launch-or-focus-tui nmtui;;
  *Bluetooth*) omarchy-launch-bluetooth ;;
  *Power*) show_setup_power_menu ;;
  *System*) show_setup_system_menu ;;
  *DNS*) present_terminal omarchy-setup-dns ;;
  *Security*) show_setup_security_menu ;;
  *) show_main_menu ;;
  esac
}

#
# Example of overriding just the about menu action: (Using zsh instead of bash (default))
#
# show_about() {
#   exec omarchy-launch-or-focus-tui "zsh -c 'fastfetch; read -k 1'"
# }
