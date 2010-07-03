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
	amd64? ( ${SRC_BASE} ftp://ftp.icm.edu.pl/vol/rzm1/linux-fedora/linux/development/rawhide/i386/os/Packages/libgnome-keyring-2.30.1-1.fc14.i686.rpm )"
HOMEPAGE="http://www.ipla.pl"
IUSE=""
DEPEND="app-arch/unzip
	dev-util/adobe-air-sdk-bin
	app-arch/rpm2targz
	dev-libs/nss
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
		for i in ${A}; do
			if [[ ${i} = *.rpm ]]; then
				cd ${WORKDIR} || die
				rpm2targz ${DISTDIR}/${i} || die
				tar -xzf *.tar.gz -C ${WORKDIR} || die
				rm *.tar.gz
			fi
		done
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
		dodir /usr/lib32
		cp ${WORKDIR}/usr/lib/libgnome-keyring.so.0.1.1 ${D}/usr/lib32/libgnome-keyring.so.0.1.1 || die "Making lib failed"
		dosym /usr/lib32/libgnome-keyring.so.0.1.1 /usr/lib32/libgnome-keyring.so.0
	fi
}

pkg_postinst() {
	ewarn "Imporant:"
	elog "Notice, that to run Ipla, you must run"
	elog "desktop environment, i.e. Gnome or KDE."
	elog "Ipla will not work on fluxbox or openbox."
	elog ""
	elog "Now, you can run ipla by typing \"ipla\" in terminal."
	elog "I give you no guarantee, that ipla will run - it's so crazy."
	elog ""
	elog "If ipla start, but does not connect to internet, visit"
	elog "http://kb2.adobe.com/cps/492/cpsid_49267.html"
}
