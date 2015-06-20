# get_tvrain

WARNING! This project is very much a work in progress. Please come later :-)
```
Usage:
  get_tvrain [-h|--long-help] [-v] [-F] [-c <merge|save|pls>] [-q <hd|sd|lo>] 
             [-d <output dir>] [-o <output file name>] [-t <temp dir>] 
             [-i] [-y] [-C <config file>] <Video ID | Page with video URL> 

TVRain.ru show archive command line client. Legitimate paying users only! 

To download a show in current directory run: 
  get_tvrain http://tvrain.ru/teleshow/reportazh/the_rain_is_falling-123456/

To get detailed options description run: 
  get_tvrain --long-help

Options:
  -h Show usage and exit
  -v Verbose output, prints a lot of debugging stuff to STDERR
  -F Force first run, resets all options, see below
  -c Command, instructs get_tvrain what to do:
       merge - downloads all parts of the video and merges them into one 
               matroska file, requires temp directory for downloaded parts, 
               this is the default command
       save  - saves each part of the video as is
       pls   - does not download any video, saves a playlist with video URLs
  -q Video quality selector, available options are:
       hd - high definition aka 720p (default)
       sd - standard definition aka 480p
       lo - low bitrate aka 360p
  -d Write output file(s) to the specified directory, defaults to current 
     directory
  -o Set output file(s) name, if omitted the article / feature name is used 
     to compose the file name(s); overrides -d and -i
  -t Use specified directory to temporarily store downloaded video parts for 
     the "merge" command, if omitted looks up temp_dir in the configuration 
     file, which defaults to the current directory
  -i Use video ID for the file(s) name
  -y Override output file(s) in case of naming conflict, if not specified 
     file name(s) will be changed to avoid overwriting
  -C Use specified configuration file instead of the default one

Examples:
  Download a show by URL, if video consists of several parts merge them 
  together. Use /tmp to store temporary files.
  get_tvrain -t /tmp http://tvrain.ru/teleshow/reportazh/falling_rain-123456/

  Download a show known by its ID to the Desktop. Select low bitrate to 
  preserve the bandwidth. If there are several video files save them 
  separately. Name files using show ID.
  get_tvrain -d ~/Desktop -q lo -c save -i 123456

  Create a custom-named playlist of the standard definition videos. If a 
  playlist by the same name already exists overwrite it.
  get_tvrain -q sd -o /mnt/autoplay/tvrain.pls -c pls -y 123456

Configuration file:
  The configuration file is .get_tvrain.conf in your home directory, This file 
  is created automatically during the first run. Use -C option to run with 
  alternative configuration file. File format is name=value, no whitespaces 
  around the "=", no comments after the value are allowed. Encoding is UTF-8.
  Noteworthy options:
    device_uid
      Client-side hardware unique identifier / serial number. In fact this 
      value is randomly generated during the first run.
    auth
      Authentication key. This value is obtained from the server when the 
      client is linked to TVRain.ru user account as a part of the first run 
      routine.
    temp_dir
      The directory to temporarily store downloaded video parts for the 
      "merge" command. Please make sure the directory is on a reasonably fast 
      storage device (ie the use of thumb drives and flash cards is 
      discouraged) and that it has enough free space (4Gb would do). If not 
      set the current directory or the value passed with the -t option is 
      used.

First run:
  When run for the first time the "first run routine" is invoked to configure 
  the application. It does as follows:
    1. configuration file is created
    2. unique identifier is randomly generated
    3. client is linked to the TVRain.ru user account
    4. temporary directory is set
  To clear all the settings the first run routine can be re-run manually 
  by specifying the -F option or just by deleting the configuration file.

Linking:
  In order to gain access to the TVRain.ru show archive the client software 
  should be "linked" to an active paid user account. Linking happens during 
  the first run and requires internet access and user interaction.

```