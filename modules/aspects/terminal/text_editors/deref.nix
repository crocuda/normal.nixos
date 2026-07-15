{...}: {
  normal.nvim.deref = {
    homeManager = {pkgs, ...}: {
      systemd.user.services."vim-deref" = {
        # Unit is automatically enabled
        Unit = {
          Description = "Create out-of-store directiories for vim and nvim configurations";
        };
        Install = {
          WantedBy = [
            "systemd-tmpfiles-setup.service"
            "systemd-tmpfiles-resetup.service"
          ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = [
            "-${pkgs.coreutils}/bin/cp -Lrf .vimrc .vimrc.deref"
            "-${pkgs.coreutils}/bin/cp -Lrf .config/nvim .config/nvim.deref"
            "-${pkgs.coreutils}/bin/cp -Lrf .config/nvchad .config/nvchad.deref"
          ];
        };
      };
    };
  };
}
