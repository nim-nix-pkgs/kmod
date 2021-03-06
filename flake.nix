{
  description = ''High-level wrapper for Linux's kmod library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."kmod-master".dir   = "master";
  inputs."kmod-master".owner = "nim-nix-pkgs";
  inputs."kmod-master".ref   = "master";
  inputs."kmod-master".repo  = "kmod";
  inputs."kmod-master".type  = "github";
  inputs."kmod-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."kmod-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}