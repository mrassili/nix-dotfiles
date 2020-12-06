{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-20.09";
  outputs = { self, nixpkgs }: {
     nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
       modules = [ ./configuration.nix ];
     };
  };
}

