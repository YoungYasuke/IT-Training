# There was a previous document I used with standard user details like First Name, Last Name etc. in a text docuement the script below creates and adds these users to the domain.

# Entering a path to import users
$NewUsers = Import-Csv "C:\Users\Kola\Documents\Users.csv"

ForEach ($User in $NewUsers)
{
    $Username = $User.Username
    $Password = $User.Password
    $FirstName = $User.FirstName
    $LastName = $User.LastName
    $Department = $User.Department
    $OU = $User.OU

    if (Get-ADUser -Filter {SamAccountName -eq $Username})
    {
        Write-Host "User '$Username' Already Exists in the system"
    }
    else
    {
        New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@server123.local" `
            -Name "$FirstName $LastName" `
            -GivenName $FirstName `
            -Surname $LastName `
            -Enabled $true `
            -ChangePasswordAtLogon $true `
            -DisplayName "$FirstName $LastName" `
            -Department $Department `
            -Path $OU `
            -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force)
    }
}
