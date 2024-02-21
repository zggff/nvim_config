local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    return
end

local ft = require('Comment.ft')
ft.set('arm', '//%s')
ft.set('asm', '//%s')
ft.set('gas', '//%s')

comment.setup({
    pre_hook =
        require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})
