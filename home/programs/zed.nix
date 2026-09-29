{ config, pkgs, ... }:

{
  # Zed settings ported from .config/zed/settings.json
  programs.zed-editor = {
    enable = true;

    userSettings = {
      agent_servers = {
        "glm-acp-agent".type = "registry";
        opencode.type = "registry";
      };

      project_panel.dock = "right";
      outline_panel.dock = "right";
      collaboration_panel.dock = "right";
      git_panel.dock = "right";

      agent = {
        dock = "left";
        default_model = {
          provider = "copilot_chat";
          model = "gpt-5.3-codex";
          enable_thinking = false;
          effort = "high";
        };
        favorite_models = [ ];
        model_parameters = [ ];
      };

      vim = {
        toggle_relative_line_numbers = true;
      };

      icon_theme = {
        mode = "system";
        light = "Zed (Default)";
        dark = "Zed (Default)";
      };

      vim_mode = true;
      ui_font_size = 16;
      buffer_font_size = 15;
      theme = {
        mode = "system";
        light = "One Light";
        dark = "One Dark";
      };
    };
  };
}
