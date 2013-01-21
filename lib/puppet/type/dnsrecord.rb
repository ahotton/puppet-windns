Puppet::Type.newtype(:dnsrecord) do
    @doc = 'Manage DNS records'
    ensurable

    # autorequire(:dnszone) do
      #[self[:zone]]
    # end

    newparam(:name) do
        desc 'Absolute DNS record name.'
        isnamevar
        validate do |value|
        raise Puppet::Error, "Name must not be empty" if value.empty?
      end
    end

    newparam(:zone) do
        desc 'Absolute DNS zone name.'

        validate do |value|
            unless value.match /\.$/
                self.fail "(#{value}) absolute DNS names must end with a period."
            end
        end
    end

    newproperty(:value) do
        desc 'IP address or DNS alias target.'
    end

    newparam(:type) do
        desc 'Record type: A, AAAA, MX, CNAME, TXT. Default: A'
        defaultto 'A'
    end

    newproperty(:ttl) do
      desc 'Time To Live (TTL) for query in seconds. '

      munge do |value|
        if value.is_a?(String)
          unless value =~ /^[\d]+$/
            raise ArgumentError, "ttl must be an integer"
          end
          value = Integer(value)
        end
        raise ArgumentError, "ttl must be an integer >= 1" if value < 1
        value
      end
    end

    newparam(:server) do
        desc 'Server with DNS service.'
    end
end