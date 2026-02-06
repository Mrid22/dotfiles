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
#   *Shutdown*) omarchy-cmd-shutdown ;;
#   *) back_to show_main_menu ;;
#   esac
# }
# 
# Example of overriding just the about menu action: (Using zsh instead of bash (default))
# 
# show_about() {
#   exec omarchy-launch-or-focus-tui "zsh -c 'fastfetch; read -k 1'"
# }
#
show_main_menu() {
  go_to_menu "$(menu "Go" "󰀻  Apps\n󱓞  Trigger\n  Style\n  Setup\n󰉉  Install\n󰭌  Remove\n  Update\n  About\n  System")"
}

go_to_menu() {
  case "${1,,}" in
  *apps*) walker -p "Launch…" ;;
  *trigger*) show_trigger_menu ;;
  *share*) show_share_menu ;;
  *style*) show_style_menu ;;
  *theme*) show_theme_menu ;;
  *screenshot*) show_screenshot_menu ;;
  *screenrecord*) show_screenrecord_menu ;;
  *setup*) show_setup_menu ;;
  *power*) show_setup_power_menu ;;
  *install*) show_install_menu ;;
  *remove*) show_remove_menu ;;
  *update*) show_update_menu ;;
  *about*) omarchy-launch-about ;;
  *system*) show_system_menu ;;
  esac
}
