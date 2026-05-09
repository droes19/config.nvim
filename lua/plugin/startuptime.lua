local pack = require("pack")

pack.add({ "dstein64/vim-startuptime" }, {
  load = pack.on_load({
    pkg_name = "vim-startuptime",
    cmd = "StartupTime",
  }),
})
