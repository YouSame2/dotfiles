-- NOTE: IMPORTANT! this plugin/service offers free unlimited ai completion and agent (vscode only) BUT they use ur data to train. sooooooo ONLY i repeat ONLY enable this plugin on repos that are open source or u dont really care to much about. DO NOT ENABLE on personal projects. just use copilot or something else.
return {
	"augmentcode/augment.vim",
	cond = not vim.g.vscode,
	cmd = { "Augment" },
}
