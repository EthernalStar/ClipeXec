# ![Logo](./Icon.png?raw=true) ClipeXec

**ClipeXec** is a Tool wich executes given Command once the content of the Clipboard changes.  
It incorporates the Clipboard Text content directly to the command.  
The Tool was tested with Windows 10 but should also work with Windows 11.  
  

## Documentation

**Please Read the Instructions with care to avoid breaking something**  
**<span style="color:red">This Tool will execute any Command and makes the Contents of the Clipboard Part of this.</span>**  
**<span style="color:red">Please be aware that there are many Ways to use this incorrectly.</span>**  
  
**Also the Tool may be flagged as a false positive by your System.**
**If you are still unsure please check and compile the Source Code yourself or try it in a VM first!**  
  
If you want to hide the Application Window just click the Tray-Icon on the Taskbar.  
  
### Main Page

![Main Page Screenshot](./Images/ClipeXec%2001.png?raw=true)  

Before you do anything you will need to set your Command in the two Edit Boxes at the bottom.  
The (String) Lebel stands for the Textstring inside the Clipboard wich will be combined with the Commands.  
**Please be aware that the Prefix, (String) and Suffix will be appended directly without Spaces.**  
The first Edit Box will be appended before the (String) like so: "Something.exe " + (String) (Don't forget the Space!).  
The second Edit Box will be appended after the (String) like so: (String) + " >> File.txt" (Don't forget the Space!).  
  
By default the Working directory will be your Desktop but this can be changed with the **Set Working Directory** Button.  
Any Applications or Scripts called by this Application should be in the current Working Directory or PATH.  
  
To start the execution of the Commands everytime the Clipboard changes to need to Toggle the **Cler Clipboard and start** Button.  
To stop just press the Button again. **This will NOT cancel any running Scripts or Status Updates.**  
The three Checkboxes on the right are for different Options:  
**Show CLI** toggles the visibility of the CMD shell Window for every Command.  
**Use Pipes** toggles an Internal state for Pipe Usage of the Execution Logic.  
Rule of Thumb: More Output on CLI -> Disable Pipes (May impact Status Reporting) or use silent/quiet Flags.  
**Topmost** just toggles the Topmost Status of the Window.  
  
After execution a command the Clipboard Content will be added to the White ListBox and either be colored green on exit code 0 or red otherwise.  
**If the Script is hanging/waiting on input or in an endless loop nothing will be reported. Please optimize your Scripts/Commands before!**  

On the top right corner the amount of processes Clipboard contents is shown.  
There are 4 Symbols next to the ListBox on the right Side:  
The **Red X** is used to clear the currently selected Entry in the ListBox.  
The **Symbol below the Red X** clears the ListBox completely.  
The **Green Arrow** can be used to export the Contents of the ListBox to a Textfile.  
The **Purple Arrow** can be used to import a Textfile to be displayed in the ListBox.  

The **Changelog** and **License** Buttons show you the current Changelog and License of the Application.  

  
## Use Cases

Here are some situations where I use this Tool:  

Downloading Image Galleries by just copying the URL with [gallery-dl](https://github.com/mikf/gallery-dl) e.g: gallery-dl + (String).  

Downloading Web Videos by just copying the URL with [yt-dlp](https://github.com/yt-dlp/yt-dlp) e.g: yt-dlp + (String).  

Automaticaly add Clipboard Text as Lines to a Textfile. e.g: echo + (String) + >> File.txt.

Using Bash Scripts for Web Scraping by Utilizing WSL and Bash in Windows e.g: bash -c "./script.sh " + (String) + "".  
  

## Building

There should not be any Problem building the Application because it does not rely on any external installed Packages.  
To build the Project you need to have the Lazarus IDE Version 2.2.6 installed and clone this Repository to yor local Machine.  
Now just open the .lpr file in your Lazarus Installation and you should be able to edit and compile the Project.  
  

## Issues

Some Script/Command combinations will freeze or report a wrong exit status.  
To fix this you will need to uncheck the "Use Piepes" Setting. This may cause other Commands to not be recognized correctly.  
Also you should use all available quiet/silent flags in your Scripts/Commands to reduce output, wich increases success rates.  
  

## Planned Features

Currently there are no planned Features.  
  

## Changelog

Version 1.0.0: Initial Release.  
  

## License

GNU General Public License v3.0. See [LICENSE](./LICENSE) for further Information.
