# Adapted from <https://aur.archlinux.org/packages/packettracer/>

source $stdenv/setup

p=$out/opt/packettracer
mkdir -p $p

# XXX: when extracting some files, we apparently lack permission? Why?
echo "unpacking $src..."
tar xvfa $src --directory $p > /dev/null || echo "some files could not be extracted, continuing..."

# Mime Info for PKA, PKT, PKZ
install -D -m644 "$p/bin/Cisco-pka.xml" "$out/usr/share/mime/packages/Ciso-pka.xml"
install -D -m644 "$p/bin/Cisco-pkt.xml" "$out/usr/share/mime/packages/Ciso-pkt.xml"
install -D -m644 "$p/bin/Cisco-pkz.xml" "$out/usr/share/mime/packages/Ciso-pkz.xml"

# Install Mimetype Icons
# mkdir -p $out/usr/share/icons/hicolor/48x48/mimetypes
install -D -m644 "$p/art/pka.png" "$out/usr/share/icons/hicolor/48x48/mimetypes/application-x-pka.png"
install -D -m644 "$p/art/pkt.png" "$out/usr/share/icons/hicolor/48x48/mimetypes/application-x-pkt.png"
install -D -m644 "$p/art/pkz.png" "$out/usr/share/icons/hicolor/48x48/mimetypes/application-x-pkz.png"

# EULA
install -D -m644 "$p/eula.txt" "$out/usr/share/licenses/packettracer/eula.txt"

# Add environment variable
install -D -m755 "$env_script" "$out/etc/profile.d/packettracer.sh"

# Remove unused library files
rm -r $p/lib

# Patch binaries
_patchelf() {
    patchelf \
        --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        --set-rpath "${libPath}" \
        $1
}

_patchelf $p/bin/PacketTracer7
_patchelf $p/bin/linguist
_patchelf $p/bin/meta

# Symlink to /bin
mkdir -p "$out/bin"
ln -s "$p/bin/PacketTracer7" "$out/bin/PacketTracer7"
ln -s "$p/bin/linguist" "$out/bin/linguist"
ln -s "$p/bin/meta" "$out/bin/meta"
