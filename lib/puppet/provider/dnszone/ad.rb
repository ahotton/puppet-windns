require File.join(File.dirname(__FILE__), '..', 'ad')

Puppet::Type.type(:dnszone).provide(:dnszone, :parent => Puppet::Provider::Ad) do
  desc "DNS Record"

  def exists?
    rc=false
    objZone=wmi_exec_zone
    (objZone.each {|zone| zone && rc=true})
    return rc
  end

  def create
    objWMIService=wmi_connect
    objItem = objWMIService.get("MicrosoftDNS_Zone")

      #intPrimaryZone
      # 1 AD integrated.
      # 2 Secondary zone.
      # 3 Stub zone.
      # 4 Zone forwarder.

    #dsintegrated
    # IpAddr 
    # AdminEmailName
    
    # there is a mistake on
    # MSDN documentation
    # about CreateZone Method of the MicrosoftDNS_Zone Class.
    # On the Microsoft site we can read this method accepts 6 parameters
    # (zonename, zonetype, DataFileName, IpAddr, AdminEmailName, RR).
    # With WMI Studio, we can read 7 parameters (zonename, zonetype,
    # DsIntegrated, DataFileName, IpAddr, AdminEmailName, RR).
    objItem.CreateZone(@resource[:name], 0, true)
    #objItem.CreateZone(@resource[:name], 0, TRUE, nil, nil, "hostmaster@#{@resource[:name]}")
  end

  def destroy
    if @resource[:force] == true then
      #iterate all records of zone and delete them.
      # delete zone
    else
      self.fail "Must use :force metaparameter to destroy zone."
    end
  end
end
