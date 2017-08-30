#or https://copr.fedorainfracloud.org/coprs/antergos/lightdm-webkit2-greeter/
# http://download.opensuse.org/repositories/home:/antergos/Fedora_23/src/lightdm-webkit2-greeter-2.1.4-30.1.src.rpm
dnf install gnome-common intltool lightdm-gobject-devel gtk3 webkitgtk4 dbus-glib exo-devel
mkdir ~/tmp/
cd ~/tmp
git clone https://github.com/Antergos/lightdm-webkit2-greeter.git greeter
cd greeter
git checkout ${LATEST_RELEASE_TAG} # eg. git checkout 2.1.4
./autogen.sh --prefix=/usr
make


sudo dnf copr enable antergos/lightdm-webkit2-greeter
sudo dnf update
sudo dnf install lightdm-webkit-greeter
