dnszone {
    'fubar.com':
        force  => true,
        ensure => absent,
        server => cd-ad01,
}

# dnsrecord {
    # 'wksa-mss0022.fubar.com.':
        # ensure => present,
        # value  => '172.21.5.179',
        # type   => 'A',
        # zone   => 'fubar.com.',
        # ttl    => 12001,
        # server => 'cc-ad01',
        # require => Dnszone['fubar.com'];
# }

# dnsrecord {
    # '1.5.5.5.in-addr.arpa.':
        # ensure => absent,
        # value  => 'wksa-mss0022.fubar.com.',
        # type   => 'PTR',
        # zone   => '5.5.5.in-addr.arpa.',
        # ttl    => 12008,
        # server => 'cc-ad01',
        # require => Dnszone['fubar.com'];
# }

# dnsrecord {
    # 'booya.fubar.com.':
        # ensure => present,
        # value  => 'wksa-mss0022.fubar.com.',
        # type   => 'CNAME',
        # zone   => 'fubar.com.',
        # ttl    => 12005,
        # server => 'cc-ad01',
        # require => Dnszone['fubar.com'];
# }