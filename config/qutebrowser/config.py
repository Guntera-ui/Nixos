config.load_autoconfig(False)


# ============================================================
# GENERAL
# ============================================================

c.auto_save.session = True
c.session.lazy_restore = True

c.downloads.location.directory = "~/Downloads"

# Don't let random sites autoplay media.
c.content.autoplay = False

# Blank, dark start page.
c.url.start_pages = ["about:blank"]
c.url.default_page = "about:blank"

# Prefer dark themes on websites which support them.
c.colors.webpage.preferred_color_scheme = "dark"

# Background shown before/behind webpages.
c.colors.webpage.bg = "#0f1018"

# Search engines.
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "g": "https://www.google.com/search?q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "w": "https://en.wikipedia.org/wiki/Special:Search?search={}",
}

# Smooth scrolling.
c.scrolling.smooth = True

# Don't show qutebrowser changelog after upgrades.
c.changelog_after_upgrade = "never"


# ============================================================
# LAYOUT
# ============================================================

# Vertical tabs fit Hyprland nicely.
c.tabs.position = "left"

# IMPORTANT: integer, not "180".
c.tabs.width = 190

# Hide the tab bar when there is only one tab.
c.tabs.show = "multiple"

# Minimal statusbar:
# invisible in normal browsing, appears when entering commands/modes.
c.statusbar.show = "in-mode"

# No loading stripe on every tab.
c.tabs.indicator.width = 0

# Compact but comfortable vertical tabs.
c.tabs.padding = {
    "top": 7,
    "bottom": 7,
    "left": 10,
    "right": 8,
}

c.tabs.title.alignment = "left"
c.tabs.title.elide = "right"

# Favicons are useful with vertical tabs.
c.tabs.favicons.show = "always"

# Cleaner completion menu.
c.completion.height = "40%"
c.completion.scrollbar.width = 6

# Small statusbar padding.
c.statusbar.padding = {
    "top": 4,
    "bottom": 4,
    "left": 8,
    "right": 8,
}


# ============================================================
# FONTS
# ============================================================

c.fonts.default_family = "JetBrainsMono Nerd Font"
c.fonts.default_size = "10pt"

c.fonts.tabs.selected = "bold 10pt JetBrainsMono Nerd Font"
c.fonts.tabs.unselected = "10pt JetBrainsMono Nerd Font"

c.fonts.statusbar = "10pt JetBrainsMono Nerd Font"

c.fonts.completion.entry = "10pt JetBrainsMono Nerd Font"
c.fonts.completion.category = "bold 10pt JetBrainsMono Nerd Font"

c.fonts.hints = "bold 10pt JetBrainsMono Nerd Font"
c.fonts.prompts = "10pt JetBrainsMono Nerd Font"
c.fonts.messages.info = "10pt JetBrainsMono Nerd Font"
c.fonts.messages.warning = "10pt JetBrainsMono Nerd Font"
c.fonts.messages.error = "10pt JetBrainsMono Nerd Font"
c.fonts.contextmenu = "10pt JetBrainsMono Nerd Font"


# ============================================================
# PALETTE
# ============================================================

bg = "#0f1018"
bg_alt = "#161823"
bg_select = "#202337"

fg = "#f4f1ff"
muted = "#85899b"
dim = "#696278"

pink = "#f29ac3"
lavender = "#c6a0f6"
blue = "#8aadf4"
cyan = "#7dcfe3"

orange = "#eca46a"
red = "#ff5c8a"


# ============================================================
# TABS
# ============================================================

c.colors.tabs.bar.bg = bg

# Normal tabs.
c.colors.tabs.even.bg = bg
c.colors.tabs.even.fg = muted

c.colors.tabs.odd.bg = bg
c.colors.tabs.odd.fg = muted

# Selected tab.
c.colors.tabs.selected.even.bg = bg_select
c.colors.tabs.selected.even.fg = pink

c.colors.tabs.selected.odd.bg = bg_select
c.colors.tabs.selected.odd.fg = pink

# Pinned tabs.
c.colors.tabs.pinned.even.bg = bg_alt
c.colors.tabs.pinned.even.fg = lavender

c.colors.tabs.pinned.odd.bg = bg_alt
c.colors.tabs.pinned.odd.fg = lavender

c.colors.tabs.pinned.selected.even.bg = bg_select
c.colors.tabs.pinned.selected.even.fg = pink

c.colors.tabs.pinned.selected.odd.bg = bg_select
c.colors.tabs.pinned.selected.odd.fg = pink

# Would only be visible if we later enable the tab loading indicator.
c.colors.tabs.indicator.start = blue
c.colors.tabs.indicator.stop = cyan
c.colors.tabs.indicator.error = red


# ============================================================
# STATUS BAR
# ============================================================

c.colors.statusbar.normal.bg = bg
c.colors.statusbar.normal.fg = fg

# Insert mode.
c.colors.statusbar.insert.bg = bg_alt
c.colors.statusbar.insert.fg = cyan

# Command mode.
c.colors.statusbar.command.bg = bg
c.colors.statusbar.command.fg = lavender

# Passthrough mode.
c.colors.statusbar.passthrough.bg = bg
c.colors.statusbar.passthrough.fg = blue

# Private browsing.
c.colors.statusbar.private.bg = bg_alt
c.colors.statusbar.private.fg = lavender

# Caret mode.
c.colors.statusbar.caret.bg = bg
c.colors.statusbar.caret.fg = pink

c.colors.statusbar.caret.selection.bg = bg_select
c.colors.statusbar.caret.selection.fg = fg

# Loading progress.
c.colors.statusbar.progress.bg = pink


# ============================================================
# URL COLORS
# ============================================================

c.colors.statusbar.url.fg = fg
c.colors.statusbar.url.hover.fg = cyan

c.colors.statusbar.url.success.http.fg = muted
c.colors.statusbar.url.success.https.fg = cyan

c.colors.statusbar.url.warn.fg = orange
c.colors.statusbar.url.error.fg = red


# ============================================================
# COMPLETION MENU
# ============================================================

c.colors.completion.fg = fg

c.colors.completion.even.bg = bg
c.colors.completion.odd.bg = bg_alt

# Section headings.
c.colors.completion.category.bg = bg
c.colors.completion.category.fg = lavender

c.colors.completion.category.border.top = bg
c.colors.completion.category.border.bottom = bg_select

# Selected result.
c.colors.completion.item.selected.bg = bg_select
c.colors.completion.item.selected.fg = fg

c.colors.completion.item.selected.border.top = pink
c.colors.completion.item.selected.border.bottom = pink

# Search-match accents.
c.colors.completion.match.fg = cyan
c.colors.completion.item.selected.match.fg = pink

# Scrollbar.
c.colors.completion.scrollbar.bg = bg
c.colors.completion.scrollbar.fg = blue


# ============================================================
# LINK HINTS
# ============================================================

# Shown when pressing "f".
c.colors.hints.bg = bg
c.colors.hints.fg = pink
c.colors.hints.match.fg = cyan


# ============================================================
# KEY HINTS
# ============================================================

c.colors.keyhint.bg = bg
c.colors.keyhint.fg = fg
c.colors.keyhint.suffix.fg = pink


# ============================================================
# PROMPTS
# ============================================================

c.colors.prompts.bg = bg
c.colors.prompts.fg = fg

c.colors.prompts.border = "1px solid #c6a0f6"

c.colors.prompts.selected.bg = bg_select
c.colors.prompts.selected.fg = pink


# ============================================================
# CONTEXT MENU
# ============================================================

c.colors.contextmenu.menu.bg = bg
c.colors.contextmenu.menu.fg = fg

c.colors.contextmenu.selected.bg = bg_select
c.colors.contextmenu.selected.fg = pink

c.colors.contextmenu.disabled.bg = bg
c.colors.contextmenu.disabled.fg = dim


# ============================================================
# DOWNLOADS
# ============================================================

c.colors.downloads.bar.bg = bg

c.colors.downloads.start.bg = blue
c.colors.downloads.start.fg = bg

c.colors.downloads.stop.bg = cyan
c.colors.downloads.stop.fg = bg

c.colors.downloads.error.bg = red
c.colors.downloads.error.fg = fg

# No rainbow gradient between download states.
c.colors.downloads.system.bg = "none"
c.colors.downloads.system.fg = "none"


# ============================================================
# MESSAGES
# ============================================================

c.colors.messages.info.bg = bg
c.colors.messages.info.fg = cyan
c.colors.messages.info.border = blue

c.colors.messages.warning.bg = bg
c.colors.messages.warning.fg = orange
c.colors.messages.warning.border = orange

c.colors.messages.error.bg = bg
c.colors.messages.error.fg = red
c.colors.messages.error.border = red


# ============================================================
# TOOLTIPS
# ============================================================

c.colors.tooltip.bg = bg
c.colors.tooltip.fg = fg
