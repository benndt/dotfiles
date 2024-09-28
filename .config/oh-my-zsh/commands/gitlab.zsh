gitlab() {
  local ssh_url=$(git remote get-url --push origin)
  
  local host=${ssh_url#*@}
  host=${host%:*}

  local https_url="https://${host}/${ssh_url#*:}"

  google-chrome "${https_url}" > /dev/null 2>&1
}
