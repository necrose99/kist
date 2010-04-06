# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
EBZR_REPO_URI="lp:awn"
NEED_PYTHON="2.5"

inherit autotools bzr gnome2 python

DESCRIPTION="Fully customizable dock for the Free desktop"
HOMEPAGE="https://launchpad.net/awn"
SRC_URI=""
LICENSE="GPL-2 LGPL-2.1 CCPL-Attribution-ShareAlike-3.0"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc gconf +extras"

COMMON_DEPEND="
	dev-libs/dbus-glib
	>=dev-libs/glib-2.16.0
	dev-python/pycairo
	dev-python/pygtk:2
	gnome-base/libgtop
	>=x11-libs/gtk+-2.12.0
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/desktop-agnostic
	>=x11-libs/libwnck-2.22
"

RDEPEND="${COMMON_DEPEND}
	dev-python/pyxdg
"
DEPEND="${COMMON_DEPEND}
	|| ( >=dev-lang/vala-0.7.9 ~dev-lang/vala-0.7.7 )
	>=dev-util/gtk-doc-1.4
	>=dev-util/intltool-0.35.5
	dev-util/pkgconfig
	x11-proto/compositeproto
	x11-proto/renderproto
	x11-proto/xextproto
	x11-proto/xproto
	gconf? ( gnome-base/gconf:2 )
"

PDEPEND=" extras? ( gnome-extra/avant-window-navigator-extras )"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable doc gtk-doc)
		$(use_enable gconf schemas-install)
		--disable-static
		--disable-pymod-checks
		--enable-extra-version=-gentoo-desktop-effects
	"
}

src_unpack() {
	bzr_src_unpack
}

src_prepare() {
	gtkdocize || die "gtkdocize failed"
	intltoolize --copy --force || die "intltoolize failed"
	eautoreconf || die "eautoreconf failed"
	# disable pyc compiling - from gnome-python-common.eclass
	if [[ -f py-compile ]]; then
		rm py-compile
		ln -s $(type -P true) py-compile
	fi
}

pkg_preinst() {
	dosym /usr/lib/libawn.so /usr/lib/libawn.so.0
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize $(python_get_sitedir)/awn
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup awn
}