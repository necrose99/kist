# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND=2:2.4

inherit python bzr

EBZR_REPO_URI="lp:libdesktop-agnostic"

DESCRIPTION="A desktop-agnostic library for GLib-based projects"
HOMEPAGE="https://launchpad.net/libdesktop-agnostic"
SRC_URI=""

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug gnome gnome-vfs xfce"

RDEPEND=">=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.12
	>=dev-libs/gir-repository-0.6.3
	>=dev-libs/gobject-introspection-0.6.3
	>=dev-python/pygobject-2.12
	>=dev-python/pygtk-2.12
	gnome? ( gnome-base/gnome-desktop )
	gnome-vfs? ( gnome-base/gnome-vfs:2 )
	xfce? ( xfce-base/thunar:1 )"
DEPEND="${RDEPEND}
	>=dev-libs/gobject-introspection-0.6.3
	>=dev-lang/vala-0.7.0"
RDEPEND="${RDEPEND}"

src_prepare() {
	# See https://bugs.launchpad.net/libdesktop-agnostic/+bug/519831
	epatch ${FILESDIR}/desktop-agnostic-various-fixes.patch
}

src_configure() {
	local cfg="keyfile" de="glib" vfs="gio" myconf=""
	if use gnome; then
		cfg="gconf"
		de="gnome,${de}"
	fi
	if use gnome-vfs; then
		vfs="gnome-vfs,${vfs}"
	fi
	if use xfce; then
		vfs="thunar-vfs,${vfs}"
	fi
	if use debug; then
		myconf="${myconf} --enable-debug"
	fi
	./waf configure \
		--prefix=/usr \
		--config-backends=${cfg} \
		--desktop-entry-backends=${de} \
		--vfs-backends=${vfs} \
		${myconf} || die "configure failed"
}

src_compile() {
	./waf || die "compile failed"
}

src_install() {
	./waf install --destdir="${D}" || die "install failed"
}