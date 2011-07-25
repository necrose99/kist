# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=3
inherit gnome2 python

DESCRIPTION="Fully customizable dock for the Free desktop"
HOMEPAGE="https://launchpad.net/awn"
SRC_URI="http://launchpad.net/awn/0.4/${PV}/+download/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1 CCPL-Attribution-ShareAlike-3.0"

SLOT="0"
KEYWORDS="~x86"
IUSE="doc gconf"

RDEPEND="
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
	x11-libs/libdesktop-agnostic[gconf?]
	>=x11-libs/libwnck-2.22
	dev-python/pyxdg
"
DEPEND="!=dev-libs/glib-2.16.0
	dev-python/pycairo
	dev-python/pygtk:2
	gnome-base/libgtop
	>=x11-libs/gtk+-2.12.0
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libdesktop-agnostic[gconf?]
	>=x11-libs/libwnck-2.22

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
DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	gnome2_src_unpack
	rm py-compile
	ln -s $(type -P true) py-compile
}

src_compile() {
	econf $( use_enable doc gtk_doc) \
		$(use_enable gconf schemas-install) \
		--disable-static \
		--disable-pymod-checks \
		--enable-extra-version=-gentoo-desktop-effects

	emake || die "emake failed"

}

pkg_preinst() {
        dosym /usr/lib/libawn.so /usr/lib/libawn.so.0
}

pkg_postinst() {
	gnome2_pkg_postinst

	ewarn
	ewarn "AWN will be of no use if you do not have a compositing manager."

	python_mod_optimize awn
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup awn
}