local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- lockfile lives in the state dir because the config dir is a
-- read-only nix store symlink on NixOS
require("lazy").setup("buba.plugins", {
	lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
})
