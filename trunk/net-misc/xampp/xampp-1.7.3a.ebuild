# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#EAPI="2"
inherit eutils

DESCRIPTION="Local server"
HOMEPAGE="http://www.apachefriends.org/en/xampp-linux.html"
SRC_URI="http://freefr.dl.sourceforge.net/project/xampp/XAMPP%20Linux/1.7.3a/xampp-linux-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
}

src_install() {
	dodir /opt
	cp -r ${WORKDIR}/* ${D}/opt
}	

src_postinst() {
	elog "Please visit http://www.apachefriends.org/en/xampp-linux.html#377"
	elog "for further information."
	elog ""
	elog "To start xampp, type (as root):"
	elog "    /opt/lampp/lampp start"
}