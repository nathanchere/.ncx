# Assumes brcmfmac
# To identify other wireless network devices:
# sudo lshw -C network 2>&1 | grep wireless | grep driver
sudo modprobe -r brcmfmac && sudo modprobe brcmfmac
