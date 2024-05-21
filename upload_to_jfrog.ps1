# may need to run on the windows powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
try {
        $username="jkorrapati"
        $api_token="apikey"
        $credential_bytes=[System.Text.Encoding]::UTF8.GetBytes($username + ":" + $api_token)
        $credentials=[System.Convert]::ToBase64String($credential_bytes)
        $credential_header = "Basic " + $credentials
        $artifactory_dest_url = "https://koderse.jfrog.io/artifactory/terraform-terraform/files/"

        # get all the filenames in a folder.
        $fileNames = Get-ChildItem -Path '.\' -File
        foreach ($item in $fileNames)
            {
              # if the item is a directory, then process it.
              Write-Output $item.Name
              Start-Sleep -Seconds 2
              #upload to artifactory
              $fileName=$item.Name
              Invoke-RestMethod -Uri $artifactory_dest_url$fileName  -Method Put -InFile "mytext1.zip" -Headers @{ Authorization ="$credential_header"}
             }
}
catch [System.Net.WebException],[System.IO.IOException] {
  "Unable to upload to jfrog repository"

}
catch {
    "An error occurred that could not be resolved."
}
