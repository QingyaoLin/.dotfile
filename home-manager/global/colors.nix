{ inputs, lib, config, pkgs, ... }:

{
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-frappe;
  # colorScheme = inputs.nix-colors.lib-core.schemeFromYAML "catppuccin-frappe" (
  #   builtins.readFile ../../config/theme-colors/catppuccin-frappe.yaml
  # );
  # colorScheme = inputs.nix-colors.colorSchemes.catppuccin-latte;
  # colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
  # colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
}
