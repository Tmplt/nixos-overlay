{ stdenv, requireFile, lib
, pulseaudioFull, libsForQt56, zlibStatic, qt56, zulu, zlib, bzip2, libsForQt5
, apulse, freetype, xlibs, python27Packages, glib-tested, fontconfig, libpulseaudio, scilab-bin
, openssl, libpng12, pulseaudioLight, python36Packages, glib, robomongo, qt5, fontconfig_210, zulu8 }:

stdenv.mkDerivation rec {
  name = "packettracer-${version}";
  version = "7.1.1";

  src = requireFile {
    name = "Packet_Tracer_${version}_for_Linux_64_bit.tar";
    url = "http://www.netacad.com/about-networking-academy/packet-tracer";
    sha256 = "8ee064c92f2465fd79017397750f4d12c212c591d8feb1d198863e992613b3b7";
  };

  builder = ./builder.sh;

  libPath = stdenv.lib.makeLibraryPath [
    # Output of de-generate. TODO: clean up
    stdenv.cc.cc.lib
    pulseaudioFull.out
    libsForQt56.qtinstaller.out
    zlibStatic.out
    qt56.full.out
    zulu.out
    zlib.out
    bzip2.out
    libsForQt5.qtinstaller.out
    apulse.out
    freetype.out
    xlibs.xcbutilimage.out
    python27Packages.pycurl.out
    glib-tested.out
    xlibs.libxcb.out
    xlibs.libX11.out
    xlibs.libXi.out
    xlibs.xcbutilkeysyms.out
    fontconfig.lib
    libpulseaudio.out
    openssl.out
    qt5.qtmultimedia.out
    fontconfig_210.lib
    xlibs.xcbutilwm.out
    scilab-bin.out
    openssl.debug
    libpng12.out
    pulseaudioLight.out
    qt56.qtmultimedia.out
    python36Packages.pycurl.out
    xlibs.xcbutilrenderutil.out
    qt56.qtbase.out
    glib.out
    robomongo.out
    qt5.qtbase.out
    zulu8.out
  ];

  meta = with stdenv.lib; {
    homepage = http://www.netacad.com/about-networking-academy/packet-tracer/;
    description = "Cisco Packet Tracer v${version}";
    # license = licenses.proprietary;
    platforms = platforms.linux;
  };

}
