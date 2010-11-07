# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEEDS_PYTHON=2.4
EAPI="3"

inherit autotools eutils python gnome2

DESCRIPTION="A desktop-agnostic library for GLib-based projects"
HOMEPAGE="https://launchpad.net/libdesktop-agnostic"
SRC_URI="http://launchpad.net/libdesktop-agnostic/0.4/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug gconf glade gnome gnome-vfs xfce"

SHARED_DEPEND=">=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.12
	>=dev-libs/gir-repository-0.6.5
	>=dev-python/pygobject-2.12
	>=dev-python/pygtk-2.12
	gconf? ( >=gnome-base/gconf-2.0 )
	gnome? (
		gnome-base/gnome-desktop
	)
	gnome-vfs? (
		gnome-base/gnome-vfs:2
	)
	glade? (
		dev-util/glade
	)
	xfce? ( xfce-base/thunar )"

DEPEND="${SHARED_DEPEND}
	<dev-libs/gobject-introspection-0.7.0
	>=dev-lang/vala-0.7.7
	<=dev-lang/vala-0.8.0"
RDEPEND="${SHARED_DEPEND}"

EBZR_PATCHES=(
	"${FILESDIR}/${PN}-vala-fix.patch"
)
	
src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-vala-fix.patch"
}

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
		myconf="${myconf} --with-glade"
	fi
	./waf configure --prefix=/usr --config-backends=${cfg} \
		--desktop-entry-backends=${de} --vfs-backends=${vfs} \
		${myconf} -kf || die "Could not configure ${PN}."
}

src_compile() {
	./waf
	sed -i 's|repository version="1.1"|repository version="1.0"|' build/default/libdesktop-agnostic/DesktopAgnostic*.gir
	sed -i 's|repository version="1.2"|repository version="1.0"|' build/default/libdesktop-agnostic/DesktopAgnostic*.gir
	./waf || die "Build failed"
}

src_install() {
	./waf install --destdir="${D}" || die "Installation failed"
}