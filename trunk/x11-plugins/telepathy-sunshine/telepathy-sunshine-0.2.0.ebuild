# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Telepathy-sunshine is the Gadu-Gadu connection manager for Telepathy"
SRC_URI="http://telepathy.freedesktop.org/releases/telepathy-sunshine/${P}.tar.gz"
HOMEPAGE="http://git.collabora.co.uk/?p=user/kkszysiu/telepathy-sunshine.git;a=summary"
IUSE=""
DEPEND="net-im/empathy
		>=dev-lang/python-2.6
		sys-devel/automake
		dev-python/twisted
		>=dev-python/telepathy-python-0.15.17
		dev-python/twisted-web"
RDEPEND="${DEPEND}"

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
}
