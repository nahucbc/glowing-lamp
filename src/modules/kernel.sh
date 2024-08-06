# Kernel Management Tool
# https://www.kernel.org/
# Default Configuration

repository=https://cdn.kernel.org/pub/linux/kernel/

# Latest Release
MAJOR=6
MINOR=10
PATCH=3

module_kernel_vars_gen() {
    source=${repository}v${MAJOR}.x/
    version=$MAJOR.$MINOR.$PATCH
    
    linux=linux-${version}
    patch=patch-${version}
    incr_patch=patch-${version%.*}.$(($PATCH - 1))-${PATCH}
    
    tarball_file=${linux}.tar.xz
    pgp_file=${linux}.tar.sign
    patch_file=${patch}.xz
    incr_patch_file=${incr_patch}.xz

    tarball=${source}${tarball_file}
    pgp=${source}${pgp_file}
    patch=${source}${patch_file}
    incr_patch=${source}${incr_patch_file}
}

# https://www.kernel.org/signature.html

module_kernel_get_pgp() {
    gpg --locate-keys torvalds@kernel.org gregkh@kernel.org sashal@kernel.org bwh@kernel.org
}

module_kernel_trust_pgp() {
    gpg --tofu-policy good ABAF11C65A2970B130ABE3C479BE3E4300411886 
    gpg --tofu-policy good 647F28654894E3BD457199BE38DBBDC86092693E
    gpg --tofu-policy good E27E5D8A3403A2EF66873BBCDEA66FF797772CDC
    gpg --tofu-policy good AC2B29BD34A6AFDDB3F68F35E7BFC8EC95861109
}

module_kernel_requeriments_install() {
    # require gcc make bash binutils flex bison pahole util-linux kmod 
    # e2fsprogs squashfs-tools btrfs-progs pcmciautils quota-tools PPP 
    # nfs-utils procps udev grub mcelog iptables openssl&libcrypto bc 
    # sphinx cpio tar
    # finally
    sudo pacman -Syu base-devel bc flex bison ncurses openssl python cpio
}

module_kernel_unset() {
    unset repository 
    unset MAJOR MINOR PATCH
    unset source version
    unset linux patch incr_patch
    unset tarball_file pgp_file patch_file incr_patch_file
    unset tarball pgp patch incr_patch
    unset -f module_kernel_get_pgp module_kernel_trust_pgp module_kernel_requeriments_install module_kernel_unset 
}