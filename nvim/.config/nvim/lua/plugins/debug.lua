return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },

    -- Installs the debug adapters for you
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    -- Add your own debuggers here
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.set_log_level("DEBUG")

    require("mason-nvim-dap").setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        "delve",
        "debugpy",
        "js-debug-adapter",
      },
    })

    local getInput = function(prompt)
      local msg = vim.fn.input({
        prompt = prompt or "Log Point: ",
      })
      return msg or ""
    end

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F6>", dap.terminate, { desc = "Debug: Terminate" })
    vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>dtb", dap.toggle_breakpoint, { desc = "[D]ebug: [T]oggle [B]reakpoint" })
    vim.keymap.set("n", "<leader>dcb", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "[D]ebug: Set [C]onditional [B]reakpoint" })
    vim.keymap.set("n", "<leader>dl", function()
      dap.set_breakpoint(nil, nil, getInput())
    end, { desc = "[D]ebug: Set [L]ogpoint" })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup({
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "󱞦",
          step_over = "⏭",
          step_out = "󱟀",
          step_back = "",
          run_last = "",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
    })

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "󰜴", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "󰜺", texthl = "", linehl = "", numhl = "" })

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- set default console for cli programs.

    dap.defaults.fallback.external_terminal = {
      command = "/usr/bin/kitty",
      args = { "-e" },
    }
    dap.defaults.fallback.force_external_terminal = true
    dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
    dap.defaults.fallback.focus_terminal = true
    dap.set_log_level("INFO")

    -- Language Configs

    local function get_arguments()
      local args = {}
      vim.ui.input({ prompt = "Args: " }, function(input)
        args = vim.split(input or "", " ")
      end)
      return args
    end

    -- Prompt for file to provide to STDIN
    local function get_file()
      -- Prompt the user for the input file
      local input_file = vim.fn.input("Enter the path to the input file (relative to cwd): ")
      local full_path = vim.fn.getcwd() .. "/" .. input_file

      -- Read the contents of the input file
      local file = io.open(full_path, "r")
      if not file then
        print("File not found: " .. full_path)
        return {}
      end
      local file_content = file:read("*all")
      file:close()

      -- Write file content to stdout for piping
      local tmpfile = vim.fn.tempname()
      local tmp = io.open(tmpfile, "w")
      tmp:write(file_content)
      tmp:close()

      -- Return Node.js execution with stdin piped from Lua
      return {
        "--", -- Stops further argument processing in Node.js
        -- full_path, -- Path for debugging reference
        "<", -- Shell redirection operator for stdin
        tmpfile, -- Temporary file as input to stdin
      }
    end

    -- JS / TS Settings

    local js_based_languages = {
      "typescript",
      "javascript",
      "typescriptreact",
      "javascriptreact",
    }

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = {
          vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"),
          "${port}",
        },
      },
    }

    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        -- Debug single nodejs files
        {
          name = "----- ↓      Default Configs      ↓ -----",
          type = "",
          request = "launch",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch File",
          runtimeArgs = { "dlx", "tsx" },
          runtimeExecutable = "pnpm",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          skipFiles = { "node_modules/**" },
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch with Args",
          runtimeArgs = { "dlx tsx" },
          runtimeExecutable = "pnpm",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          args = get_arguments,
          sourceMaps = true,
          console = "external_terminal",
          skipFiles = { "node_modules/**" },
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch with STDIN",
          -- runtimeArgs = { "dlx tsx" },
          -- runtimeExecutable = "pnpm",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          args = get_file,
          sourceMaps = true,
          console = "external_terminal",
          skipFiles = { "node_modules/**" },
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
        },
        {
          name = "Lanunch Node CLI",
          type = "pwa-node",
          request = "launch",
          runtimeArgs = { "dlx", "tsx" },
          runtimeExecutable = "pnpm",
          -- runtimeArgs = { "-r", "ts-node/register" },
          -- runtimeExecutable = "node",
          args = { "--inspect", "${file}" },
          -- skipFiles = { "node_modules/**" },
          -- resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          console = "integratedTerminal",
        },
        -- Debug nodejs processes (make sure to add --inspect when you run the process)
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug web applications (client side)
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch & Debug Chrome",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({
                prompt = "Enter URL: ",
                default = "http://localhost:3000",
              }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = "inspector",
          sourceMaps = true,
          userDataDir = false,
        },
        -- Divider for the launch.json derived configs
        {
          name = "----- ↓ launch.json configs ↓ -----",
          type = "",
          request = "launch",
        },
      }
    end
    -- Go Settings
    dap.adapters.delve = function(callback, config)
      if config.mode == "remote" and config.request == "attach" then
        callback({
          type = "server",
          host = "127.0.0.1",
          port = "43000",
        })
      else
        callback({
          type = "server",
          port = "43000",
          executable = {
            command = "dlv",
            args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap", "--api-version=2" },
            detached = vim.fn.has("win32") == 0,
          },
        })
      end
    end
    -- dap.adapters.go = {
    --   type = "executable",
    --   command = "node",
    --   args = {
    --     os.getenv("HOME") .. "/.vscode-oss/extensions/golang.go-0.44.0-universal/dist/debugAdapter.js",
    --   },
    --   runInTerminal = true,
    -- }
    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug CLI",
        request = "attach",
        mode = "remote",
      },
      {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}",
      },
      {
        type = "delve",
        name = "Debug Test Files", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}",
      },
      -- works with go.mod packages and sub packages
      -- {
      --   type = "delve",
      --   name = "Debug test (go.mod)",
      --   request = "launch",
      --   mode = "test",
      --   program = "./${relativeFileDirname}",
      -- },
    }
    -- require("dap-go").setup()
    require("dap-python").setup("uv")
  end,
}
