# get_tvrain
```
TVRain.ru show archive command line client. Legitimate paying users only!

Usage:
  get_tvrain [-h|--long-help] 
  [-c <interactive|merge|save|pls|info|programs|articles>] [-q <fhd|hd|sd|lo>]
  [-d <output dir>] [-o <output file name>] [-t <temp dir>] [-i] 
  [-C <config file>] [-I <max items>] [-v] [-F] [-S]
  <Show ID | Page with video URL | Program ID>

To download a show in current directory:
  get_tvrain http://tvrain.ru/teleshow/reportazh/the_rain_is_falling-123456/

To get detailed options description:
  get_tvrain --long-help

Options:
  -h Show usage and exit
  -c Command, instructs get_tvrain what to do
       Downloading videos:
       n|interactive - displays article info, suggests the most appropriate 
                       command to downlad the video(s) and waits for the user
                       decision and if it does not come within reasonable time
                       (see -W) it goes on to execute the suggested command, 
                       this is the default command
       m|merge       - downloads all parts of the video and merges them into
                       one matroska file, requires temp directory for
                       downloaded parts
       s|save        - saves each part of the video as is
       Retreiving information (no videos downloaded):
       p|pls         - saves a playlist with video URLs
       i|info        - prints out video informaton
       r|programs    - saves full list of available programs as a text file
       a|articles    - saves list of articles by a program ID as a text file;
                       see -I for max number of items
  -q Video quality selector, available options are:
       f|fhd - full HD aka 1080p
       h|hd  - high definition aka 720p (default)
       s|sd  - standard definition aka 480p
       l|lo  - low bitrate aka 360p
  -d Write output file(s) to the specified directory, defaults to current
     directory
  -o Set output file(s) name, if omitted the article / feature name is used
     to compose the file name(s); overrides -d and -i
  -t Use specified directory to temporarily store downloaded video parts for
     the "merge" command, if omitted looks up temp_dir in the configuration
     file, which defaults to the current directory
  -i Use show (or program) ID for the file(s) name; has no effect with 
     "programs" command
  -W The ammount of time in seconds to wait for a user input executing the 
     "interactice" command; if set to 0 procedes to execute suggested 
     command right away (good for use in scripts)
  -C Use specified configuration file instead of the default one
  -I Max number of items retrieved from the server; applies to the articles
     command; if ommited defaults to a reasonable number
  -v Verbose output, prints a lot of debugging stuff to STDERR
  -F Force first run, resets all options, see below
  -S Simulate, do not actualy download anything

Examples:
  Print out article information and exit.
  get_tvrain -c i /tmp http://tvrain.ru/teleshow/program/article-123456/

  Download a show without user interaction with "save" command if it has one 
  segment or with "merge" command if there are two or more segments.
  get_tvrain -W 0 /tmp http://tvrain.ru/teleshow/program/article-123456/

  Download a show by URL, if video consists of several parts merge them
  together. Use /tmp to store temporary files.
  get_tvrain -t /tmp http://tvrain.ru/teleshow/program/article-123456/

  Download a show known by its ID to the Desktop. Select low bitrate to
  preserve the bandwidth. If there are several video files save them
  separately. Name files using show ID.
  get_tvrain -d ~/Desktop -q lo -c save -i 123456

  Create a custom-named playlist of the standard definition videos. If a
  playlist by the same name already exists overwrite it.
  get_tvrain -q sd -o /mnt/autoplay/tvrain.pls -c pls -y 123456

  Save a full list of the TVRain programs to a text file named program.txt in 
  the /tmp directory. Note: this might take a while.
  get_tvrain -c r -d /tmp

  Save the list of 23 latest articles of the program identified by program ID 
  "1234" to a text file in the current directory. You can use "programs" 
  command to get full list of programs with their IDs.
  get_tvrain -c r -I 23 1234

Requirements:
  A few perl modules off CPAN are required. If they are missing the program
  will let you know which modules it lacks and suggest a way to install them.
  Also wget is used to download stuff and either mkvmerge or ffmpeg for
  joining video fragments.

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
      The directory to temporarily store downloaded video segments for the
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