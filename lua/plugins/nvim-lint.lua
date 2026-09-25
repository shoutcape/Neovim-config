return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    local kotlin_tools = require("kotlin-tools")
    local ktlint = kotlin_tools.executable("ktlint")

    lint.linters.ktlint = {
      cmd = ktlint,
      args = {
        "--log-level=none",
        "--reporter=json",
        "--stdin",
        "--stdin-path",
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      },
      stdin = true,
      stream = "stderr",
      ignore_exitcode = true,
      parser = function(output)
        if vim.trim(output) == "" then
          return {}
        end

        local ok, results = pcall(vim.json.decode, output)
        if not ok or type(results) ~= "table" then
          return {}
        end

        local diagnostics = {}
        for _, result in ipairs(results) do
          for _, error in ipairs(result.errors or {}) do
            table.insert(diagnostics, {
              lnum = error.line - 1,
              col = error.column - 1,
              end_lnum = error.line - 1,
              end_col = error.column - 1,
              message = error.message,
              severity = vim.diagnostic.severity.WARN,
              source = "ktlint",
              code = error.rule,
            })
          end
        end

        return diagnostics
      end,
    }

    lint.linters_by_ft = {
      kotlin = { "ktlint" },
    }

    local lint_group = vim.api.nvim_create_augroup("KotlinLint", { clear = true })
    local lint_timers = {}

    local function lint_kotlin(bufnr)
      if not vim.api.nvim_buf_is_valid(bufnr)
        or vim.bo[bufnr].filetype ~= "kotlin"
        or vim.fn.executable(ktlint) ~= 1 then
        return
      end

      vim.api.nvim_buf_call(bufnr, function()
        lint.try_lint("ktlint")
      end)
    end

    local function schedule_lint(args)
      local bufnr = args.buf
      local timer = lint_timers[bufnr]
      if timer then
        timer:stop()
      else
        timer = vim.uv.new_timer()
        lint_timers[bufnr] = timer
      end

      timer:start(300, 0, vim.schedule_wrap(function()
        lint_kotlin(bufnr)
      end))
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = lint_group,
      pattern = { "*.kt", "*.kts" },
      callback = schedule_lint,
    })
  end,
}
