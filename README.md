[![Build status](https://ci.appveyor.com/api/projects/status/8hdd15yfsh8r3ww7?svg=true)](https://ci.appveyor.com/project/UziTech/atom-url-handler)

# Windows Atom URL Handler

atm:// URL handler for Atom editor on Windows

Here are the [OSX](https://github.com/WizardOfOgz/atom-handler) and [Linux](https://github.com/eclemens/atom-url-handler) versions

# Installation

> ### 🚨 **WARNING** 🚨
>
> This edits the Windows registry. We recommend that you [create a restore point](https://support.microsoft.com/en-us/help/322756/how-to-back-up-and-restore-the-registry-in-windows) before continuing.

  1. Download and extract the [ZIP](https://github.com/UziTech/atom-url-handler/archive/master.zip)
  2. Execute install.bat (You may provide the protocol as the first parameter to skip step 3)
  3. Choose a protocol (default is atm)
  4. Click links that start with atm:// (or the protocol you chose) to open in atom 🎉

#### Note:

`atom-url-handler.bat` will be copied to `%LOCALAPPDATA%` so you can delete the folder that was extracted after install.

# URL Examples

The following URLs will work

```
atm://open?url=file://C:\path\to\file.ext
atm://open?url=file://C:\path\to\file.ext&line=10
atm://open?url=file://C:\path\to\file.ext:10
atm://open?url=file://C:\path\to\file.ext&line=10&col=2
atm://open?url=file://C:\path\to\file.ext&line=10&column=2
atm://open?url=file://C:\path\to\file.ext:10:2
atm://open?url=file://C:\path+to\file.ext:10:2
atm://open?url=file%3A%2F%2FC%3A%5Cpath%20to%5Cfile.ext&line=10&col=2
```

# Common Protocols

`atm://` is usually used for opening files into atom but some other common protocols are `subl://`, `sublime://`, and `txmt://`

Atom URL Handler can work with any URL following the [TextMate URL scheme](http://blog.macromates.com/2007/the-textmate-url-scheme/) with whichever protocols you choose during installation.
