local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<c-j>"] = cmp.mapping.select_next_item(),
		["<c-k>"] = cmp.mapping.select_prev_item(),
		["<c-f>"] = cmp.mapping.scroll_docs(4),
		["<c-b>"] = cmp.mapping.scroll_docs(-4),
		["<c-space>"] = cmp.mapping.complete(),
		["<c-e>"] = cmp.mapping.abort(),
		["<cr>"] = cmp.mapping.confirm({ select = false }),
		["<tab>"] = cmp.mapping(function(fallback)
			if luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end),
		["<s-tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end),
		["<a-j>"] = cmp.mapping(function()
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			end
		end),
		["<a-k>"] = cmp.mapping(function()
			if luasnip.choice_active() then
				luasnip.change_choice(-1)
			end
		end),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "nvim_lua" },
	}),
})

local cmp_autopairs_status, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_status then
	return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
