---@diagnostic disable: undefined-field
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-R>=UltiSnips#ExpandSnippet()<CR>", true, true, true), "")
      elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-R>=UltiSnips#JumpForwards()<CR>", true, true, true), "")
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-R>=UltiSnips#JumpBackwards()<CR>", true, true, true), "")
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'ultisnips', priority = 1000 },
    { name = 'nvim_lsp',  priority = 750 },
  }, {
    { name = 'buffer', priority = 500 },
    { name = 'path',   priority = 250 },
  }),
  sorting = {
    priority_weight = 2,
    comparators = {
      function(entry1, entry2)
        local s1 = entry1.source.name == 'ultisnips'
        local s2 = entry2.source.name == 'ultisnips'
        if s1 and not s2 then return true end
        if s2 and not s1 then return false end
      end,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})


cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
