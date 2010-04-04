# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEEDS_PYTHON=2.4
EAPI="2"

inherit python bzr

DESCRIPTION="A desktop-agnostic library for GLib-based projects"
HOMEPAGE="https://launchpad.net/libdesktop-agnostic"
SRC_URI=""
EBZR_REPO_URI="lp:libdesktop-agnostic"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="debug gconf glade gnome gnome-vfs xfce"

SHARED_DEPEND=">=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.12
	>=dev-python/pygobject-2.12
	>=dev-python/pygtk-2.12
	gconf? ( >=gnome-base/gconf-2.0 )
	gnome? (
		gnome-base/gnome-desktop
	)
	gnome-vfs? (
		gnome-base/gnome-vfs:2
	)
	xfce? ( xfce-base/thunar )"

DEPEND="${SHARED_DEPEND}
	dev-libs/gobject-introspection
	>=dev-lang/vala-0.7.7"
RDEPEND="${SHARED_DEPEND}"

src_configure() {
	local cfg="keyfile" de="glib" vfs="gio" myconf=""
	if use gconf; then
		cfg="gconf,${cfg}"
	fi
	if use gnome; then
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
	if use glade; then
		myconf="${myconf} --enable-glade"
	fi
	./waf configure --prefix=/usr --config-backends=${cfg} \
		--desktop-entry-backends=${de} --vfs-backends=${vfs} \
		${myconf} || die "Could not configure ${PN}."
}

src_compile() {
	./waf || die "Could not compile ${PN}."
}

src_install() {
	./waf install --destdir="${D}" || die "Could not install ${PN}."
}