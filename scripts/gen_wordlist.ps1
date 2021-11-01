function Create-FullNamesWordlist {
    param (
        $NamesWordlist,
        $SurnamesWordlist,
        $OuputFile
    )

    Clear-Content $OuputFile

    $names = Get-Content $NamesWordlist
    $surnames = Get-Content $SurnamesWordlist
    
    for ($i = 0; $i -lt 1000; $i++) {
        $names_index = Get-Random -Minimum 0 -Maximum $names.Length
        $surnames_index = Get-Random -Minimum 0 -Maximum $surnames.Length

        $name = $names[$names_index]
        $surname = $surnames[$surnames_index]
        $full_name = [string]::Format("{0};{1}", $name, $surname)
        
        Add-Content -Path $OuputFile -Value $full_name
    }
}
