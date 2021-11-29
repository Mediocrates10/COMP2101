echo "SYSTEM REPORT"
echo "System Hardware Description"
$hardware = foreach ($p in (get-ciminstance win32_computersystem)) {
	new-object -typename psobject -property @{
			Name = ($p).name
			PrimaryOwnerName = ($p).primaryownername
			Domain = ($p).domain
			"TotalPhysicalMemory(GB)" = ($p).totalphysicalmemory / 1gb -as [int]
			Model = ($p).model
			Manufacturer = ($p).manufacturer
		}

	}
$hardware | fl 

echo "Operating System Information"
$os = foreach ($p in (get-ciminstance win32_operatingsystem)) {
	new-object -typename psobject -property @{
			Name = ($p).name
			Version = ($p).version
		}

	}
$os | fl 

echo "Processor Description"
$cpu = foreach ($p in (get-ciminstance win32_processor)) {
	new-object -typename psobject -property @{
			"Speed(GHz)" = ($p).maxclockspeed
			"NumberOfCores" = ($p).numberofcores
			"L1CacheSize(MB)" = "data unavailable"
			"L2CacheSize(MB)" = ($p).l2cachesize / 1024 
			"L3CacheSize(MB)" = ($p).l3cachesize / 1024
		}

	}
$cpu | fl

echo "RAM Summary"
$totalRAM = 0
$memory = get-ciminstance win32_physicalmemoryarray
foreach ($ram in $memory) {
	$sticks = $ram|get-cimassociatedinstance -resultclassname CIM_PhysicalMemory
	$ramTable = foreach ($s in $sticks) {
		
		new-object -typename psobject -property @{
			"Size(GB)" = ($s).capacity / 1gb -as [int]
			Vendor = ($s).manufacturer
			Description = ($s).description
			Bank = ($s).banklabel
			
		}
		$totalRAM = $totalRAM + ($s).capacity / 1gb -as [int]
	}	
}
$ramTable | ft -autosize
echo "Total RAM(GB):"
echo $totalRAM

echo "Network Adapter Configuration"
$nacTable = foreach ($c in (get-ciminstance win32_networkadapterconfiguration | where ipenabled )) {
        new-object -typename psobject -property @{
            	Index = ($c).index
        	Description = ($c).description
        	Address = ($c).ipaddress
        	Subnet = ($c).ipsubnet
                DNSDomain = ($c).dnsdomain 
		DNSServer = "data unavailable"
    	}
}
$nacTable | ft -autosize

echo "Video Card Information"
$gpu = foreach ($p in (get-ciminstance win32_videocontroller)) {
	new-object -typename psobject -property @{
			Vendor = ($p).name
			Description = ($p).description
			Resolution = "$(($p).currenthorizontalresolution) x $(($p).currentverticalresolution)"
		}
	}
$gpu | fl 



