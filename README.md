# win1X-bootable-usb
Shell tool for creating a Windows (10, 11) bootable USB from a shell terminal.

## Use case
While Microsoft provides a tool for creating bootable USB sticks, it is not compatible with UNIX machines (Mac, Linux distros...). I have found alternative tooling to be insufficient or, at least, I have not been able to make them work correctly. Bootable USB drives need to meet some requirements that are often obscure for many users:

- A bootable USB drive must be formatted as FAT32
- ExFAT is not FAT32: do not use ExFAT
- FAT32 limits file size to a maximum of 4GB
- The Windows 10/11 installer `install.wim` is sized 5GB+ and will fail to copy on FAT32

This tool splits `install.wim` into <4GB files and copies the filesystem to the USB drive, making it bootable from the EFI file as usual.

## Prerequisites

Download `wimlib`

MacOS
```
brew install wimlib
```

Linux
```
sudo apt install wimlib
```

Download your Windows 10/11 ISO file from the official Microsoft website
- [Windows 11](https://www.microsoft.com/es-es/software-download/windows11)
- [Windows 10](https://www.microsoft.com/es-es/software-download/windows10)

Mount the ISO file in your system. For this, double-click the ISO file and check that you see a mount point with a name similar to `CCCOMA_X64FRE_EN-US_DV9`. 

Plug in your USB drive, which should have at least 8GB of free space, and format it in FAT32.

- [MacOS](https://www.crucial.com/support/articles-faq-ssd/formatting-usb-storage-drive-macos)
- [Linux](https://phoenixnap.com/kb/linux-format-usb)

## Using this script

Download or copy this script. Remember to `chmod +x create_win_usb.sh` to make it executable from a terminal.

Use your preferred text editor (gedit, vim, nano...) to change the following parameters:
- `ISO_VOL`: Full path to your mounted ISO volume. MacOS example: "/Volumes/CCOMA_X64FRE_EN-US_DV9"
- `USB_VOL`: Full path to your formatted USB drive. MacOS example: "/Volumes/WIN_USB_STICK"
- `TMP_DIR`: Full path to the temporary directory that will be used to split the file locally. Use anything with at least 5-10GB of free space, such as your `HOME` dir or `/tmp/winusb`.

When these parameters are set up, just run the script normally via Terminal
```
./create_win_usb.sh
```

Be patient, as the script **will take a while** to be fully executed. During the process, you will find the following error:
```
cp: /Volumes/WIN/sources/install.wim: fcopyfile failed: File too large
```
This is perfectly normal as it will attempt to copy `install.wim` to a FAT32 formatted drive. The script will take care of its removal and copy the split version.
