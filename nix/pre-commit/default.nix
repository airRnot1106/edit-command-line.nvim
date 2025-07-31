{ config, pkgs }:
{
  check.enable = true;
  settings.hooks = {
    luacheck = {
      enable = true;
      entry = "${pkgs.luajitPackages.luacheck}/bin/luacheck --std luajit --globals vim -- ";
    };
    nil.enable = true;
    treefmt = {
      enable = true;
      package = config.treefmt.build.wrapper;
    };
  };
}
