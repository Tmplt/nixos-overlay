# Adapted from <https://aur.archlinux.org/packages/packettracer/>

source $stdenv/setup

p=$out/usr/share/packettracer
mkdir -p $p

echo "unpacking $src..."
tar xvfa $src --directory $p || echo "some files could not be extracted, continuing..."

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

arr=($srcs)

# Shell script to start PT and tell it to use included qt files
install -D -m755 "${arr[0]}" "$out/usr/share/packettracer/packettracer"

# Add environment variable
install -D -m755 "${arr[1]}" "$out/etc/profile.d/packettracer.sh"

# Improved version of Cisco's linguist script
install -D -m755 "${arr[2]}" "$out/usr/share/packettracer/linguist"

# Patch binaries
patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
    --set-rpath $libPath \
    $p/bin/PacketTracer7

patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
    --set-rpath $libPath \
    $p/bin/linguist

patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
    --set-rpath $libPath \
    $p/bin/meta

# Symlink to /usr/bin
mkdir -p "$out//bin"
ln -s "$p/bin/PacketTracer7" "$out/bin/PacketTracer7"
