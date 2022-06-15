$UserList = Get-ADUser -Filter '*' -Properties name, displayname, samaccountname, title, office, EmailAddress, officephone, telephonenumber, mobile, mobilephone, manager | Select-Object name, displayname, samaccountname, title, office, EmailAddress, officephone, telephonenumber, mobile, mobilephone, manager}


$ExportList = foreach($user in $UserList) {
    $l2man= Get-ADUser $user.manager -Properties samaccountname | Select-Object samaccountname
    $PSCustomObject = @{
        "Legal Name" = $user.name
        "Display Name" = $user.displayname
        "User Name" = $user.samaccountname
        "Title" = $user.title
        "Office" = $user.office
        "Email" = $user.EmailAddress
        "Office Phone" = $user.officephone
        "Telephone" = $user.telephonenumber
        "Mobile" = $user.mobile
        "Mobile Phone" = $user.mobilephone
        "L1 Manager" = $user.manager
        "L2 Manager" = $l2man.samaccountname
    }
    $PSCustomObject
}
$ExportList | Select-Object "Legal Name", "Display Name", "User Name", "Title", "Office", "Email", "Office Phone", "Telephone", "Mobile", "Mobile Phone", "L1 Manager", "L2 Manager" | Export-Csv c:\export.csv
