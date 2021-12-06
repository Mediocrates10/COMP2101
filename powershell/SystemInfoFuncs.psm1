function hardware_info {
	echo "HARDWARE INFO"
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
}

function os_info {
	echo "OS INFO"
	$os = foreach ($p in (get-ciminstance win32_operatingsystem)) {
	new-object -typename psobject -property @{
			Name = ($p).name
			Version = ($p).version
		}

	}
	$os | fl
}

function processor_info {
	echo "CPU INFO"
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
}

function ram_info {
	echo "RAM INFO"
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
}



function graphics_info {
	echo "GPU INFO"
	$gpu = foreach ($p in (get-ciminstance win32_videocontroller)) {
	new-object -typename psobject -property @{
			Vendor = ($p).name
			Description = ($p).description
			Resolution = "$(($p).currenthorizontalresolution) x $(($p).currentverticalresolution)"
		}
	}
	$gpu | fl 
}

function nac_info {
	echo "NAC INFO"
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
}


function disks_info {
	echo "DISK INFO"
	echo "This is where the disk report would go if I could get it working"
}