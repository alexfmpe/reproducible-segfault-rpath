{}:
let
  config = {
    packageOverrides = pkgs: {
      haskellPackages = pkgs.haskellPackages.extend (self: super: with pkgs.haskell.lib; {
        a = dontHaddock (self.callCabal2nix "a" ./a {});
      });
    };
  };

  # https://github.com/reckenrode/nixpkgs/tree/ld64
  nixpkgsSrc = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/7a616863c22c8f5d4b12bfe8621f725b8cacf56b.tar.gz";
    sha256 = "sha256:1ihiqwd544rixf050qbqwif6a13bngibvqjgy8mas0dpb1gxbw5g";
  };

  nixpkgs = import nixpkgsSrc { inherit config; };

in with nixpkgs.haskellPackages; {
  inherit a;

  shell = shellFor {
    packages = p: [ p.a ];
    nativeBuildInputs = [ cabal-install ];
  };
}
