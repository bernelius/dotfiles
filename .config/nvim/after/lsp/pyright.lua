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
            },
            pythonPath = ".venv/bin/python",
        },
    },
}
