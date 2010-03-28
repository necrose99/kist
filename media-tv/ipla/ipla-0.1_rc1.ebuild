# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SLOT="0"
LICENSE="*"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="A famous live-tv player"
SRC_URI="http://ipla.pl/templates/ipla/assets/iplalite.air
	http://kist.googlecode.com/svn/branches/ipla"
HOMEPAGE="http://www.ipla.pl"
IUSE=""
DEPEND="app-arch/unzip
	dev-util/adobe-air-sdk-bin"
RDEPEND=""

pkg_nofetch() {
	elog "Please download http://ipla.pl/templates/ipla/assets/iplalite.air"
	elog "and save to ${DISTDIR}"
}

src_unpack() {
	for i in ${A}; do
		if [[ ${i} = *.air ]]; then
			unzip ${DISTDIR}/${i} -d ${WORKDIR} || die "Unable to unzip"
		fi
	done
}

src_install() {
	declare IPLA_HOME="/opt/AIR-apps/ipla-lite"

	dodir /opt/AIR-apps || die
	dodir /opt/AIR-apps/ipla-lite || die

	mv ${WORKDIR}/* ${D}/opt/AIR-apps/ipla-lite || die
	exeinto /usr/bin
	doexe ${DISTDIR}/ipla
	chmod +x ${D}/usr/bin/ipla
}

pkg_postinst() {
	elog "Notice, that to run Ipla, you must run"
	elog "desktop environment, i.e. Gnome or KDE."
	elog "Ipla will not work on fluxbox or openbox."
	elog ""
	elog "You can run ipla by typing \"ipla\" in terminal."
}