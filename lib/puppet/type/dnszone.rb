Puppet::Type.newtype(:dnszone) do
  @doc = "Manage DNS Hosted Zones"
  ensurable

  newparam(:zone) do
    desc "Absolute DNS zone name."
    isnamevar
  end


  newparam(:force, :boolean => true) do
    desc "Destroy zone even if records exist. Destroys all records in zone."
    newvalues(:true, :false)
    defaultto :false
    end
    
  newparam(:server) do
    desc 'Server with DNS service.'
  end
end
