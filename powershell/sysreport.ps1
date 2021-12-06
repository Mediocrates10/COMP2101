param ( $func ="" )
echo "SYSTEM REPORT"
if ($func -eq "system" -or $func -eq "") {
	os_info
	processor_info
	ram_info
	graphics_info
}

if ($func -eq "network" -or $func -eq "") {
	nac_info
}

if ($func -eq "disks" -or $func -eq "") {
	disks_info
}


