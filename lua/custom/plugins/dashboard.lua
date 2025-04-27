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
        dashboard.button('l', '  Open Last File', ':Telescope oldfiles<CR>'),
        dashboard.button('f', '  Find File', ':Telescope find_files<CR>'),
        dashboard.button('h', '󰛢  Open Harpoon', '<leader>mo'),
        dashboard.button('g', '  Open Git', '<leader>go'),
        dashboard.button('m', '  Map It Out', '<leader>sm'),
        dashboard.button('q', '  Quit', ':q<CR>'),
      }

      dashboard.section.footer.val = {
        'YOU GOT THIS!!!',
      }

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
