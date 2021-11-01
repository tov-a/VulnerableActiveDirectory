function Get-KerberosPreAuthUsers {
    get-aduser -filter * -properties DoesNotRequirePreAuth | Where-Object {
        $_.DoesNotRequirePreAuth -eq "True" -and $_.Enabled -eq "True"
    }
}
