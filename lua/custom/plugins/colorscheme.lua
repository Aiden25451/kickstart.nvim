local ColorScheme = {
  TOKYO = 'tokyo',
  NORD = 'nord',
}

local function loadColorscheme()
  local colorscheme = ColorScheme.NORD

  if colorscheme == ColorScheme.NORD then
    return {
      'shaunsingh/nord.nvim',
      config = function()
        vim.cmd [[colorscheme nord]]
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
      end,
    }
  elseif colorscheme == ColorScheme.TOKYO then
    return {
      'folke/tokyonight.nvim',
      priority = 1000,
      config = function()
        require('tokyonight').setup {
          transparent = true,
          styles = {
            sidebars = 'transparent',
            floats = 'transparent',
            comments = { italic = false },
          },
        }

        vim.cmd.colorscheme 'tokyonight-night'
      end,
    }
  end
end

return loadColorscheme()
