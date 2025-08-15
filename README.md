export NVIM_PLUGINS_PATH="~/GitHub/plugins-nvim"
ln -s ~/.config/simple-nvim/ ~/GitHub/simple-nvim/
alias sn='NVIM_APPNAME=simple-nvim nvim' 


while IFS= read -r plugin; do
  plugin_name="${plugin##*/}"  # Извлекаем имя плагина
  git clone "https://github.com/$plugin.git" "$NVIM_PLUGINS_PATH/$plugin_name"
done < plugins.txt

test 2025-08-15 11:55
