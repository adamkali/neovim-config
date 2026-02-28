---@diagnostic disable: undefined-global
--- https://www.lua.org/pil/20.2.html

return {
	s("mproton", t("adam.kalilarosa@proton.me")),
	s("mlas", t("adam@legalautomationsystems.com")),
	s("gh", t("github.com/adamkali")),
	s("file", t(vim.api.nvim_buf_get_name(0))),
	s("filedir", t(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h"))),
	s("filename", t(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t"))),
}

