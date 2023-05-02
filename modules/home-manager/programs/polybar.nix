# https://github.com/nix-community/home-manager/blob/master/modules/services/polybar.nix

{ config, options, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.polybar;
  opt = options.services.polybar;

  # Convert a key/val pair to the insane format that polybar uses.
  # Each input key/val pair may return several output key/val pairs.
  convertPolybarKeyVal = key: val:
    # Convert { foo = [ "a" "b" ]; }
    # to {
    #   foo-0 = "a";
    #   foo-1 = "b";
    # }
    if isList val then
      concatLists (imap0 (i: convertPolybarKeyVal "${key}-${toString i}") val)
      # Convert {
      #   foo.text = "a";
      #   foo.font = 1;
      # } to {
      #   foo = "a";
      #   foo-font = 1;
      # }
    else if isAttrs val && !lib.isDerivation val then
      concatLists (mapAttrsToList
        (k: convertPolybarKeyVal (if k == "text" then key else "${key}-${k}"))
        val)
      # Base case
    else
      [ (nameValuePair key val) ];

  convertPolybarSection = _: attrs:
    listToAttrs (concatLists (mapAttrsToList convertPolybarKeyVal attrs));

  # Converts an attrset to INI text, quoting values as expected by polybar.
  # This does no more fancy conversion.
  toPolybarIni = generators.toINI {
    mkKeyValue = key: value:
      let
        quoted = v:
          if hasPrefix " " v || hasSuffix " " v then ''"${v}"'' else v;

        value' = if isBool value then
          (if value then "true" else "false")
        else if (isString value && key != "include-file") then
          quoted value
        else
          toString value;
      in "${key}=${value'}";
  };

  configFile =
  let
    isDeclarativeConfig = cfg.settings != opt.settings.default || cfg.extraConfig != opt.extraConfig.default;
  in
    if isDeclarativeConfig then
      pkgs.writeText "polybar.conf" ''
        ${toPolybarIni (mapAttrs convertPolybarSection cfg.settings)}
        ${cfg.extraConfig}
      ''
    else
      null;

in {
  options = {
    services.polybar = {
      enable = mkEnableOption "Polybar status bar";

      package = mkOption {
        type = types.package;
        default = pkgs.polybar;
        defaultText = literalExpression "pkgs.polybar";
        description = "Polybar package to install.";
        example = literalExpression ''
          pkgs.polybar.override {
            i3GapsSupport = true;
            alsaSupport = true;
            iwSupport = true;
            githubSupport = true;
          }
        '';
      };

      settings = mkOption {
        type = with types;
          let ty = oneOf [ bool int float str (listOf ty) (attrsOf ty) ];
          in attrsOf (attrsOf ty // { description = "attribute sets"; });
        description = ''
          Polybar configuration. This takes a nix attrset and converts it to the
          strange data format that polybar uses.
          Each entry will be converted to a section in the output file.
          Several things are treated specially: nested keys are converted
          to dash-separated keys; the special <literal>text</literal> key is ignored as a nested key,
          to allow mixing different levels of nesting; and lists are converted to
          polybar's <literal>foo-0, foo-1, ...</literal> format.
          </para><para>
          For example:
          <programlisting language="nix">
          "module/volume" = {
            type = "internal/pulseaudio";
            format.volume = "&lt;ramp-volume&gt; &lt;label-volume&gt;";
            label.muted.text = "🔇";
            label.muted.foreground = "#666";
            ramp.volume = ["🔈" "🔉" "🔊"];
            click.right = "pavucontrol &amp;";
          }
          </programlisting>
          becomes:
          <programlisting language="ini">
          [module/volume]
          type=internal/pulseaudio
          format-volume=&lt;ramp-volume&gt; &lt;label-volume&gt;
          label-muted=🔇
          label-muted-foreground=#666
          ramp-volume-0=🔈
          ramp-volume-1=🔉
          ramp-volume-2=🔊
          click-right=pavucontrol &amp;
          </programlisting>
        '';
        default = { };
        example = literalExpression ''
          {
            "module/volume" = {
              type = "internal/pulseaudio";
              format.volume = "<ramp-volume> <label-volume>";
              label.muted.text = "🔇";
              label.muted.foreground = "#666";
              ramp.volume = ["🔈" "🔉" "🔊"];
              click.right = "pavucontrol &";
            };
          }
        '';
      };

      extraConfig = mkOption {
        type = types.lines;
        description = "Additional configuration to add.";
        default = "";
        example = ''
          [module/date]
          type = internal/date
          interval = 5
          date = "%d.%m.%y"
          time = %H:%M
          format-prefix-foreground = \''${colors.foreground-alt}
          label = %time%  %date%
        '';
      };
      # TODO:额外的服务启动参数
      extraArgs = mkOption {
        type = with types; listOf str;
        default = [ ];
        example = literalExpression ''[ "-q" ]'';
        description = ''
          Extra arguments to be passed to the polybar executable.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "services.polybar" pkgs
        lib.platforms.linux)
    ];

    home.packages = [ cfg.package ];

    xdg.configFile."polybar/config.ini" =
      mkIf (configFile != null) { source = configFile; };

    systemd.user.services.polybar = {
      Unit = {
        Description = "Polybar status bar";
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = concatStringsSep " " (
          [
            "${cfg.package}/bin/polybar"
            "--config=${config.xdg.configFile."polybar/config.ini".source}"
          ] ++ cfg.extraArgs
        );
      };

      Install = {
        WantedBy = [ "bspwm-session.target" ];
      };
    };
  };
}
