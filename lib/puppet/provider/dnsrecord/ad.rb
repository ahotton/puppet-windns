require File.join(File.dirname(__FILE__), '..', 'ad')

Puppet::Type.type(:dnsrecord).provide(:dnsrecord, :parent => Puppet::Provider::Ad) do
    desc "DNS Record"

    def exists?
      rc=false
      objRR=wmi_exec_rr
      (objRR.each {|record| record && rc=true})
      return rc
    end

    def value
      objRR=wmi_exec_rr
      (objRR.each {|record| @value=record.Properties_.Item('RecordData').value})
      return @value
    end

    def value= newvalue
      objWMIService=wmi_connect
      dnsclass=wmi_class @resource[:type]
      records = objWMIService.ExecQuery("SELECT * FROM #{dnsclass} WHERE ContainerName='#{@resource[:zone]}' AND OwnerName='#{@resource[:name]}' AND RecordData='#{@resource[:value]}'")
      records.each {|record| p record.ttl}
      records.each {|record| record.Modify nil, @resource[:value]}
    end

    def ttl
      objRR=wmi_exec_rr
      (objRR.each {|record| @ttl=record.Properties_.Item('TTL').value})
      return @ttl
    end
  
    def ttl= newvalue
      objWMIService=wmi_connect
      dnsclass=wmi_class (@resource[:type])
      records = objWMIService.ExecQuery("SELECT * FROM #{dnsclass} WHERE ContainerName='#{@resource[:zone]}' AND OwnerName='#{@resource[:name]}' AND RecordData='#{@resource[:value]}'")
      # p "ttl #{records.count} set #{@resource[:ttl]}"      
      records.each {|record| record.Modify @resource[:ttl]}
    end

    def create
      objWMIService=wmi_connect
      dnsclass=wmi_class (@resource[:type])
      objitem = objWMIService.get(dnsclass)
        blah="" # don't care about return handle
        objitem.CreateInstanceFromPropertyData(@resource[:server],@resource[:zone],@resource[:name],1,@resource[:ttl],@resource[:value], blah)
      
    end
    
  def destroy
      p "destroy"
      objRR=wmi_exec_rr
      objRR.each {|record| record.Delete_}
  end
end
