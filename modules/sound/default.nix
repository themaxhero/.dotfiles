{ ... }:
{
  environment.variables = {
    AE_SINK = "ALSA";
    SDL_AUDIODRIVER = "pipewire";
    ALSOFT_DRIVERS = "alsa";
  };

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    systemWide = false;
    wireplumber.enable = true;
  };
}
