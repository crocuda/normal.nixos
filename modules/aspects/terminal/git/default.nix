{lib, ...}: {
  normal.git = {
    homeManager = {pkgs, ...}: {
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

              log-word-wrap = true;
            };
            aliases = {
              # Short history
              l = ["log" "--revisions" "..@" "--limit" "8"];
              ll = ["log" "--revisions" ".." "--limit" "16"];
              lls = ["log" "--revisions" ".." "--limit" "16" "-T" "builtin_log_compact_full_description"];
              lld = ["log" "--revisions" ".." "--limit" "16" "-T" "log_commit_verbose_graph"];

              stt = ["diff" "--stat"];

              diffshow = ["util" "exec" "--" "nvim" "-u" "~/.config/nvchad/init.lua" "-c" "DiffViewOpen"];
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
            templates = let
              hint = builtins.readFile ./dotfiles/conventional_change_message;
              author = ''
                indent("JJ: ",
                  concat(
                    "Author: ",
                    author.name()
                  )
                )
              '';
              email = ''
                indent("JJ: ",
                  concat(
                    "Email: ",
                    author.email()
                  )
                )
              '';
              author_email = ''
                concat(
                  ${author},
                  ${email}
                )
              '';
              signature = ''
                if(self.signature(),
                  indent("JJ:     ",
                    concat(
                      self.signature().status(),
                      self.signature().display(),
                      "\n"
                    ),
                  ),
                )
              '';
              changes = ''
                concat(
                  indent("JJ:     ", diff.stat(72)),
                )
              '';
            in {
              log_commit_verbose_graph = ''
                concat(
                  ${signature},
                  "\n",
                  commit_id,
                  "\n",
                  description,
                  "\n",
                  ${author_email}
              '';
              draft_commit_description = ''
                concat(
                  ${signature},
                  description,
                  "${hint}",
                  surround(
                    "\nJJ: This commit contains the following changes:\n","",
                    ${changes}
                  ),
                  "\n",
                  ${author_email},
                )
              '';
              # new_description = ''
              #   if(parents.len() > 1,
              #     "Merge " ++ parents.skip(1).map(|p| try(
              #       p.bookmarks().first().name(),
              #       p.change_id().shortest(8)
              #     )).join(", ") ++ " into " ++ try(
              #       parents.first().bookmarks().first().name(),
              #       parents.first().change_id().shortest(8)
              #     ) ++ "\n",
              #     ""
              #   )
              # '';
            };
          };
        };
      };
    };
  };
}
