{...}: {
  normal.video-editing = {
    nixos = {
      pkgs,
      # config,
      ...
    }: {
      # https://nixos.wiki/wiki/OBS_Studio
      # boot.extraModulePackages = with config.boot.kernelPackages; [
      #   v4l2loopback
      # ];
      boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';

      environment.systemPackages = with pkgs; [
        obs-cli
        # shotcut
        kdePackages.kdenlive
      ];
    };
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        # Media player
        vlc

        # Video manipulation tools
        ffmpeg
        mkvtoolnix
        mediainfo

        # Download videos
        yt-dlp

        # Drawing
        inkscape
        krita
        gimp

        # Image manipulation tools
        imagemagick
        ghostscript
      ];
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-pipewire-audio-capture
          # obs-backgroundremoval
          # input-overlay
        ];
      };
    };
  };
}
