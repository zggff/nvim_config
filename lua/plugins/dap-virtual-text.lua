local dap_status_ok, dap_text = pcall(require, "nvim-dap-virtual-text")
if not dap_status_ok then
	return
end

dap_text.setup({
	highlight_changed_variables = true,
	all_frames = true,
	enabled_commands = true,
})
