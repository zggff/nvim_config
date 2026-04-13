require('config.general')
require('config.statusline')

local packer = require("misc.packer")
packer.setup(packer.require_dir("plugins"))
