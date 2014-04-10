#*****************************************************************
#
#  Script Name: GameConsole.ps1 (The PowerShell Game Console)
#  Version: 1.0
#  Author: Joseph Preston
#  Date: April 9, 2014
#
#  Description: This PowerShell script provides a listing of 
#               PowerShell game scripts and allows the player to 
#               play any game by entering its menu number.
#
#  Updates:  
#
#*****************************************************************

# Initialization Section

$menuList = @()      # Stores an array containing information abou the script games
$playAgain = "True"  # Controls the execution of the loop that manages the game execution

# Functions and Filter Section

# This function gets the player's permission to begin the game
function Get-GameListing {
    $gameList = @()  # Stores an array containing a list of PowerShell scripts
    $i = 0           # Used to set the index value of the array when adding elements to it
    
    cls              # Clear screen
    write-host       # Display a game console header
    write-host " -----------------------------------------------------------"
    write-host " Windows PowerShell Game Console" -foregroundColor darkRed
    write-host " -----------------------------------------------------------"
    
    Set-Location C:\MyScripts  # Specify the location of the game scripts
    
    #Load an array with a list of all the PowerShell scripts in the specified folder
    $gameList = get-childitem . *.ps1  # Populates the game list
    $gameList  # Return the contents of the array to the calling statement
}

# This function displays a menu listing of PowerShell games
function Write-MenuList {
    param($list)  # The list of games to be displayed is passed as an array
    $counter = 0  # Used to number each menu item
    
    write-host ""
    
    foreach ($i in $list) {  # Iterate for each script stored in the array
        $counter++           # Increment the counter by 1
        
        if ($counter -lt 10) {# Format the display of the first 9 scripts
            write-host " $counter.  $i" -foregroundColor blue
        }
        else {               # Format the display of all remaining scripts
            write-host " $counter.  $i" -foregroundColor blue
        }
    }
    write-host "`n---------------------------------------------------------"
}

# This function ends the script execution
function End-ScriptExecution {
    cls
    write-host "`n Thank you for using the Windows PowerShell Game Console"
    start-sleep 3
    cls
}

# Main Processing Section
$response = 0 # Stores player input

# Continue playing new games until the player decides to close the game console
while ($playAgain -eq "True") {
    # Call the function that generates an array containing a list of the game scripts
    $menuList = Get-GameListing
    
    # Call the function that converts the contents of the array into a list
    Write-MenuList $menuList
    
    # Prompt the player to pick a game to play
    $response = read-host "`n Enter the menu number or name for a game or Q to quit"
    
    # Prepare to close the game console when the user decides to quit
    if ($response -eq "Q") {
        $playAgain = "False"  # Modify variable to halt loop
        continue  # Repeat loop
    } 
    
    if ($response -match '[A-Za-z]') {
        foreach ($i in $gameList) {
            
        }
    }
    
    # Convert player's input into an integer and then validate the player's input
    if ([int]$response -lt 1) {
        cls
        write-host "`n `a`aInvalid Selection."
        read-host
        continue
    }
    
    if ([int]$response -gt $menuList.length) {
        cls
        write-host "`n `a`aInvalid Selection."
        read-host
        continue
    }
    
    
    
    # Format a string representing the command  that will execute the script selected by the user
    $game = "./" + $menuList[$response -1]
    invoke-expression $game
    cls
}
