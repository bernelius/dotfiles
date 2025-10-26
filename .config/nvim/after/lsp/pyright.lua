return {
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                extraPaths = {
                    "./.venv/lib/python3.x/site-packages",
                },
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { "*" },
            },
            pythonPath = ".venv/bin/python",
        },
    },
}
