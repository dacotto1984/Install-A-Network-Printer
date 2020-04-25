        $printerName = "2nd Floor Printer"
        $printerIP = '192.168.1.100'
        $printerDriver = 'HP Universal Printing PCL 6 (v6.6.0)'


        $winVersion = (Get-CimInstance -ClassName Win32_OperatingSystem).caption
        $printerExists = Get-Printer -Name $printerName -ErrorAction SilentlyContinue
        $printerPortExists = Get-PrinterPort -Name $printerIP -ErrorAction SilentlyContinue
        $printerDriverExists = Get-PrinterDriver -Name $printerDriver -ErrorAction SilentlyContinue
        
        if ($winVersion -ilike "* Windows 10 *") {

            if($printerExists) {

                Write-Host -ForegroundColor Yellow "Printer is already installed!"
                Read-Host -Prompt "Press Enter to exit"

            } else {
                    Write-Host -ForegroundColor Green "Installing $printerName..."

                    if (-not($printerPortExists)){
                        Add-PrinterPort -Name $printerIP -PrinterHostAddress $printerIP -ErrorAction SilentlyContinue
                    }
                    if (-not($printerDriverExists)) {
                        Add-PrinterDriver -Name $printerDriver -ErrorAction SilentlyContinue
                    }
                    if (-not($printerExists)) {
                        Add-Printer -Name $printerName -DriverName $printerDriver -PortName $printerIP -ErrorAction SilentlyContinue
                    }

                    try {
                        (New-Object -ComObject WScript.Network).SetDefaultPrinter($printerName)

                        } catch {
                            Write-Host -ForegroundColor Red "Error, Couldnt set printer as default"
                            exit
                        }

                    Write-Host -ForegroundColor Green "Printer Installation Complete!"

                    $printTest = Read-Host -Prompt "Would you like to do a print test? (Y/N)"

                    if($printTest -ieq "y") {
                        hostname > "$PSScriptRoot\printme.txt" 
                        (Get-WmiObject -Class Win32_ComputerSystem).model >> "$PSScriptRoot\printme.txt"
                        (Get-WmiObject -Class win32_bios).SerialNumber >> "$PSScriptRoot\printme.txt"
                        Get-Content "$PSScriptRoot\printme.txt" | Out-Printer -Name $printerName
                        Write-Host -ForegroundColor Green "Print Job Sent!"
                    }

                    Read-Host -Prompt "Press Enter to exit"

            } 
        } elseif ($winVersion -ilike "* Windows 7 *") {
            Write-Host -ForegroundColor Red "windows 7 printer installation not set up - need to code/program for windows 7"
            Read-Host -Prompt "Press ENTER to continue"
        } else {
            Write-Host -ForegroundColor Red "Installation not supported in this version of windows.  please call developer to upgrade"
            Read-Host -Prompt "Press ENTER to continue"

        }