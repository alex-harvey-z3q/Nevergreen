$Version = Get-Version -Uri 'https://help.webex.com/en-us/article/mqkve8/Webex-App-%7C-Release-notes' -Pattern 'Windows[^\d]+((?:\d+\.)+(?:\d+))'

$URL = Get-Link -Uri 'https://help.webex.com/en-us/article/nw5p67g/Webex-App-%7C-Installation-and-automatic-upgrade' -MatchProperty href -Pattern 'Webex\.msi'
$URLEN = Get-Link -Uri 'https://help.webex.com/en-us/article/nw5p67g/Webex-App-%7C-Installation-and-automatic-upgrade' -MatchProperty href -Pattern 'Webex_en\.msi'
$URLBundle = Get-Link -Uri 'https://help.webex.com/en-us/article/nw5p67g/Webex-App-%7C-Installation-and-automatic-upgrade' -MatchProperty href -Pattern 'WebexBundle\.msi'
$URLBundleEN = Get-Link -Uri 'https://help.webex.com/en-us/article/nw5p67g/Webex-App-%7C-Installation-and-automatic-upgrade' -MatchProperty href -Pattern 'WebexBundle_en\.msi'

New-NevergreenApp -Name 'Cisco Webex' -Version $Version -Uri $URL -Architecture 'x64' -Type 'Msi' -Language 'Multi'
New-NevergreenApp -Name 'Cisco Webex' -Version $Version -Uri $URLEN -Architecture 'x64' -Type 'Msi' -Language 'en'
New-NevergreenApp -Name 'Cisco Webex Bundle' -Version $Version -Uri $URLBundle -Architecture 'x64' -Type 'Msi' -Language 'Multi'
New-NevergreenApp -Name 'Cisco Webex Bundle' -Version $Version -Uri $URLBundleEN -Architecture 'x64' -Type 'Msi' -Language 'en'