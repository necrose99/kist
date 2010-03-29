# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SLOT="0"
LICENSE="*"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Kiczowaty i ciężki odtwarzacz live-tv dla linuksa."
SRC_BASE="http://ipla.pl/templates/ipla/assets/iplalite.air
	http://kist.googlecode.com/svn/branches/ipla"
SRC_URI="
	x86? ( ${SRC_BASE} )
	amd64? ( ${SRC_BASE} http://mirrors.kernel.org/ubuntu/pool/main/g/gnome-keyring/libgnome-keyring0_2.28.1-0ubuntu1_i386.deb )"
HOMEPAGE="http://www.ipla.pl"
IUSE=""
DEPEND="app-arch/unzip
	dev-util/adobe-air-sdk-bin
	>=gnome-base/gnome-keyring-2.28.1"
RDEPEND=""

pkg_nofetch() {
	elog "Please download http://ipla.pl/templates/ipla/assets/iplalite.air"
	elog "and save to ${DISTDIR}"
}

src_unpack() {
	for i in ${A}; do
		if [[ ${i} = *.air ]]; then
			dodir ${WORKDIR}/ipla
			unzip ${DISTDIR}/${i} -d ${WORKDIR}/ipla || die "Unable to unzip"
		fi
	done
	if use amd64 ; then
		if [[ ${i} = *.deb ]]; then
			ar x "${DISTDIR}"/${i}
			for i in ${A}; do
				if [[ ${i} = *.deb ]]; then
					if [[ -e "${WORKDIR}"/data.tar.lzma ]]; then
						mv "${WORKDIR}"/data.tar.lzma "${WORKDIR}"/${i%%_*}.tar.lzma
					elif [[ -e "${WORKDIR}"/data.tar.gz ]]; then
						mv "${WORKDIR}"/data.tar.gz "${WORKDIR}"/${i%%_*}.tar.gz
					else
						die "Can't find data from ${i}"
					fi
				fi
			done
		fi
	fi
}

src_install() {
	declare IPLA_HOME="/opt/AIR-apps/ipla-lite"

	dodir /opt/AIR-apps || die
	dodir /opt/AIR-apps/ipla-lite || die

	mv "${WORKDIR}"/ipla/* ${D}/opt/AIR-apps/ipla-lite || die
	exeinto /usr/bin
	doexe ${DISTDIR}/ipla
	chmod +x ${D}/usr/bin/ipla
	if use amd64 ; then
		tar -xzf "${WORKDIR}"/libgnome-keyring0.tar.gz -C ${WORKDIR} || die
#		into /usr/lib32
#		dolib "${WORKDIR}"/usr/lib/libgnome-keyring.so.0.1.1 || die "lib fail"
		dodir /usr/lib32
		cp ${WORKDIR}/usr/lib/libgnome-keyring.so.0.1.1 ${D}/usr/lib32/libgnome-keyring.so.0.1.1 || die "moving failed"
		ln -s ${D}/usr/lib32/libgnome-keyring.so.0.1.1 ${D}/usr/lib32/libgnome-keyring.so.0
	fi
}

pkg_postinst() {
	elog ""
	elog "Notice, that to run Ipla, you must run"
	elog "desktop environment, i.e. Gnome or KDE."
	elog "Ipla will not work on fluxbox or openbox."
	elog ""
	elog "You can run ipla by typing \"ipla\" in terminal."
	elog ""
}
