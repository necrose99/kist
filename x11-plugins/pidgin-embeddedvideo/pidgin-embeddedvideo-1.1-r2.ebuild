# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit gnome2

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Watch videos directly into your Pidgin conversation"
SRC_URI="http://pidgin-embeddedvideo.googlecode.com/files/${PN}-1.1-2.tar.gz"
HOMEPAGE="http://code.google.com/p/pidgin-embeddedvideo/"
IUSE=""
DEPEND="net-im/pidgin
		www-plugins/adobe-flash"
RDEPEND="${DEPEND}"

pkg_setup() {
	S="${WORKDIR}/${PN}"
}

src_compile() {
	emake -j1 || die "Emake failed!"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
}