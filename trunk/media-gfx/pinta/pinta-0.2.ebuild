# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Simple painting for GTK"
SRC_URI="https://launchpad.net/~moonlight-team/+archive/pinta/+files/pinta_${PV}.orig.tar.gz http://kist.googlecode.com/svn/branches/Pinta/pinta http://kist.googlecode.com/svn/branches/Pinta/pinta.desktop http://kist.googlecode.com/svn/branches/Pinta/pinta.xpm"
HOMEPAGE="http://pinta-project.com/"
IUSE=""
DEPEND="dev-lang/mono
	dev-dotnet/gtk-sharp
	dev-libs/dbus-glib
	gnome-base/gnome-vfs
	x11-libs/gtk+
	dev-util/intltool
	dev-dotnet/gnome-sharp
	dev-dotnet/gnome-keyring-sharp
	x11-libs/libnotify"
RDEPEND="${DEPEND}"

src_unpack() {
	for i in ${A}; do
		if [[ ${i} = *.tar.gz ]]; then
			unpack ${i} || die "Unpack failed!"
		fi
	done
}

src_compile() {
	dodir /root
	dodir /root/.config
	cd ${WORKDIR}/jpobst-Pinta-0508750 || die
	xbuild Pinta.sln || die "Compiling failed!"
	xbuild Pinta/Pinta.csproj || die "Compile failed!"
}

src_install() {
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
}

