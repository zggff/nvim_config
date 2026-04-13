require('config.general')
require('config.colorschemes')
require('config.statusline')

local packer = require("misc.packer")
packer.setup(packer.require_dir("plugins"))
