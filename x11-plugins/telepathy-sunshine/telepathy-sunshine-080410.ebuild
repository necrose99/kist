# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
DESCRIPTION="Telepathy-sunshine is the Gadu-Gadu connection manager for Telepathy"
SRC_URI="http://www.kist-overlay-packages.yoyo.pl/${P}.tar.gz"
HOMEPAGE="http://git.collabora.co.uk/?p=user/kkszysiu/telepathy-sunshine.git;a=summary"
IUSE=""
DEPEND="net-im/empathy
		>=dev-lang/python-2.6
		sys-devel/automake
		dev-python/twisted
		>=dev-python/telepathy-python-0.15.17
		dev-python/twisted-web
		net-voip/telepathy-butterfly"
RDEPEND="${DEPEND}"

S="${WORKDIR}/telepathy-sunshine"

src_unpack() {
	unpack ${A}
}

src_configure() {
	cd $S
	./autogen.sh --prefix=/usr || die "Autogen.sh failed!"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
}