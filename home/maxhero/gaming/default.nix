{ config, lib, specialArgs, ... }:
with specialArgs;
{
  programs.mangohud = {
    enable = true;
    settings = {
      arch = true;
      background_alpha = "0.05";
      battery = true;
      cpu_temp = true;
      engine_version = true;
      font_size = 17;
      gl_vsync = -1;
      gpu_temp = true;
      io_read = true;
      io_write = true;
      position = "top-right";
      round_corners = 8;
      vram = true;
      vsync = 0;
      vulkan_driver = true;
      width = 260;
      wine = true;
    };
  };
}
