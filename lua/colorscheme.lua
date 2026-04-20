-- ~/.config/nvim/lua/colorscheme.lua
-- Расширенная подсветка синтаксиса в стиле GitHub/VSCode
-- Поддержка Treesitter, семантического токенайзера и LSP

local function setup_syntax_highlighting()
    -- ============================================================
    -- ПАЛИТРА ЦВЕТОВ (GitHub/VSCode стиль)
    -- ============================================================
    local colors = {
        -- Основные синтаксические цвета
        red            = '#e06c75', -- Ошибки, удаление, теги
        purple         = '#c678dd', -- Функции, методы, include
        bright_purple  = '#d55fde', -- Встроенные функции
        blue           = '#61afef', -- Ключевые слова, операторы
        light_blue     = '#7aa2f7', -- Свойства, поля
        cyan           = '#56b6c2', -- Типы, классы, пространства имен
        bright_cyan    = '#5cb9c9', -- Встроенные типы
        green          = '#98c379', -- Строки
        bright_green   = '#7ec27e', -- Escape-последовательности
        orange         = '#d19a66', -- Числа, булевы значения
        yellow         = '#e5c07b', -- Константы, макросы
        grey           = '#7f848e', -- Комментарии, пунктуация
        dark_grey      = '#5c6370', -- Документационные комментарии
        white          = '#abb2bf', -- Обычный текст, переменные
        bright_white   = '#ffffff', -- Выделенный текст

        -- Семантические/специальные
        salmon         = '#e06c75', -- Устаревший код
        gold           = '#d19a66', -- Декораторы, аннотации
        slate          = '#5c6370', -- Неактивный код
        teal           = '#56b6c2', -- Интерфейсы
        indigo         = '#61afef', -- Перечисления (enum)
        pink           = '#c678dd', -- Специальные символы

        -- Диагностика (LSP)
        error_red      = '#f44747',
        warning_orange = '#e5c07b',
        info_blue      = '#61afef',
        hint_grey      = '#7f848e',

        -- Diff
        diff_add_bg    = '#2c3e2c',
        diff_change_bg = '#3e3e2c',
        diff_delete_bg = '#3e2c2c',
        diff_text_bg   = '#4e4e3c',

        -- UI элементы
        cursorline_bg  = '#2c313c',
        visual_bg      = '#3e4452',
        pmenu_bg       = '#282c34',
        pmenu_sel_bg   = '#3e4452',
        search_bg      = '#4d5a6d',
    }

    -- ============================================================
    -- 1. ФУНКЦИИ И МЕТОДЫ
    -- ============================================================
    -- Объявления функций
    vim.api.nvim_set_hl(0, '@function', { fg = colors.purple })
    vim.api.nvim_set_hl(0, '@function.builtin', { fg = colors.bright_purple })
    vim.api.nvim_set_hl(0, '@function.call', { fg = colors.purple })
    vim.api.nvim_set_hl(0, '@function.macro', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, '@function.method', { fg = colors.purple })

    -- Методы
    vim.api.nvim_set_hl(0, '@method', { fg = colors.purple })
    vim.api.nvim_set_hl(0, '@method.call', { fg = colors.purple })
    vim.api.nvim_set_hl(0, '@method.static', { fg = colors.cyan })
    vim.api.nvim_set_hl(0, '@constructor', { fg = colors.cyan, bold = true })

    -- Параметры функций
    vim.api.nvim_set_hl(0, '@parameter', { fg = colors.salmon, italic = true })
    vim.api.nvim_set_hl(0, '@parameter.reference', { fg = colors.salmon, italic = true })

    -- Устаревшие (legacy) группы
    vim.api.nvim_set_hl(0, 'Function', { link = '@function' })

    -- ============================================================
    -- 2. КЛЮЧЕВЫЕ СЛОВА И ОПЕРАТОРЫ
    -- ============================================================
    -- Ключевые слова
    vim.api.nvim_set_hl(0, '@keyword', { fg = colors.blue })
    vim.api.nvim_set_hl(0, '@keyword.function', { fg = colors.purple })
    vim.api.nvim_set_hl(0, '@keyword.operator', { fg = colors.blue })
    vim.api.nvim_set_hl(0, '@keyword.return', { fg = colors.salmon })
    vim.api.nvim_set_hl(0, '@keyword.conditional', { fg = colors.blue })
    vim.api.nvim_set_hl(0, '@keyword.repeat', { fg = colors.blue })
    vim.api.nvim_set_hl(0, '@keyword.exception', { fg = colors.blue })
    vim.api.nvim_set_hl(0, '@keyword.import', { fg = colors.purple })
    vim.api.nvim_set_hl(0, '@keyword.modifier', { fg = colors.bright_cyan })
    vim.api.nvim_set_hl(0, '@keyword.storage', { fg = colors.blue })

    -- Операторы
    vim.api.nvim_set_hl(0, '@operator', { fg = colors.white })
    vim.api.nvim_set_hl(0, '@operator.arithmetic', { fg = colors.blue })
    vim.api.nvim_set_hl(0, '@operator.assignment', { fg = colors.blue })
    vim.api.nvim_set_hl(0, '@operator.comparison', { fg = colors.blue })
    vim.api.nvim_set_hl(0, '@operator.logical', { fg = colors.blue })
    vim.api.nvim_set_hl(0, '@operator.bitwise', { fg = colors.blue })

    -- Устаревшие группы
    vim.api.nvim_set_hl(0, 'Keyword', { link = '@keyword' })
    vim.api.nvim_set_hl(0, 'Conditional', { link = '@keyword.conditional' })
    vim.api.nvim_set_hl(0, 'Repeat', { link = '@keyword.repeat' })
    vim.api.nvim_set_hl(0, 'Exception', { link = '@keyword.exception' })
    vim.api.nvim_set_hl(0, 'Operator', { link = '@operator' })
    vim.api.nvim_set_hl(0, 'StorageClass', { link = '@keyword.storage' })
    vim.api.nvim_set_hl(0, 'Include', { link = '@keyword.import' })

    -- ============================================================
    -- 3. ТИПЫ И СТРУКТУРЫ
    -- ============================================================
    -- Типы
    vim.api.nvim_set_hl(0, '@type', { fg = colors.gold })
    vim.api.nvim_set_hl(0, '@type.builtin', { fg = colors.gold })
    vim.api.nvim_set_hl(0, '@type.definition', { fg = colors.cyan })
    vim.api.nvim_set_hl(0, '@type.qualifier', { fg = colors.bright_cyan })
    vim.api.nvim_set_hl(0, '@type.interface', { fg = colors.teal })
    vim.api.nvim_set_hl(0, '@type.enum', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, '@type.enumMember', { fg = colors.cyan })
    vim.api.nvim_set_hl(0, '@enumMember', { fg = colors.cyan })
    vim.api.nvim_set_hl(0, '@type.class', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, '@type.struct', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, '@type.union', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, '@type.alias', { fg = colors.yellow })

    -- Устаревшие группы
    vim.api.nvim_set_hl(0, 'Type', { link = '@type' })
    vim.api.nvim_set_hl(0, 'Structure', { link = '@type.struct' })
    vim.api.nvim_set_hl(0, 'Typedef', { link = '@type.definition' })
    vim.api.nvim_set_hl(0, 'Enum', { link = '@type.enum' })

    -- ============================================================
    -- 4. ПЕРЕМЕННЫЕ И ИДЕНТИФИКАТОРЫ
    -- ============================================================
    -- Переменные
    vim.api.nvim_set_hl(0, '@variable', { fg = colors.white, italic = true })
    vim.api.nvim_set_hl(0, '@variable.builtin', { fg = colors.orange, italic = true })
    vim.api.nvim_set_hl(0, '@variable.parameter', { fg = colors.white, italic = true })
    vim.api.nvim_set_hl(0, '@variable.member', { fg = colors.white, italic = true })
    vim.api.nvim_set_hl(0, '@variable.global', { fg = colors.info_blue, italic = true })

    -- Свойства и поля
    vim.api.nvim_set_hl(0, '@property', { fg = colors.white, italic = true })
    vim.api.nvim_set_hl(0, '@property.static', { fg = colors.white, italic = true })
    vim.api.nvim_set_hl(0, '@property.private', { fg = colors.white, italic = true })
    vim.api.nvim_set_hl(0, '@field', { fg = colors.white, italic = true })

    -- Пространства имен и модули
    vim.api.nvim_set_hl(0, '@namespace', { fg = colors.teal })
    vim.api.nvim_set_hl(0, '@module', { fg = colors.teal })
    vim.api.nvim_set_hl(0, '@include', { fg = colors.purple })

    -- Устаревшие группы
    vim.api.nvim_set_hl(0, 'Identifier', { fg = colors.white })
    vim.api.nvim_set_hl(0, 'Namespace', { link = '@namespace' })
    vim.api.nvim_set_hl(0, 'Define', { link = '@keyword' })

    -- ============================================================
    -- 5. ЛИТЕРАЛЫ И КОНСТАНТЫ
    -- ============================================================
    -- Строки
    vim.api.nvim_set_hl(0, '@string', { fg = colors.green })
    vim.api.nvim_set_hl(0, '@string.escape', { fg = colors.bright_green })
    vim.api.nvim_set_hl(0, '@string.special', { fg = colors.bright_green })
    vim.api.nvim_set_hl(0, '@string.regex', { fg = colors.orange })
    vim.api.nvim_set_hl(0, '@string.documentation', { fg = colors.dark_grey })
    vim.api.nvim_set_hl(0, '@string.special.url', { fg = colors.blue, underline = true })
    vim.api.nvim_set_hl(0, '@string.special.path', { fg = colors.cyan })

    -- Числа
    vim.api.nvim_set_hl(0, '@number', { fg = colors.orange })
    vim.api.nvim_set_hl(0, '@number.float', { fg = colors.orange })
    vim.api.nvim_set_hl(0, '@number.hex', { fg = colors.orange })
    vim.api.nvim_set_hl(0, '@number.octal', { fg = colors.orange })
    vim.api.nvim_set_hl(0, '@number.binary', { fg = colors.orange })

    -- Булевы и null
    vim.api.nvim_set_hl(0, '@boolean', { fg = colors.orange })
    vim.api.nvim_set_hl(0, '@null', { fg = colors.orange })

    -- Константы
    vim.api.nvim_set_hl(0, '@constant', { fg = colors.cyan })
    vim.api.nvim_set_hl(0, '@constant.builtin', { fg = colors.orange })
    vim.api.nvim_set_hl(0, '@constant.macro', { fg = colors.cyan })

    -- Символы
    vim.api.nvim_set_hl(0, '@character', { fg = colors.green })
    vim.api.nvim_set_hl(0, '@character.special', { fg = colors.bright_green })

    -- Устаревшие группы
    vim.api.nvim_set_hl(0, 'String', { link = '@string' })
    vim.api.nvim_set_hl(0, 'Character', { link = '@character' })
    vim.api.nvim_set_hl(0, 'Number', { link = '@number' })
    vim.api.nvim_set_hl(0, 'Boolean', { link = '@boolean' })
    vim.api.nvim_set_hl(0, 'Float', { link = '@number.float' })
    vim.api.nvim_set_hl(0, 'Constant', { link = '@constant' })
    vim.api.nvim_set_hl(0, 'SpecialChar', { link = '@character.special' })

    -- ============================================================
    -- 6. КОММЕНТАРИИ И ДОКУМЕНТАЦИЯ
    -- ============================================================
    vim.api.nvim_set_hl(0, '@comment', { fg = colors.grey, italic = true })
    vim.api.nvim_set_hl(0, '@comment.documentation', { fg = colors.dark_grey, italic = true })
    vim.api.nvim_set_hl(0, '@comment.note', { fg = colors.blue, italic = true })
    vim.api.nvim_set_hl(0, '@comment.warning', { fg = colors.yellow, italic = true })
    vim.api.nvim_set_hl(0, '@comment.error', { fg = colors.red, italic = true })
    vim.api.nvim_set_hl(0, '@comment.todo', { fg = colors.orange, bold = true })

    vim.api.nvim_set_hl(0, 'Comment', { link = '@comment' })
    vim.api.nvim_set_hl(0, 'SpecialComment', { link = '@comment.documentation' })
    vim.api.nvim_set_hl(0, 'Todo', { link = '@comment.todo' })

    -- ============================================================
    -- 7. РАЗМЕТКА (MARKUP)
    -- ============================================================
    -- Markdown
    vim.api.nvim_set_hl(0, '@markup.heading', { fg = colors.purple, bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.1', { fg = colors.red, bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.2', { fg = colors.orange, bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.3', { fg = colors.yellow, bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.4', { fg = colors.green, bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.5', { fg = colors.blue, bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.6', { fg = colors.purple, bold = true })

    vim.api.nvim_set_hl(0, '@markup.strong', { fg = colors.white, bold = true })
    vim.api.nvim_set_hl(0, '@markup.italic', { fg = colors.white, italic = true })
    vim.api.nvim_set_hl(0, '@markup.strikethrough', { fg = colors.grey, strikethrough = true })
    vim.api.nvim_set_hl(0, '@markup.underline', { fg = colors.white, underline = true })

    vim.api.nvim_set_hl(0, '@markup.link', { fg = colors.blue, underline = true })
    vim.api.nvim_set_hl(0, '@markup.link.url', { fg = colors.cyan, underline = true })
    vim.api.nvim_set_hl(0, '@markup.link.label', { fg = colors.light_blue })

    vim.api.nvim_set_hl(0, '@markup.list', { fg = colors.blue })
    vim.api.nvim_set_hl(0, '@markup.list.checked', { fg = colors.green })
    vim.api.nvim_set_hl(0, '@markup.list.unchecked', { fg = colors.grey })

    vim.api.nvim_set_hl(0, '@markup.quote', { fg = colors.dark_grey, italic = true })
    vim.api.nvim_set_hl(0, '@markup.raw', { fg = colors.green, bg = '#2c313c' })
    vim.api.nvim_set_hl(0, '@markup.math', { fg = colors.orange })

    -- HTML/XML
    vim.api.nvim_set_hl(0, '@tag', { fg = colors.red })
    vim.api.nvim_set_hl(0, '@tag.delimiter', { fg = colors.grey })
    vim.api.nvim_set_hl(0, '@tag.attribute', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, '@tag.attribute.tsx', { fg = colors.cyan })

    vim.api.nvim_set_hl(0, 'Tag', { link = '@tag' })
    vim.api.nvim_set_hl(0, 'Title', { link = '@markup.heading' })

    -- ============================================================
    -- 8. ПУНКТУАЦИЯ И СИМВОЛЫ
    -- ============================================================
    vim.api.nvim_set_hl(0, '@punctuation', { fg = colors.slate })
    vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = colors.slate })
    vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = colors.slate })
    vim.api.nvim_set_hl(0, '@punctuation.special', { fg = colors.blue })

    vim.api.nvim_set_hl(0, 'Delimiter', { link = '@punctuation.delimiter' })
    vim.api.nvim_set_hl(0, 'Special', { link = '@punctuation.special' })

    -- ============================================================
    -- 9. ДИАГНОСТИКА И ОШИБКИ (LSP)
    -- ============================================================
    -- Ошибки
    vim.api.nvim_set_hl(0, '@error', { fg = colors.error_red })
    vim.api.nvim_set_hl(0, '@error.unresolved', { fg = colors.error_red, underline = true })
    vim.api.nvim_set_hl(0, '@error.deprecated', { fg = colors.grey, strikethrough = true })

    vim.api.nvim_set_hl(0, 'Error', { link = '@error' })
    vim.api.nvim_set_hl(0, 'ErrorMsg', { link = '@error' })

    -- Диагностика
    vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = colors.error_red })
    vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = colors.warning_orange })
    vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = colors.info_blue })
    vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = colors.hint_grey })
    vim.api.nvim_set_hl(0, 'DiagnosticOk', { fg = colors.green })

    -- Подчеркивания
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { sp = colors.error_red, underline = true })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { sp = colors.warning_orange, underline = true })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { sp = colors.info_blue, underline = true })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { sp = colors.hint_grey, underline = true })

    -- Предупреждения
    vim.api.nvim_set_hl(0, 'WarningMsg', { fg = colors.warning_orange })

    -- Устаревший код
    vim.api.nvim_set_hl(0, '@text.deprecated', { fg = colors.grey, strikethrough = true })

    -- ============================================================
    -- 10. DIFF (GIT)
    -- ============================================================
    vim.api.nvim_set_hl(0, '@text.diff.add', { fg = colors.green, bg = colors.diff_add_bg })
    vim.api.nvim_set_hl(0, '@text.diff.delete', { fg = colors.red, bg = colors.diff_delete_bg })
    vim.api.nvim_set_hl(0, '@text.diff.change', { fg = colors.yellow, bg = colors.diff_change_bg })

    vim.api.nvim_set_hl(0, 'DiffAdd', { link = '@text.diff.add' })
    vim.api.nvim_set_hl(0, 'DiffDelete', { link = '@text.diff.delete' })
    vim.api.nvim_set_hl(0, 'DiffChange', { link = '@text.diff.change' })
    vim.api.nvim_set_hl(0, 'DiffText', { fg = colors.yellow, bg = colors.diff_text_bg })

    -- ============================================================
    -- 11. СПЕЦИАЛЬНЫЕ СЛУЧАИ
    -- ============================================================
    -- Rainbow скобки (если используется без treesitter)
    vim.api.nvim_set_hl(0, 'RainbowLevel1', { fg = colors.blue })
    vim.api.nvim_set_hl(0, 'RainbowLevel2', { fg = colors.purple })
    vim.api.nvim_set_hl(0, 'RainbowLevel3', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, 'RainbowLevel4', { fg = colors.cyan })
    vim.api.nvim_set_hl(0, 'RainbowLevel5', { fg = colors.green })
    vim.api.nvim_set_hl(0, 'RainbowLevel6', { fg = colors.red })
    vim.api.nvim_set_hl(0, 'RainbowLevel7', { fg = colors.orange })

    -- Сопоставление скобок
    vim.api.nvim_set_hl(0, 'MatchParen', { bg = '#3a3a4a', fg = colors.red, bold = true })

    -- ============================================================
    -- 12. UI ЭЛЕМЕНТЫ РЕДАКТОРА
    -- ============================================================
    -- Номера строк
    vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.dark_grey })
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = colors.dark_grey })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = colors.dark_grey })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = colors.white })
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = colors.cursorline_bg })
    vim.api.nvim_set_hl(0, 'CursorColumn', { bg = colors.cursorline_bg })

    -- Цветовая колонка
    vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#2c313c' })

    -- Выделение
    vim.api.nvim_set_hl(0, 'Visual', { bg = colors.visual_bg })
    vim.api.nvim_set_hl(0, 'VisualNOS', { bg = colors.visual_bg })

    -- Поиск
    vim.api.nvim_set_hl(0, 'Search', { bg = colors.search_bg, fg = colors.bright_white })
    vim.api.nvim_set_hl(0, 'IncSearch', { bg = colors.orange, fg = '#000000' })
    vim.api.nvim_set_hl(0, 'CurSearch', { bg = '#5d6a7d', fg = colors.bright_white })

    -- Сворачивание (folding)
    vim.api.nvim_set_hl(0, 'Folded', { fg = colors.dark_grey, bg = colors.cursorline_bg })
    vim.api.nvim_set_hl(0, 'FoldColumn', { fg = colors.dark_grey })

    -- Всплывающие меню
    vim.api.nvim_set_hl(0, 'Pmenu', { bg = colors.pmenu_bg, fg = colors.white })
    vim.api.nvim_set_hl(0, 'PmenuSel', { bg = colors.pmenu_sel_bg, fg = colors.white })
    vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = '#1e222a' })
    vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = colors.pmenu_sel_bg })

    -- Всплывающие окна (hover)
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = colors.pmenu_bg, fg = colors.white })
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.dark_grey })

    -- Сигнальная колонка (sign column)
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })

    vim.api.nvim_set_hl(0, 'VertSplit', { fg = colors.dark_grey })

    -- Статусная строка
    vim.api.nvim_set_hl(0, 'StatusLine', { fg = colors.white, bg = '#1e222a' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = colors.dark_grey, bg = '#1e222a' })

    -- Табуляция
    vim.api.nvim_set_hl(0, 'TabLine', { fg = colors.grey, bg = '#1e222a' })
    vim.api.nvim_set_hl(0, 'TabLineSel', { fg = colors.white, bg = colors.cursorline_bg })
    vim.api.nvim_set_hl(0, 'TabLineFill', { bg = '#1e222a' })

    -- Пробельные символы
    vim.api.nvim_set_hl(0, 'Whitespace', { fg = '#3e4452' })
    vim.api.nvim_set_hl(0, 'NonText', { fg = '#3e4452' })
    vim.api.nvim_set_hl(0, 'SpecialKey', { fg = '#3e4452' })

    -- Концевой символ строки ($)
    vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = '#1e222a' })

    -- Текущее слово под курсором
    vim.api.nvim_set_hl(0, 'CursorWord', { bg = '#3e4452' })
    vim.api.nvim_set_hl(0, 'CursorWord0', { bg = '#3e4452' })
    vim.api.nvim_set_hl(0, 'CursorWord1', { bg = '#3e4452' })

    -- Подсветка строк с ошибками
    vim.api.nvim_set_hl(0, 'ErrorLine', { bg = '#3e2c2c' })
    vim.api.nvim_set_hl(0, 'WarningLine', { bg = '#3e3e2c' })
    vim.api.nvim_set_hl(0, 'InfoLine', { bg = '#2c313c' })

    -- Quickfix
    vim.api.nvim_set_hl(0, 'QuickFixLine', { bg = colors.visual_bg })
    vim.api.nvim_set_hl(0, 'qfLineNr', { fg = colors.dark_grey })
    vim.api.nvim_set_hl(0, 'qfFileName', { fg = colors.blue })

    -- LSP Reference (подсветка использования)
    vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#3e4452' })
    vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#3e4452' })
    vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#3e4452' })

    -- Inlay hints (подсказки типов)
    vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = colors.dark_grey, bg = colors.cursorline_bg, italic = true })

    -- Семантическая подсветка (дополнительно)
    vim.api.nvim_set_hl(0, '@lsp.type.class', { link = '@type.class' })
    vim.api.nvim_set_hl(0, '@lsp.type.enum', { link = '@type.enum' })
    vim.api.nvim_set_hl(0, '@lsp.type.interface', { link = '@type.interface' })
    vim.api.nvim_set_hl(0, '@lsp.type.struct', { link = '@type.struct' })
    vim.api.nvim_set_hl(0, '@lsp.type.typeParameter', { fg = colors.teal })
    vim.api.nvim_set_hl(0, '@lsp.type.parameter', { link = '@parameter' })
    vim.api.nvim_set_hl(0, '@lsp.type.variable', { link = '@variable' })
    vim.api.nvim_set_hl(0, '@lsp.type.property', { link = '@property' })
    vim.api.nvim_set_hl(0, '@lsp.type.method', { link = '@method' })
    vim.api.nvim_set_hl(0, '@lsp.type.function', { link = '@function' })
    vim.api.nvim_set_hl(0, '@lsp.type.macro', { link = '@constant.macro' })
    vim.api.nvim_set_hl(0, '@lsp.type.decorator', { fg = colors.gold })
    -- ============================================================
    -- 14. ПРИНУДИТЕЛЬНОЕ ПЕРЕОПРЕДЕЛЕНИЕ LSP СЕМАНТИЧЕСКИХ ТОКЕНОВ
    -- (default = false гарантирует высший приоритет)
    -- ============================================================

    -- Функции и методы
    vim.api.nvim_set_hl(0, '@lsp.type.function', { link = '@function', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.method', { link = '@method', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.constructor', { link = '@constructor', default = false })

    -- Типы
    vim.api.nvim_set_hl(0, '@lsp.type.type', { link = '@type', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.class', { link = '@type.class', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.struct', { link = '@type.struct', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.interface', { link = '@type.interface', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.enum', { link = '@type.enum', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.enumMember', { link = '@type.enumMember', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.typeParameter', { fg = colors.teal, default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.alias', { link = '@type.alias', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.union', { link = '@type.union', default = false })

    -- Ключевые слова
    vim.api.nvim_set_hl(0, '@lsp.type.keyword', { link = '@keyword', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.modifier', { link = '@keyword.modifier', default = false })

    -- Переменные
    vim.api.nvim_set_hl(0, '@lsp.type.variable', { link = '@variable', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.parameter', { link = '@parameter', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.property', { link = '@property', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.field', { link = '@field', default = false })

    -- Константы и макросы
    vim.api.nvim_set_hl(0, '@lsp.type.constant', { link = '@constant', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.macro', { link = '@constant.macro', default = false })

    -- Строки и числа
    vim.api.nvim_set_hl(0, '@lsp.type.string', { link = '@string', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.number', { link = '@number', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.boolean', { link = '@boolean', default = false })

    -- Комментарии
    vim.api.nvim_set_hl(0, '@lsp.type.comment', { link = '@comment', default = false })

    -- Пространства имен
    vim.api.nvim_set_hl(0, '@lsp.type.namespace', { link = '@namespace', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.module', { link = '@module', default = false })

    -- Декораторы/аннотации
    vim.api.nvim_set_hl(0, '@lsp.type.decorator', { fg = colors.gold, default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.annotation', { fg = colors.gold, default = false })

    -- Специфичные для языков (C++, Python, Go, etc.)
    vim.api.nvim_set_hl(0, '@lsp.type.enum.cpp', { link = '@type.enum', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.enumMember.cpp', { link = '@type.enumMember', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.macro.cpp', { link = '@constant.macro', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.class.cpp', { link = '@type.class', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.struct.cpp', { link = '@type.struct', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.function.cpp', { link = '@function', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.method.cpp', { link = '@method', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.variable.cpp', { link = '@variable', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.parameter.cpp', { link = '@parameter', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.modifier.cpp', { fg = colors.bright_cyan, default = false })

    -- Python
    vim.api.nvim_set_hl(0, '@lsp.type.class.python', { link = '@type.class', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.function.python', { link = '@function', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.method.python', { link = '@method', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.variable.python', { link = '@variable', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.parameter.python', { link = '@parameter', default = false })

    -- Go
    vim.api.nvim_set_hl(0, '@lsp.type.struct.go', { link = '@type.struct', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.interface.go', { link = '@type.interface', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.function.go', { link = '@function', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.method.go', { link = '@method', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.variable.go', { link = '@variable', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.parameter.go', { link = '@parameter', default = false })

    -- Lua
    vim.api.nvim_set_hl(0, '@lsp.type.function.lua', { link = '@function', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.variable.lua', { link = '@variable', default = false })
    vim.api.nvim_set_hl(0, '@lsp.type.parameter.lua', { link = '@parameter', default = false })

    -- Модификаторы LSP (readonly, static, etc.) - делаем прозрачными
    vim.api.nvim_set_hl(0, '@lsp.mod.readonly', { default = false })
    vim.api.nvim_set_hl(0, '@lsp.mod.static', { default = false })
    vim.api.nvim_set_hl(0, '@lsp.mod.globalScope', { default = false })
    vim.api.nvim_set_hl(0, '@lsp.mod.definition', { default = false })
    vim.api.nvim_set_hl(0, '@lsp.mod.declaration', { default = false })
    vim.api.nvim_set_hl(0, '@lsp.mod.async', { default = false })
    vim.api.nvim_set_hl(0, '@lsp.mod.deprecated', { fg = colors.grey, strikethrough = true, default = false })
    vim.api.nvim_set_hl(0, '@lsp.mod.defaultLibrary', { default = false })

    -- Типомодификаторы (комбинации тип + модификатор)
    vim.api.nvim_set_hl(0, '@lsp.typemod.enumMember.readonly', { default = false })
    vim.api.nvim_set_hl(0, '@lsp.typemod.enumMember.globalScope', { default = false })
    vim.api.nvim_set_hl(0, '@lsp.typemod.variable.readonly', { default = false })
    vim.api.nvim_set_hl(0, '@lsp.typemod.variable.globalScope', { default = false })
    vim.api.nvim_set_hl(0, '@lsp.typemod.parameter.readonly', { default = false })
end

-- Применяем настройки подсветки
setup_syntax_highlighting()

-- Автоматически переприменять настройки при смене цветовой схемы
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
        vim.defer_fn(function()
            setup_syntax_highlighting()
        end, 50)
    end,
})

-- Функция переключения тем
function _G.toggle_colorscheme()
    local current_theme = vim.g.colors_name
    if current_theme == 'onedark' then
        vim.cmd('colorscheme github_dark')
        vim.notify('🎨 Switched to GitHub Dark', vim.log.levels.INFO)
    else
        vim.cmd('colorscheme onedark')
        vim.notify('🎨 Switched to OneDark', vim.log.levels.INFO)
    end
end

-- Применяем настройки сразу после загрузки
vim.defer_fn(function()
    setup_syntax_highlighting()
end, 100)
