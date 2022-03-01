$Devices = @(
    @{
        type='standardcamera'
        ip='192.168.0.1'
    },
    @{
        type='minicamera'
        ip='192.168.0.2'
    }
)
ConvertTo-Json -InputObject $Devices
$Devices| ConvertTo-Json | Out-File "deviceInfo.json"