self: super:

{
  # nixpkgs.overlays = [ (import ./pkgs) ];
  packettracer = super.callPackage ./pkgs/packettracer { };
}
