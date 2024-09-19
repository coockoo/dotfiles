function sync_nvim(){
  local nvim_dir=$HOME/.config/nvim
  if [[ ! -d $nvim_dir ]]; then
    mkdir -p $nvim_dir
  fi

  rm -rf $nvim_dir/after && cp -r nvim/after $nvim_dir/after
  rm -rf $nvim_dir/lua && cp -r nvim/lua $nvim_dir/lua
  rm -rf $nvim_dir/init.lua && cp nvim/init.lua $nvim_dir/init.lua
  rm -rf $nvim_dir/snippets && cp -r nvim/snippets $nvim_dir/snippets
  rm -rf $nvim_dir/.luarc.json && cp nvim/luarc.json $nvim_dir/.luarc.json
}

sync_nvim
