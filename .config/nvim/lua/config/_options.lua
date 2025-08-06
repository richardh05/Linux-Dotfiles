-- basic options!
-- these are usually like so, but we're gonna use a lua dictionary for readability!

local options = {
    number = true,  -- Show line numbers
    relativenumber = true,  -- Relative line numbers
    tabstop = 2,  -- Number of spaces per tab
    shiftwidth = 2,  -- Spaces per indentation level
    autoindent = true,  -- Enable auto-indentation
    mouse = "a",  -- Enable mouse support
    wrap = true, -- Linewrap
    linebreak = true, -- Break lines at word boundaries and indent wrapped parts
    breakindent = true, -- Indent wrapped lines to match the original line's indent
    -- termguicolors = false  -- Disable terminal GUI colors
}

-- ... then we set them with the actual command like so:
for key, val in pairs(options) do
	vim.opt[key] = val
end