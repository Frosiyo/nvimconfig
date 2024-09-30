vim.opt.guifont = { "Fira Code Nerd Font Mono Ret", "h12" }
vim.g.mapleader = " " --leader key, default is \

require("sfooz.lazy_init")

-- ----------------------------
-- Vim options
-- ----------------------------
local opt = opt
vim.opt.guicursor = ""

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.cursorline = false
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.backspace = "indent,eol,start"

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
    end,
});

--vim.opt.clipboard:append("unnamedplus") -- use system clipboard to copy

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

--vim.opt.iskeyword:append("/") -- consider slash as part of a word
--vim.opt.iskeyword:append(".") -- consider dot as part of a word
--vim.opt.iskeyword:append("-") -- consider dash as part of a word

-- Disable default fixme and todo highlighting
vim.cmd("hi clear FIXME")
vim.cmd("hi clear TODO")
vim.cmd("colorscheme off")

-- Disable the background colour.
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi LineNr guibg=NONE ctermbg=NONE")
vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
vim.cmd("hi WinBar guibg=NONE ctermbg=NONE")


-- ----------------------------
-- Keymaps
-- ----------------------------

local keymap = vim.keymap

-- Leave terminal mode by hitting esc.
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Leave Terminal mode (if in terminal)" })

local harpoon = require("harpoon")
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

keymap.set("n", "C-e", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
keymap.set("n", "<leader>a", function() harpoon:list():add() end)
keymap.set("n", "<leader><leader>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
keymap.set("n", "<leader>i", function() harpoon:list():prev() end)
keymap.set("n", "<leader>o", function() harpoon:list():next() end)

-- general

keymap.set("n", "<leader><Esc>", ":noh<CR>")

--

keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "H", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
--keymap.set("v", "<leader>p", [["_dP]])
--keymap.set({ "n", "v" }, "<leader>d", [["_d]])
keymap.set({ "n", "v" }, "x", [["_x]])
keymap.set({ "n", "v" }, "d", [["_d]])
keymap.set({ "n", "v" }, "c", [["_c]])
keymap.set({ "n", "v" }, "s", [["_s]])
keymap.set({ "n", "v" }, "yx", [[x]])
keymap.set({ "n", "v" }, "yd", [[d]])
keymap.set({ "n", "v" }, "yc", [[c]])
keymap.set({ "n", "v" }, "ys", [[s]])
keymap.set({ "n", "v" }, "X", [["_X]])
keymap.set({ "n", "v" }, "D", [["_D]])
keymap.set({ "n", "v" }, "C", [["_C]])
keymap.set({ "n", "v" }, "S", [["_S]])
keymap.set({ "n", "v" }, "yX", [[X]])
keymap.set({ "n", "v" }, "yD", [[D]])
keymap.set({ "n", "v" }, "yC", [[C]])
keymap.set({ "n", "v" }, "yS", [[S]])
keymap.set("v", "p", [["_dP]])

-- next greatest remap ever : asbjornHaland
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])
keymap.set({ "n", "v" }, "<leader>P", [["+P]])
keymap.set({ "n", "v" }, "<leader>p", [["+p]])
-- This is going to get me cancelled
keymap.set("i", "<C-c>", "<Esc>")

keymap.set("n", "Q", "<nop>")
keymap.set("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>")
keymap.set("n", "<leader>f", vim.lsp.buf.format)

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap.set("n", "<leader>R", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/vim.gI<Left><Left><Left>]])
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--keymap.set("n", "<leader><leader>", function() cmd("so") end)

-- plugin keymaps

keymap.set("n", "<c-_>", ':call feedkeys("gbc")<cr>', { desc = "Toggle Comment line/block (normal)" })
keymap.set("x", "<c-_>", "<Plug>(comment_toggle_blockwise_visual)<cr>", { desc = "Toggle Comment line/block (visual)" })

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle [E]xplorer tree" })

-- telescope
-- NOTE: Find more by using :Telescope builtin
keymap.set("n", "<leader>kb", "<cmd>Telescope keymaps<cr>", { desc = "View [K]ey [B]indings" })
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[F]ind [F]iles" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "[F]ile [S]earch" }) -- find text throughout proj
keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "[F]ind [W]ord under cursor" }) -- find first string under cursor
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[F]ind in active [B]uffers" }) -- show active buffers
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "[F]ind [R]ecently opened files" })
keymap.set("n", "<leader>fn", "<cmd>Telescope help_tags<cr>")
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "[F]ind in [D]iagnostics" })
keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Search [D]ocument [S]ymbols" }) -- list document symbols.
keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Search [W]orkspace [S]ymbols" }) -- list workspace symbols.
keymap.set("n", "<leader>dws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Search [D]ynamic [W]orkspace [S]ymbols" }) -- dynamically lists for all workspace symbols.
keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", { desc = "[G]oto [R]eferences" }) -- List references keymap.set( "n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "[/] Fuzzy find within current buffer" })
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Show [G]it [C]ommits" })
keymap.set("n", "<leader>gcb", "<cmd>Telescope git_bcommits<cr>", { desc = "Show [G]it [C]ommits for current [B]uffer" })
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Show [G]it [B]ranches" })
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Show [G]it [S]tatus" })

-- keybind options
--[[ local opts = { noremap = true, silent = true } ]]
keymap.set("n", "<leader>gf", "<cmd>Lspsaga finder<CR>", { desc = "[G]oto de[F]inition" }) -- show definition, references
keymap.set("n", "<leader>gd", "<Cmd>lua lsp.buf.declaration()<CR>", { desc = "[G]oto [D]eclaration" }) -- go to declaration
keymap.set("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", { desc = "[P]eek [D]efinition" }) -- see definition and make edits in window
keymap.set("n", "<leader>gi", "<cmd>lua lsp.buf.implementation()<CR>", { desc = "[G]oto [I]mplementation" }) -- go to implementation
keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "[C]ode [A]ction" }) -- see available code actions
keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "[R]e[N]ame" }) -- smart rename
keymap.set("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Show line [D]iagnostics" }) -- show  diagnostics for line
keymap.set("n", "<leader>dd", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "Show line [D]iagnostics" }) -- show  diagnostics for line
keymap.set("n", "Ld", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { desc = "Show cursor [d]iagnostics" }) -- show diagnostics for cursor
keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Jump to preious [D]iagnostic" }) -- jump to previous diagnostic in buffer
keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Jump to next [D]iagnostic" }) -- jump to next diagnostic in buffer
keymap.set("n", "<leader>K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Show documentation for what is under cursor" }) -- show documentation for what is under cursor

-- Build shortcuts
keymap.set("n", "<leader>bd", "<C-w>s<cr>|<cmd>:term ", { desc = "[B]uild [D]ebug" })
keymap.set("n", "<leader>br", "<C-w>s<cr>|<cmd>:term ./test.sh<CR>i", { desc = "[B]uild [R]elease" })
keymap.set("n", "<leader>bc", "<C-w>s<cr>|<cmd>:term ", { desc = "[B]uild->[C]lean" })


-- Disable the F1 help key because it's annoyingly close to esc and keeps getting hit.
keymap.set("n", "<F1>", "<nop>")
keymap.set("v", "<F1>", "<Esc>")
keymap.set("i", "<F1>", "<Esc>")

-- Map K to hover while session is active.

-- ----------------------------
-- Comment
-- ----------------------------
local comment_setup, comment = pcall(require, "Comment")
if not comment_setup then
	return
end

comment.setup()

-- ----------------------------
-- nvim-tree
-- ----------------------------

local nvimtree_setup, nvimtree = pcall(require, "nvim-tree")
if not nvimtree_setup then
	return
end

-- recommended settings from nvim-tree docs
vim.g.loadednetrw = 1
vim.g.loaded_netrwPlugin = 1

-- change color of arrows in tree
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvimtree.setup({
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- closed folder icon
					arrow_open = "", -- open folder icon
				},
			},
		},
	},
	-- disable window_picker for explorer to work well with window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
	filters = {
		dotfiles = false,
	},
	git = {
		ignore = false, -- show .gitignored files.
	},
})

-- open nvim-tree on startup
local function open_nvim_tree(data)
	-- buffer is a [No Name]
	local no_name = data.file == "" and bo[data.buf].buftype == ""

	-- buffer is a directory
	local directory = fn.isdirectory(data.file) == 1

	if not no_name and not directory then
		return
	end

	-- open the tree
	require("nvim-tree.api").tree.open()
end

-- NOTE: Enabling this will open this on startup.
-- api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- ----------------------------
-- lualine
-- ----------------------------

local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
	return
end

local lualine_nightfly = require("lualine.themes.nightfly")
local new_colors = {
	blue = "#65d1ff",
	green = "3effdc",
	violet = "#ff61ef",
	yellow = "#ffda7b",
	black = "#000000",
}

lualine_nightfly.normal.a.bg = new_colors.blue
lualine_nightfly.insert.a.bg = new_colors.green
lualine_nightfly.visual.a.bg = new_colors.violet
lualine_nightfly.command = {
	a = {
		gui = "bold",
		bg = new_colors.yellow,
		fg = new_colors.black,
	},
}

lualine.setup({
	options = {
		theme = lualine_nightfly,
		section_separators = "",
		component_separators = "",
	},
	sections = {
		lualine_c = {
			{
				"filename",
				path = 3,
			},
		},
	},
})

-- ----------------------------
-- telescope
-- ----------------------------

local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--no-ignore-vcs")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!{**/.git/*,**/*.c.o,**/*.c.d,**/node_modules/*,**/lib/*,**/webglpackage/*}")

telescope.setup({
	defaults = {
		hidden = true,
		vimgrep_arguments = vimgrep_arguments,
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			--[[ vimgrep_arguments = vimgrep_arguments, ]]
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = {
				"rg",
				"--files",
				"--hidden",
				"--no-ignore-vcs",
				"--glob",
				"!{**/.git/*,**/*.c.o,**/*.c.d,**/node_modules/*,**/lib/*,**/webglpackage/*}",
			},
		},
		live_grep = {
			-- Activates search for hidden files in live search
			additional_args = function(_ts)
				return { "--hidden" }
			end,
			--[[ file_ignore_patterns = { ".git/", "node_modules/", "webglpackage/" }, ]]
			--[[ glob_pattern = "!{**/.git/*,**/*.c.o,**/*.c.d,**/node_modules/*,**/lib/*,**/webglpackage/*}", ]]
		},
	},
})

telescope.load_extension("fzf")

-- ----------------------------
-- nvim-cmp
-- ----------------------------

-- completion plugin
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

-- snippet plugin
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

vim.opt.completeopt = "menu,menuone" -- noselect

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- prev suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll docs
		["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll docs
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-w>"] = cmp.mapping.abort(), -- close completion suggestions
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- show completion suggestions
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		{ name = "luasnip" }, --snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
})

-- ----------------------------
-- mason
-- ----------------------------

local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

mason.setup()

mason_lspconfig.setup({
	ensure_installed = {
		"html",
		"cssls",
		"lua_ls",
		"clangd", -- c
		"gopls",
        "kotlin_language_server",
	},
})

mason_null_ls.setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"eslint_d",
	},
})

-- ----------------------------
-- lspsaga
-- ----------------------------

local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	return
end

saga.setup({
	scroll_preview = { scroll_down = "<C-k>", scroll_up = "<C-j>" },
	-- use enter to open a file with definition preview
	definition = {
		edit = "<CR>",
	},
	ui = {
		colors = {
			normal_bg = "#022746",
		},
	},
})

-- ----------------------------
-- lspconfig
-- ----------------------------

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- enable keywords for available lsp server
local on_attach = function(client, bufnr)
	-- set keybinds
end

-- used to enable auto completion       capabilities = capabilities,
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["gopls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

local clangd_capabilities = capabilities
clangd_capabilities.offsetEncoding = "utf-8"
lspconfig["clangd"].setup({
	capabilities = clangd_capabilities,
	on_attach = on_attach,
})

lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			-- Make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- Make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

require('lspconfig').kotlin_language_server.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

-- ----------------------------
-- null-ls
-- ----------------------------

--local nullls_setup, null_ls = pcall(require, "null-ls")
--if not nullls_setup then
--	return
--end
--
--local formatting = null_ls.builtins.formatting
--local diagnostics = null_ls.builtins.diagnostics
--
--local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--
--null_ls.setup({
--	sources = {
--		formatting.prettier.with({
--			extra_args = { "--config", "./prettierrc" },
--			condition = function(utils)
--				return utils.root_has_file("./prettierrc")
--			end,
--		}),
--		formatting.stylua.with({
--			filetypes = { "lua" },
--		}),
--		formatting.eslint_d.with({
--			condition = function(utils)
--				return utils.root_has_file("./eslintrc.js")
--			end,
--		}),
--		formatting.clang_format,
--	},
	-- format on save
	--on_attach = function(current_client, bufnr)
	--	if current_client.supports_method("textDocument/formatting") then
	--		api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	--		api.nvim_create_autocmd("BufWritePre", {
	--			group = augroup,
	--			buffer = bufnr,
	--			callback = function()
	--				lsp.buf.format({
	--					filter = function(client)
	--						if client.name == "clangd" or client.name == "clang_format" then
	--							local ft = bo.filetype
	--							if ft == "c" or ft == "cpp" or ft == "objc" or ft == "objcpp" then
	--								return true
	--							end
	--						end
	--						-- Only use null-ls for formatting
	--						return client.name == "null-ls"
	--					end,
	--					bufnr = bufnr,
	--				})
	--			end,
	--		})
	--	end
	--end,
--})

-- ----------------------------
-- autopairs
-- ----------------------------
local autopairs_setup, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_setup then
	return
end

autopairs.setup({
	check_ts = true, -- enable it
	ts_config = {
		lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
		javascript = { "template_string" }, -- Don't add pairs in js template_string
		java = false,
	},
})

-- import nvim-autopairs completion functionality safely
local cmp_autopairs_setup, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_setup then
	return
end

-- import nvim-cmp plugin safely (completions plugin)
local cmp_setup, cmp_plugin = pcall(require, "cmp")
if not cmp_setup then
	return
end

-- make autopairs and completion work together
cmp_plugin.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- ----------------------------
-- treesitter
-- ----------------------------

-- import nvim-treesitter plugin safely
--local treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
--if not treesitter_status then
--	return
--end
--
---- configure treesitter
--treesitter.setup({
--	-- enable syntax highlighting
--	highlight = {
--		enable = false,
--	},
--	-- enable indentation
--	indent = { enable = true },
--	-- enable autotagging (w/ nvim-ts-autotag plugin)
--	autotag = { enable = true },
--	-- ensure these language parsers are installed
--	ensure_installed = {
--		"json",
--		"javascript",
--		"typescript",
--		"tsx",
--		"yaml",
--		"html",
--		"css",
--		"markdown",
--		"markdown_inline",
--		"svelte",
--		"graphql",
--		"bash",
--		"lua",
--		"vim",
--		"dockerfile",
--		"gitignore",
--		"c",
--		"java",
--		"cpp",
--		"go",
--	},
--	-- auto install above language parsers
--	auto_install = true,
--	move = {
--		enable = true,
--		set_jumps = true,
--		goto_next_start = {
--			["]m"] = "@function.outer",
--			["]]"] = "@class.outer",
--		},
--		goto_next_end = {
--			["]M"] = "@function.outer",
--			["]["] = "@class.outer",
--		},
--		goto_previous_start = {
--			["[m"] = "@function.outer",
--			["[["] = "@class.outer",
--		},
--		goto_previous_end = {
--			["[M"] = "@function.outer",
--			["[]"] = "@class.outer",
--		},
--	},
--})

-- ----------------------------
-- gitsigns
-- ----------------------------

local gitsigns_setup, gitsigns = pcall(require, "gitsigns")
if not gitsigns_setup then
	return
end

gitsigns.setup()

-- ----------------------------
-- todo-comments
-- ----------------------------

-- import todo-comments plugin safely
local todocomments_status, todocomments = pcall(require, "todo-comments")
if not todocomments_status then
	return
end

-- TODO: This is a todo message.
-- HACK: This is a hack.
-- FIXME: This should really be fixed.
-- NOTE: This is just a note.
-- LEFTOFF: This is where I left off.

local setup_config = {
	keywords = {
		TODO = { color = "#ff0000" },
		HACK = { color = "#ff6600" },
		NOTE = { color = "#008000" },
		FIXME = { color = "#f06292" },
		LEFTOFF = { color = "#ffff99" },
	},
	highlight = {
		pattern = [[(KEYWORDS)\s*(\([^\)]*\))?:]],
		keyword = "fg",
	},
}

todocomments.setup(setup_config)

