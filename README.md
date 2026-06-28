# dotfiles

Nix Home Manager flake for bernelius.

## Build

```bash
nix build .#homeConfigurations."bernelius@tuxedo".activationPackage
```

## Switch

```bash
home-manager switch --flake .#bernelius@tuxedo
```

## Structure

- `flake.nix` — Entry point
- `home.nix` — Shared Home Manager configuration
- `hosts/` — Per-host overrides (monitors, workspaces, etc.)
- `modules/` — Nix DSL modules for tools with Home Manager support
- `config/` — Static config files for tools without HM modules

## Philosophy

Tools with Home Manager modules are configured declaratively in Nix. Custom
or complex configs (Neovim, Hyprland Lua) remain in their native languages
and are symlinked into place via `xdg.configFile`.
