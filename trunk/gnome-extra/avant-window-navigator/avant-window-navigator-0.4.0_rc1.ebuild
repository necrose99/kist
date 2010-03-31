# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit gnome2 python

PVS="0.4"

DESCRIPTION="Fully customisable dock-like window navigator."
HOMEPAGE="https://launchpad.net/awn"
SRC_URI="http://launchpad.net/awn/${PVS}/${PV/_rc1}/+download/${P/_/~}.tar.gz"
LICENSE="GPL-2 LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc nls vala"

RDEPEND="
	|| (
		>=dev-lang/python-2.5
		dev-python/elementtree
	)
	dev-libs/dbus-glib
	>=dev-libs/glib-2.16.0
	dev-python/pycairo
	>=dev-python/pygtk-2
	dev-python/pyxdg
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	>=x11-libs/libwnck-2.20
	vala? ( dev-lang/vala )
	x11-libs/desktop-agnostic"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.4 )"

S="${WORKDIR}/${P/_/~}"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-pymod-checks
		--disable-shave
		--disable-static
		--with-gconf-schema-file-dir=/etc/gconf/schemas
		--with-html-dir=/usr/share/doc/${PF}/html
		$(use_enable nls)
		$(use_enable doc gtk-doc)
                $(use_with vala)"
}

pkg_postinst() {
	dosym /usr/lib/libawn.so.1.0.1 /usr/lib/libawn.so.0
	gnome2_pkg_postinst
	python_mod_optimize $(python_get_sitedir)/awn
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup awn
}