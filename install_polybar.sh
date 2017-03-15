# For more info on what is happening here, see blog post (link TBC - 2017/03/15)

# Install build dependencies
sudo dnf install cmake @development-tools gcc-c++
sudo dnf install cairo-devel xcb-proto xcb-util-devel xcb-util-wm-devel xcb-util-image-devel

# Install specific module dependencies
sudo dnf install i3-ipc jsoncpp-devel alsa-lib-devel wireless-tools-devel libmpdclient-devel libcurl-devel

# Get source
rm -rf ~/.ncx/tmp/polybar
git clone --recursive https://github.com/jaagr/polybar ~/.ncx/tmp/polybar
cd ~/.ncx/tmp/polybar

# Check out the latest tagged release
currentRelease=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $currentRelease

./build.sh