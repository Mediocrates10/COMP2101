$table = foreach ($c in (get-ciminstance win32_networkadapterconfiguration | where ipenabled )) {
        new-object -typename psobject -property @{
            Index = ($c).index
        	Description = ($c).description
        	Address = ($c).ipaddress
        	Subnet = ($c).ipsubnet
        	DNSDomain = ($c).dnsdomain
		DNSServer = ($c).dnsserver
    	}
    }
    $table | format-table