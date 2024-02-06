# ![Logo](./Icon.png?raw=true) ClipeXec

**ClipeXec** is a Tool wich executes given Command once the content of the Clipboard changes.

It incorporates the Clipboard Text content directly to the Command.

The Tool was tested with Windows 10 but should also work with Windows 11.


## Documentation

**Please Read the Instructions with care to avoid breaking something as this Tool will execute any Command and makes the Contents of the Clipboard Part of this.**
**Please be aware that there are many Ways to use this incorrectly.**

**Also the Tool may be flagged as a false positive by your System.**

**If you are still unsure please check and compile the Source Code yourself or try it in a VM first!**

If you want to hide the Application Window just click on the Tray-Icon on the Taskbar.

### Main Page

![Main Page Screenshot](./Images/ClipeXec%2001.png?raw=true)

Before you do anything you will need to set your Command in the two Edit Boxes at the bottom.  
The (String) Label stands for the Clipboard Text wich will be combined with the Commands.

**Please be aware that the Prefix, (String) and Suffix will be appended directly without Spaces.**

The first Edit Box will be appended before the (String) like so: "Something.exe " + (String) (**Don't forget the Space!**).  
The second Edit Box will be appended after the (String) like so: (String) + " >> File.txt" (**Don't forget the Space!**).

The default Working Directory will be your **Desktop** but can be changed with the **Set Working Directory** Button.
Any Application or Script called by ClipeXec should be in the current Working Directory or your PATH variable.

To start the execution of the Commands everytime the Clipboard changes to need to Toggle the **Clear Clipboard and start** Button.
To stop just press the Button again. **This will NOT cancel any running Scripts or Status Updates.**

The Checkboxes on the right are for different Options:
1. **Show CLI** toggles the visibility of the CMD shell Window for every Command.
2. **Use Pipes** verbose Output on CLI -> Disable Pipes (May impact Status Reporting) or use silent/quiet Flags.
3. **Topmost** just toggles the Topmost Status of the Window.
4. **Auto Clear Clipboard** clears the Clipboars the moment the command was send to be executed (As of v1.0.1).
5. **Command Confirmation** displays a confirmation Messagebox every time a command will be executed (As of v1.0.1).  

You will also see a Display Label named **Currently Running:** introduced in v1.0.1 wich displays the Amount of Tasks currently still running.
If there are any Tasks still running and you try to close the Application it first will ask for confirmation.

After execution a command the Clipboard Content will be added to the White ListBox and either be colored green on exit code 0 or red otherwise.
As of v1.0.1 you can also double click an Entry in the ListBox to copy it. **This will execute the command again if not disabled before!**
**If the Script is hanging/waiting on input or in an endless loop nothing will be reported. Please optimize your Scripts/Commands before!**

On the top right corner the amount of processes Clipboard contents is shown.  
There are 4 Symbols next to the ListBox on the right Side:

1. The **Red X** is used to clear the currently selected Entry in the ListBox.
2. The **Symbol below the Red X** clears the ListBox completely.
3. The **Green Arrow** can be used to export the Contents of the ListBox to a Textfile.
4. The **Purple Arrow** can be used to import a Textfile to be displayed in the ListBox.

### About Page

![About Page Screenshot](./Images/ClipeXec%2002.png?raw=true)

By clicking the large Icon on the Left you will be introduced to the About Page where useful Information about the **License** or recent **Changelog** can be found.
There are also links to my Repositories on Github or Codeberg where you could always find the latest Version.
If you have questions please don't hesitate to contact me over [E-Mail](mailto:NZSoft@Protonmail.com) or create an Issue on the Project Page.

## Use Cases

Here are some situations where I use this Tool:

* Downloading Image Galleries by just copying the URL with [gallery-dl](https://github.com/mikf/gallery-dl).
* Downloading Web Videos by just copying the URL with [yt-dlp](https://github.com/yt-dlp/yt-dlp).
* Automaticaly add Clipboard Text as Lines to a Textfile.
* Using Bash Scripts for Web Scraping by Utilizing WSL and Bash in Windows.

## Building

There shouldn't be any Problem building the Application because it doesn't rely on any external installed Packages.
To build the Project you need to have the [Lazarus IDE](https://www.lazarus-ide.org/) Version 2.2.6 installed.
After you have downloaded the Source Code or cloned this Repo just open the Project in your Lazarus Installation.
To do this just open the .lpr file and you should be able to edit and compile the Project.

## Issues

* Some Script/Command combinations will freeze or report a wrong exit status.
To fix this you will need to uncheck the "Use Pipes" Setting. This may cause other Commands to not be recognized correctly.
Also you should use all available quiet/silent flags in your Scripts/Commands to reduce CLI output, wich increases success rates.

## Planned Features

* Currently there are no planned Features.

## Changelog

* Version 1.0.0:
  * Initial Release.  
* Version 1.0.1:
  * Added horizontal ScrollBar for large commands.
  * Added Copy Feature for single Clipboard Entries.
  * Added CMD Display Option with Confirmation upon Execution.
  * Added Clear Option for Clipboard after Execution.
  * Added About Page to display additional Information.
  * Added Display for amount of still running Tasks.
  * Added Confirmation Dialog for closing if Tasks are still running.
  * Added many visual Improvements to the GUI.

## License

* GNU General Public License v3.0. See [LICENSE](./LICENSE) for further Information.