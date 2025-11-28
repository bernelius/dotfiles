sessions = []
windows = []


class Session:
    def __init__(self, name, path, root=None, startup_command=None, windows=[]):
        self.name = name
        self.path = path
        self.root = root if root else path
        self.startup_command = (
            startup_command
            if startup_command
            else f"ROOT={self.root} && clear && figlet -w 100 -f big '{self.name}' | lolcat"
        )
        self.windows = windows if windows else ["lazygit"]

        sessions.append(self)

    def __str__(self):
        windows_str = "[" + ", ".join(f'"{w}"' for w in self.windows) + "]"
        return f'[[session]]\nname = "{self.name}"\npath = "{self.path}"\nstartup_command = "{self.startup_command}"\nwindows = {windows_str}\n\n'


class Window:
    def __init__(self, name, startup_script):
        self.name = name
        self.startup_script = startup_script
        windows.append(self)

    def __str__(self):
        return f'[[window]]\nname = "{self.name}"\nstartup_script = "{self.startup_script}"\n\n'


Window("lazygit", "lazygit")

Session("dotfiles", "~/dotfiles/.config")
Session("zmk workspace", "~/code/zmk-workspace")
Session("VekstbarometerUSN", "~/code/vekstbarometer/indicator-updater")


with open("sesh.toml", "w") as f:
    for window in windows:
        f.write(str(window))
    for session in sessions:
        f.write(str(session))
    print("Done!")
