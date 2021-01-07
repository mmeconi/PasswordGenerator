<#
    .SYNOPSIS
        Random password generator for users.
    .DESCRIPTION
        This program looks for a user list; if the list exists, it creates a password for each user based on the formula
        of 3 lowercase letters, 2 uppercase letters. 2 numbers, and 1 special character. It creates as many passwords
        as there as users via a "For Loop" and stores them in an array. It then randomizes each password via a "Foreach Loop"
        so as to remove consistency in password composition. User names and passwords are ultimately paired in a hash table
        using a "for loop".
    .NOTES
        AuthorName: Marc Meconi
        DateLastModified: November 23, 2020
 #>

Set-StrictMode -version latest

# Declared variables
$FilePath = "$home\documents\Lab5_users.txt"
$Passwords = @()

# Testing if a user file exists; if not it exits
$TestResult = test-path -path $FilePath
if ($TestResult -ne "True"){
    Write-Host "File Not Found"
    Pause
    Exit
    }

$Users = Get-Content $FilePath

# For Loop selects characters from each array and adds them to a variable, which are then joined to form a password and added to an array
for ($i=0; $i -lt $users.count; $i++){
$lowercase = @("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
$uppercase = @("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")
$numbers = @("1","2","3","4","5","6","7","8","9","0")
$specialchar = @("!","@","#","$","%","^","&","*","+","?")

$password = $lowercase | Get-Random -count 3
$password += $uppercase | Get-Random -count 2
$password += $numbers | Get-Random -count 2
$password += $specialchar | Get-Random -count 1

$PasswordString = $password -join ""
$Passwords += $PasswordString
}

# This ForEach loop randomizes each password by creating a character array, randomizing, then rejoining
$outstring = foreach($pass in $passwords){
    $inputString = $pass.ToString().ToCharArray()
    $scrambled = $inputString | Get-Random -count $inputString.count
    $scrambled -join ""
}

$UserCredentials = @{}

# For Loop pairs users and passwords
for ($i=0; $i -lt $users.count; $i++){
   $UserCredentials.Add($Users[$i],$outstring[$i])
}

$UserCredentials