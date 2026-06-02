{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.terminal.git.conventional.enable {
    home.file = {
      ".config/git/conventional_commit_message".source = ./dotfiles/conventional_commit_message;
    };

    # Sem

    programs = {
      # Versionning

      git = {
        enable = true;
        # iniContent.gpg.format = lib.mkDefault "ssh";
        iniContent.gpg.format = lib.mkForce "ssh";
        settings = {
          commit.template = "~/.config/git/conventional_commit_message";
          core = {
            editor = "nvim -u ~/.config/nvchad/init.lua";
          };
          # gpg.format = lib.mkDefault "ssh";
          # Sign all commits using ssh key
          # commit.gpgsign = true;
          # gpg.format = "ssh";
        };
      };
      jujutsu = {
        enable = true;
        package = pkgs.jujutsu;
        settings = {
          remotes = {
            origin = {
              auto-track-bookmarks = "*";
              # auto-track-bookmarks = ["main" "master" "dev"];
            };
          };
          ui = {
            editor = "nvim -u ~/.config/nvchad/init.lua";
            diff-editor = ["nvim" "-u" "~/.config/nvchad/init.lua" "-c" "DiffEditor $left $right $output"];
            # pager = ["nvim" "-u" "~/.config/nvchad/init.lua" "-c" "DiffEditor $left $right $output"];
            pager = "less";
            paginate = "never";
            show-cryptographtic-signatures = true; # performance cost for large change logs
          };
          aliases = {
            # Short history
            l = ["log" "--revisions" "root()..@" "--limit" "6"];
            ll = ["log" "--limit" "12"];
            diffshow = ["nvim" "-u" "~/.config/nvchad/init.lua" "-c" "DiffViewOpen"];

            stt = ["diff" "--stat"];

            # Git wrapped commands
            push = ["git" "push"];
            fetch = ["git" "fetch"];
          };
          # signing = {
          #   sign-all = true;
          #   bakend = "ssh";
          #   key = "~/.ssh/id_ed25519_signing";
          #   backends.ssh.allowed-signers = "~/.ssh/allowed-signers";
          # };
          templates = {
            draft_commit_description = let
              hint = builtins.readFile ./dotfiles/conventional_change_message;
              signature = ''
                if(self.signature(),
                  indent("JJ:     ",
                    concat(
                      self.signature().status(),
                      self.signature().display(),
                    ),
                  ),
                )
              '';
              changes = ''
                concat(
                  indent("JJ:     ", diff.stat(72)),
                )
              '';
            in ''
              concat(
                ${signature},
                description,
                "${hint}",
                surround(
                  "\nJJ: This commit contains the following changes:\n","",
                  ${changes}
                ),
              )
            '';
          };
        };
      };
    };
  }
