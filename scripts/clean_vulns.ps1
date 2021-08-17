function Remove-KerberosPreAuthentication {
    Get-ADUser | ForEach-Object {
        if ($_.DoesNotRequirePreAuth -eq "True" -and $_.Enabled -eq "True") {
            Get-ADUser -Identity $_.SamAccountName | Set-ADAccountControl -DoesNotRequirePreAuth:$false
        }
    }
}