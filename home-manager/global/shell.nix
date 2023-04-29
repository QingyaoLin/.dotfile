{ lib, config, pkgs, ... }:

{
  # home.language.base = "en_US.UTF-8";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    # http_proxy = "http://127.0.0.1:7890";
    # https_proxy = "http://127.0.0.1:7890";
    # all_proxy = "socks5://127.0.0.1:7890";
  };

  home.shellAliases = {
    ls = "ls --color=auto";
    ll = "ls -lh";
    la = "ls -a";
    l = "ls -alh";
    ".." = "cd ./..";
    "..." = "cd ../..";
    v = "nvim";
  };

  # Plugs:
  #   zsh-completions
  #   zsh-autosuggestions
  #   zsh-syntax-highlighting
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    completionInit = "autoload -U compinit && compinit";
    initExtra =
    ''
    if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
      exec startx
    fi
    '';
  };
}
