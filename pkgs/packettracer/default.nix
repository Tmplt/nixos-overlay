{ stdenv, requireFile, fetchurl, libpng12, openssl, icu }:
# with import <nixpkgs> {};

let version = "7.1.1"; in

stdenv.mkDerivation {
  name = "packettracer-${version}";
  builder = ./builder.sh;

  src = requireFile {
    name = "Packet_Tracer_${version}_for_Linux_64_bit.tar";
    url = "http://www.netacad.com/about-networking-academy/packet-tracer";
    sha256 = "8ee064c92f2465fd79017397750f4d12c212c591d8feb1d198863e992613b3b7";
  };

  srcs = [ ./packettracer ./packettracer.sh ./linguist ];

  libPath = stdenv.lib.makeLibraryPath
    [ libpng12 openssl icu ];

  meta = {
    description = "Cisco Packet Tracer v${version}";
    homepage = "http://www.netacad.com/about-networking-academy/packet-tracer";
  };
}
