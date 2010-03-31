# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Simple painting for GTK"
SRC_URI="
	build? ( https://launchpad.net/~moonlight-team/+archive/pinta/+files/pinta_${PV}.orig.tar.gz http://kist.googlecode.com/svn/branches/Pinta/pinta http://kist.googlecode.com/svn/branches/Pinta/pinta.desktop http://kist.googlecode.com/svn/branches/Pinta/pinta.xpm )
	!build? ( http://github.com/downloads/jpobst/Pinta/pinta-${PV}.noarch.rpm )"
HOMEPAGE="http://pinta-project.com/"
IUSE="build"
DEPEND="dev-lang/mono
	dev-dotnet/gtk-sharp
	dev-libs/dbus-glib
	gnome-base/gnome-vfs
	x11-libs/gtk+
	dev-util/intltool
	dev-dotnet/gnome-sharp
	dev-dotnet/gnome-keyring-sharp
	x11-libs/libnotify
	!build? ( app-arch/rpm2targz )"
RDEPEND="${DEPEND}"

src_unpack() {
	if use build; then
		for i in ${A}; do
			if [[ ${i} = *.tar.gz ]]; then
				unpack ${i} || die "Unpack failed!"
			fi
		done
	else
		for i in ${A}; do
			if [[ ${i} = *.rpm ]]; then
				cd ${WORKDIR}
				rpm2targz ${DISTDIR}/${i}
				tar -xzf pinta-${PV}.noarch.tar.gz -C ${WORKDIR}
			fi
		done
	fi
}

src_compile() {
	if use build; then
		cd ${WORKDIR}/jpobst-Pinta-0508750 || die
		xbuild Pinta.sln || die "Compiling failed!"
		xbuild Pinta/Pinta.csproj || die "Compile failed!"
	fi
}

src_install() {
	if use build; then
		exeinto /usr/bin/
		doexe ${DISTDIR}/pinta

		declare PINTA_WORK="${WORKDIR}/jpobst-Pinta-0508750/bin"
		dodir /usr/lib/pinta
		insinto /usr/lib/pinta/
		doins ${PINTA_WORK}/Pinta.Core.dll ${PINTA_WORK}/Pinta.exe ${PINTA_WORK}/Pinta.Gui.Widgets.dll ${PINTA_WORK}/Pinta.Resources.dll

		insinto /usr/share/applications/
		doins ${DISTDIR}/pinta.desktop

		insinto /usr/share/pixmaps/
		doins ${DISTDIR}/pinta.xpm

	else
		exeinto /usr/bin
		doexe usr/bin/pinta

		dodir /usr/lib/pinta
		cp -r usr/lib/pinta/* ${D}/usr/lib/pinta

		insinto /usr/share/applications
		doins usr/share/applications/pinta.desktop

		insinto /usr/share/pixmaps
		doins usr/share/pixmaps/Pinta.png
	fi
}

