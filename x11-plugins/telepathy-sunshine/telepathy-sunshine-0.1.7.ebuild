# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Telepathy-sunshine is the Gadu-Gadu connection manager for Telepathy"
SRC_URI="http://git.collabora.co.uk/?p=user/kkszysiu/${PN}.git;a=snapshot;h=58fdc6e812c662175221ac2edfd6703f404ebda4;sf=tgz"
HOMEPAGE="http://git.collabora.co.uk/?p=user/kkszysiu/telepathy-sunshine.git;a=summary"
IUSE=""
DEPEND="net-im/empathy
		>=dev-lang/python-2.6
		sys-devel/automake
		dev-python/twisted"
RDEPEND="${DEPEND}"

S="${WORKDIR}/telepathy-sunshine"

src_unpack() {
	tar -xzf ${DISTDIR}/telepathy-sunshine* -C ${WORKDIR} || die
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