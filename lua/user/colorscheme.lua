--vim.cmd [[
--try
--  colorscheme darkplus
--catch /^Vim\%((\a\+)\)\=:E185/
--  colorscheme default
--  set background=dark
-- endtry
--]]

-- gc

local dn = require('dark_notify')

dn.run({
    schemes = {
      dark  = "ayu-mirage",
    light = "ayu-light"
    },
    })

dn.update()
 -- 
