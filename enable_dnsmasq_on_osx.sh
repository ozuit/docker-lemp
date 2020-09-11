# bash <(curl -s https://gist.github.com/drye/5387341/raw/ec72cddfe43ec3d39c91a3c118cb68ab14a049f8/enable_dnsmasq_on_osx.sh)

# ----------------------
# installing dnsmasq and enable daemon
# ----------------------
brew install dnsmasq
sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
# ----------------------
# adding resolver for local domain
# ----------------------
[ -d /etc/resolver ] || sudo mkdir -v /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/test'
# ----------------------
# configuring dnsmasq
# ----------------------
sudo mkdir -p $(brew --prefix)/etc/
cat > $(brew --prefix)/etc/dnsmasq.conf <<-EOF
listen-address=127.0.0.1
address=/.test/127.0.0.1
# keep nameserver order of resolv.conf
strict-order
EOF
# ----------------------
# launching dnsmasq
# ----------------------
sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
