{}:
let
  config = {
    packageOverrides = pkgs: {
      haskellPackages = pkgs.haskellPackages.extend (self: super: with pkgs.haskell.lib; {
        a = dontHaddock (self.callCabal2nix "a" ./a {});
      });
    };
  };

  # https://github.com/NixOS/nixpkgs/pull/304640
  nixpkgsSrc = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/69d32db54427d937384cfcede967af2bf30d9535.tar.gz";
    sha256 = "sha256:0zn53j643wvvi5xh5b8j6wfg0qi6pwyvmjb4bv7c7xqvmmvp3fdz";
  };

  nixpkgs = import nixpkgsSrc { inherit config; };

in with nixpkgs.haskellPackages; {
  inherit a;

  shell = shellFor {
    packages = p: [ p.a ];
    nativeBuildInputs = [ cabal-install ];
  };
}
