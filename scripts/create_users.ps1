function Create-SpecificADUser {
    param (
        [Parameter(Mandatory = $true)]
        $Name,
        [Parameter(Mandatory = $true)]
        $Surname
    )

    $user_password = ConvertTo-SecureString -String "P@ssw0rd!" -AsPlainText -Force
    $sam_account_name = [string]::Format("{0}.{1}", $name[0], $surname).ToLower()
    New-ADUser -Enabled:$true -Name "$Name $Surname" -SamAccountName $sam_account_name -AccountPassword $user_password
}

function Remove-SpecificADUser {
    param (
        $Name,
        $Surname
    )

    $sam_account_name = [string]::Format("{0}.{1}", $name[0], $surname).ToLower()
    Remove-ADUser -Identity $sam_account_name -Confirm:$false
}

function Create-UsersFromWordlist {
    param (
        $Wordlist
    )

    Get-Content $Wordlist | ForEach-Object {
        $name, $surname = $_.split(";")
        Create-SpecificADUser -Name $name -Surname $surname
    }
}

function Remove-UsersFromWordlist {
    param (
        $Wordlist
    )

    Get-Content $Wordlist | ForEach-Object {
        $name, $surname = $_.split(";")
        Remove-SpecificADUser -Name $name -Surname $surname
    }
}

function Remove-AllADUsers {
    $filter = "name -notlike 'Administrator' -and name -notlike 'krbtgt' -and name -notlike 'Guest'"
    Get-Aduser -Filter $filter | ForEach-Object {
        Remove-ADUser -Identity $_.SamAccountName -Confirm:$false
    }
}