#!/usr/bin/env bash
set -euo pipefail

########################################
# Configurações gerais
########################################
DOTFILES_DIR="$PWD"
BACKUP_DIR="$PWD/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

########################################
# Utilitários
########################################
log() {
  printf "\033[1;32m[INFO]\033[0m %s\n" "$1"
}

warn() {
  printf "\033[1;33m[WARN]\033[0m %s\n" "$1"
}

########################################
# Detecta sistema operacional
########################################
detect_os() {
  case "$(uname -s)" in
    Linux)  echo "linux" ;;
    Darwin) echo "macos" ;;
    *)      echo "unknown" ;;
  esac
}

OS="$(detect_os)"

if [[ "$OS" == "unknown" ]]; then
  echo "Sistema operacional não suportado"
  exit 1
fi

log "Sistema detectado: $OS"

########################################
# Backup seguro
########################################
backup_if_needed() {
  local target="$1"

  if [[ -e "$target" && ! -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$target" "$BACKUP_DIR/"
    warn "Backup criado para $target"
  fi
}

########################################
# Criação de symlink segura
########################################
link() {
  local source="$1"
  local target="$2"

  backup_if_needed "$target"

  ln -sf "$source" "$target"
  log "Symlink criado: $target -> $source"
}

########################################
# Garantir diretórios básicos
########################################
ensure_dirs() {
  mkdir -p "$HOME/.config"
  log "Diretórios base garantidos"
}

########################################
# Bootstrap principal
########################################
main() {
  log "Iniciando bootstrap de dotfiles"

  ensure_dirs

  link "$DOTFILES_DIR/config/zsh/.zshrc"        "$HOME/.zshrc"
  link "$DOTFILES_DIR/config/nvim"              "$HOME/.config/nvim"
  link "$DOTFILES_DIR/config/starship.toml"     "$HOME/.config/starship.toml"

  log "Bootstrap finalizado com sucesso"
}

main
