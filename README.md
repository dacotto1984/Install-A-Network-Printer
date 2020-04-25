# Install a network printer

Quicky install a network printer.

<h3><b>Modify</b></h3>
Give the printer a name, provide the printers IP Address and assign a printer driver to it.

Modify the script and change the following properties:


```powershell
        $printerName = "2nd Floor Printer"
        $printerIP = '192.168.1.100'
        $printerDriver = 'HP Universal Printing PCL 6 (v6.6.0)'
```

<h3><b>Usage</b></h3>

```
    C:> .\Install-Printer.ps1

    Installing 2nd Floor Printer...

    Printer Installation Complete!

    Would you like to do a print test? (Y/N)

    y

    Print Job Sent!
```
