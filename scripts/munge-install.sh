 tar xJf munge-0.5.16.tar.xz
 cd munge-0.5.16
 ./configure \
  --prefix=/usr \
  --sysconfdir=/etc \
  --localstatedir=/var \
  --runstatedir=/run
 make -j 2
 make check
 sudo make install

chown -R munge: /etc/munge /var/log/munge /var/lib/munge
chmod 600 /etc/munge/munge.key
sudo -u munge /usr/sbin/mungekey -k /etc/munge/munge.key

touch /home/vagrant/installed-successfully
