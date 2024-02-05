# ![Logo](https://github.com/EthernalStar/ClipeXec/blob/main/Icon.png?raw=true) ClipeXec

**ClipeXec** is a Tool wich executes given Command once the content of the Clipboard changes.  
It incorporates the Clipboard Text content directly to the command.  
The Tool was tested with Windows 10 but should also work with Windows 11.  
  

## Documentation

**Please Read the Instructions with care to avoid breaking something**  
**<span style="color:red">This Tool will execute any Command and makes the Contents of the Clipboard Part of this.</span>.**  
**<span style="color:red">Please be aware that there are many Ways to use this incorrectly.</span>.**  
  
**Also the Tool may be flagged as a false positive by your System.**
**If you are still unsure please check and compile the Source Code yourself or try it in a VM first!**  
  
If you want to hide the Application Window just click the Tray-Icon on the Taskbar.  
  
### Main Page

![Main Page Screenshot](https://github.com/EthernalStar/ClipeXec/blob/main/Images/ClipeXec%2001.png?raw=true)  

The **Color** Box allows you to pick a preconfigured color for the Overlay by clicking the different Boxes.  
You could also set a **custom Color** by clicking the Button and choosing one with the Color Picker.  
The Button **Set Random Color** just sets a random choosen Color for the Overlay.  
  
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

GNU General Public License v3.0. See [LICENSE](https://github.com/EthernalStar/ClipeXec/blob/main/LICENSE) for further Information.
