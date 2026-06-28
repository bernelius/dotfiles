local pythonPath = vim.env.PYRIGHT_PYTHON_PATH
local extraPaths = {}

if not pythonPath or pythonPath == "" then
    if vim.fn.isdirectory(".venv") == 1 then
        pythonPath = ".venv/bin/python"
        extraPaths = { "./.venv/lib/python3.x/site-packages" }
    else
        pythonPath = vim.fn.exepath("python3") or "python3"
    end
end

return {
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                extraPaths = extraPaths,
            },
            pythonPath = pythonPath,
        },
    },
}
