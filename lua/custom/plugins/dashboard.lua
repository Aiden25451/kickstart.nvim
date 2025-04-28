return {
  {
    'goolord/alpha-nvim',
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      dashboard.section.header.val = {
        "  (`\\ .-') /`   ('-.                                  _   .-')       ('-.  ",
        "   `.( OO ),' _(  OO)                                ( '.( OO )_   _(  OO) ",
        ",--./  .--.  (,------.,--.       .-----.  .-'),-----. ,--.   ,--.)(,------.",
        "|      |  |   |  .---'|  |.-')  '  .--./ ( OO'  .-.  '|   `.'   |  |  .---'",
        "|  |   |  |,  |  |    |  | OO ) |  |('-. /   |  | |  ||         |  |  |    ",
        "|  |.'.|  |_)(|  '--. |  |`-' |/_) |OO  )\\_) |  |\\|  ||  |'.'|  | (|  '--. ",
        "|         |   |  .--'(|  '---.'||  |`-'|   \\ |  | |  ||  |   |  |  |  .--' ",
        "|   ,'.   |   |  `---.|      |(_'  '--'\\    `'  '-'  '|  |   |  |  |  `---.",
        "'--'   '--'   `------'`------'   `-----'      `-----' `--'   `--'  `------'",
        '===========================================================================',
        '---------------------------------------------------------------------------',
        '===========================================================================',
      }

      dashboard.section.buttons.val = {
        dashboard.button('space s.', '  Open Last File', ':Telescope oldfiles<CR>'),
        dashboard.button('space sf', '  Find File', ':Telescope find_files<CR>'),
        dashboard.button('space mo', '󰛢  Open Harpoon', '<leader>mo'),
        dashboard.button('space go', '  Open Git', '<leader>go'),
        dashboard.button('space sm', '  Map It Out', '<leader>sm'),
        dashboard.button('q', '  Quit', ':q<CR>'),
      }

      local home = os.getenv 'HOME'
      local filePath = home .. '/Documents/mental-cache/todo.txt'
      local content = {}

      local file = io.open(filePath, 'r')
      if file then
        for line in file:lines() do
          table.insert(content, line)
        end
        file:close()
      end

      dashboard.section.footer.val = content

      alpha.setup(dashboard.config)
    end,
  },
}

-- "      .-. .-')     ('-.               .-. .-')   ",
--         '      \\  ( OO )   ( OO ).-.           \\  ( OO )  ',
--         '       ;-----.\\   / . --. /   .-----. ,--. ,--.  ',
--         "       | .-.  |   | \\-.  \\   '  .--./ |  .'   /  ",
--         '       | ' - ' /_).-' - "  |  |  |  |('-. |      /,  ",
--         "       | .-. `.  \\| |_.'  | /_) |OO  )|     ' _) ",
--         "       | |  \\  |  |  .-.  | ||  |`-'| |  .   \\   ",
--         "       | '--'  /  |  | |  |(_'  '--'\\ |  |\\   \\  ",
--         "       `------'   `--' `--'   `-----' `--' '--'  ",
