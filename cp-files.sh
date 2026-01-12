#!/bin/bash

config_path="$HOME/.config"

bashrc="$HOME/.bashrc"

pkg_configs_to_backup=(
  "hypr"
  "waybar"
  # "nvim"
)

hypr_conf=(
  "bindings.conf"
  "input.conf"
  "hypridle.conf" 
  "monitors.conf" 
  "looknfeel.conf" 
)

waybar_conf=(
  "config.jsonc"
  "style.css"
)

nvim_conf=("nvim")

wallpaper_urls_github=(
  "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/minimalistic/black5_unicat.png"
  "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/flatpuccin/flatpuccin_4k_macchiato.png"
)

SCRIPT_DIR="$(dirname "$0")"

echo ""
echo "Starting backup..."
echo ""

copy_files() {
  local pkg=$1

  local files_var="${pkg}_conf[@]"
  local files=("${!files_var}")
  local pkg_src_path="${config_path}/${pkg}"
  local pkg_bak_path="${SCRIPT_DIR}/$pkg"

  # Check if source directory exists
  if [ ! -d "$pkg_src_path" ]; then
    echo "Warning: Source directory '$pkg_src_path' does not exist. Skipping $pkg."
    return
  fi

  # Create backup directory if it doesn't exist
  if [ ! -d "$pkg_bak_path" ]; then
    echo "Creating backup directory '$pkg_bak_path'"
    mkdir -p "$pkg_bak_path"
  fi

  echo "Copying files from $pkg config to '$pkg_bak_path'"
  for file in "${files[@]}"; do
    local src_file="${pkg_src_path}/${file}"
    if [ -e "$src_file" ]; then
      echo "Copying $file"
      cp "$src_file" "${pkg_bak_path}/$file"
    else
      echo "Warning: File '$src_file' does not exist. Skipping."
    fi
  done
}

for pkg in "${pkg_configs_to_backup[@]}"; do
  copy_files "$pkg"
done

echo "Copying Neovim configs"

nvim_src_path="$config_path/$nvim_conf"
nvim_bak_path="${SCRIPT_DIR}/nvim"

if [ -d "$nvim_src_path" ]; then
  mkdir -p "$nvim_bak_path"
  cp -r "$nvim_src_path" "$nvim_bak_path/"
else
  echo "Warning: Neovim config directory '$nvim_src_path' does not exist. Skipping."
fi

echo "Copying 'bashrc'"

bashrc_bak_path="${SCRIPT_DIR}/bash-config"

if [ -f "$bashrc" ]; then
  mkdir -p "$bashrc_bak_path"
  cp "$bashrc" "$bashrc_bak_path/"
else
  echo "Warning: bashrc file '$bashrc' does not exist. Skipping."
fi

echo ""
echo "Completed file copying"
echo ""
