require('battery').setup {
  update_rate_seconds = 30, -- Number of seconds between checking battery status
  show_status_when_no_battery = true, -- Don't show any icon or text when no battery found (desktop for example)
  show_plugged_icon = true, -- If true show a cable icon alongside the battery icon when plugged in
  show_unplugged_icon = true, -- When true show a diconnected cable icon when not plugged in
  show_percent = true, -- Whether or not to show the percent charge remaining in digits
  vertical_icons = true, -- When true icons are vertical, otherwise shows horizontal battery icon
  multiple_battery_selection = 1, -- Which battery to choose when multiple found. "max" or "maximum", "min" or "minimum" or a number to pick the nth battery found (currently linux acpi only)
}
local nvimbattery = {
  function()
    return require('battery').get_status_line()
  end,
}
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    -- component_separators = '|',
    -- section_separators = '',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },

    always_divide_middle = false,
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      {
        'diff',
        symbols = { added = '＋', modified = 'Δ', removed = '－' },
      },
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
      },
    },
    lualine_c = {
      {
        'filename',
        path = 0,
      },
    },
    lualine_x = { nvimbattery, 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}
