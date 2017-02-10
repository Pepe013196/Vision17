Fabian Enrique Martinez Solano 201314566

Juan Felipe Perez Correa


#Laboratorio 1 - Visión por Computador

##Answers

1. ``Grep`` command: This command searches the named input files for lines containing a match to the given pattern. Also, this prints the matching lines in the command line.

2. Option ``-prune``: The command Find is used to search and locate list of files and directories based on conditions that the user specify for files that match the arguments. With this command is possible find files by permissions, users, type, etc. The option –prune excludes the directories that are named.

  Example: 

  To see the difference between the use and the non-use of the command, the following lines of code are made:
  ```
  a)	find texture ./sipi_images
  ```
  ```
  b)	find texture ./sipi_images –prune –o –print 
  ```
  The textured file is only in the “sipi_images” directory, and when the user excludes with the command -prune, the result of the search is: ``file or directory does not exist``.

3. ``cut`` command: Is used for text processing. Cut is a command used to extract sections from each line of input, usually from a file. This command has different options, for example bytes, characters, delimiter, fiels, etc, that restrict the zone to cut.
4. ``rsync`` command: I0s the abbreviate of Remote Sync. This command is used for copying and syncghronizing files and directories remotely as well as locally in Linux sistems. It can copy locally, to/from another host over any remote shell, or to/from a remote rsync daemon. This command offers a large number of options that control every aspect of its behavior and permit very flexible specification of the set of files to be copied.

5. ``diff`` command: This command analyzes two files and prints the lines that are different between this files. In addition, the command prints a set of instructions for how to change one file in order to make it identical to the second file; this instructions are numbers (identify the line of the files) and letters (a for add, c for change or d to delete). The command does not change the content of any file.

6. ``tail`` command: Tail is a command which prints the last few number of lines of a certain file then terminates. The number of lines can be specify by the user, but by default prints 10 lines.

7. ``tail -f`` command: Unlike the default behavior which is to end after printing certain number of lines, the -f option “which stands for follow” will keep the stream going. It will start printing extra lines on to console added to the file after it is opened. This command will keep the file open to display updated changes to console until the user breaks the command.

8. ``link`` command: The link command creates a hard link named FILE2 which shares the same index node as the existing file FILE1. Since FILE1 and FILE2 share the same index node, they will point to the same data on the disk, and modifying one will be functionally the same as modifying the other. This command is different to ``ln``, command that creates a link, or a symbolic link, to a file or directory.

  Any changes that occurred with either of these files would affect the other file or link.

9. ``#! /bin/bash``: In Linux system, we have shell which interprets our UNIX commands. Now there are a number of shell in Unix system. The default shell in Linux called bash. When you write a script (collection of unix commands and so on) you have a option to specify which shell it can be used. Generally you can specify which shell it wold be by using Shebang.

  So if you write ``#!/bin/bash`` in the top of your scripts, you are telling your system to use bash as a default shell.

10. Users: The information of the users on linux is on the /etc/passwd file. This file contains one line for each user account, with seven fields delimited by colons.  Due to this characteristic, is possible use wc –l, that is a command that counts the number of lines in a file, printing the number of users on the server
  ```
  wc -l /etc/passwd
  ```
  
  The command prints in the console
  
  ```
  39 /etc/paswd
  ```

11. Command that produce a table of Users and Shells:

  From the previous point it is known that the user information is in the file /etc/passwd. More in detail, it is observed that the information is presented separately by “:”, and that the descriptions that we need at this point are in column 1 (name) and 7 (shell).  
  Using this feature you can use the cut command, with the following options:

  -d: Delimitier between the fields

  -f: Extract specific fields.

  After this procedure, the next step is sort by shell. The shell is in the second column, so it is necessary to use the -k 2 option, and the -t option that specifies the character that separates the fields. Finally, the command is
  ```
  cut -f 1,7 -d ':' /etc/passwd | sort -k2 -t ':'
  ```
12. Find duplicates [16]

  ```
  find -type f -exec md5sum '{}' ';' | sort | uniq --all-repeated=separate -w 15
  ```
13. Download the bsds500 image segmentation database and decompress it (keep it in you hard drive, we will come back over this data in a few weeks).

  For this, we searched the link of the BSDS500 on Internet, and we put the next command on the terminal:

  ```
  wget http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/BSR/BSR_bsds500.tgz

  ```

  After that, we proceeded to decompress the downloaded file with the command:

  ```
  tar -xzvf BSR_bsds500.tgz
  ```

 14. What is the disk size of the uncompressed dataset, How many images are in the directory 'BSR/BSDS500/data/images'?

  We used the command:

  ```
  ls -l | grep .tgz
  ```

  To know the size of the files inside the current folder. The size of the uncompressed dataset is 70763455 bytes. We can see the size of the file in the 5th column of the output.

  To know the number of images in the current directory and all its folders inside it, we used the command:

  ```
  $find . -type f -exec file {} \; | grep -c -i 'image'
  ```
  The number of images within the directory is 500 images.

  15. What is their resolution, what is their format?

  To find the format we use the command:

  ```
  find . -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image'
  ```
  The output is the format of the image files, and it is JPEG for all images inside the folder.

  To see the resolution we use the command:

  ```
  identify -size *.*
  ```
  The 3rd column od the output gives the resolution of the images. We can see that their resolutions are 481x321 for some images, and 321x481 for the others.

  This last command also gives the format of the images in the second column.

16. How many of them are in landscape orientation (opposed to portrait)?

  For this, we used the command:

  ```
  identify -size *.* |grep 481x321|wc -l
  ```

  This command only return the results in the current folder, so we must repeat the procedure for all sub folders of images.

  In total there are: 133 (test) + 136 (train) + 77 (val) = 346 images in landscape orientation.

17. Crop all images to make them square (256x256).

  To crop the images we used the command convert from imagemagick:

  ```
  convert -crop 250x250+0+0 *.jpg
  ```

  That command crop all the images in the current folder to the size of 250x250, begining in the pixels 0,0 of the original image.


#References

1.	Command Grep. http://linuxcommand.org/man_pages/grep1.html

2.	35 Practical Examples of Linux Find Command. http://www.tecmint.com/35-practical-examples-of-linux-find-command/

3.	Linux and Unix rsync command. http://www.computerhope.com/unix/rsync.htm

4.	Linux and Unix diff command. http://www.computerhope.com/unix/udiff.htm

5.	14 Tail and head commands in LINUX/UNIX. http://www.linuxnix.com/14-tail-head-commands-linuxunix/

6.	Linux and Unix link command. http://www.computerhope.com/unix/link.htm

7.	Bash Script : what does #!/bin/bash mean? http://stackoverflow.com/questions/13872048/bash-script-what-does-bin-bash-mean

8.	Linux Command: List All Users In The System. https://www.cyberciti.biz/faq/linux-list-users-command/

9.	Where do I change my shell? http://unix.stackexchange.com/questions/22729/where-do-i-change-my-shell

10.	El shell de linux: Comando sort. https://enavas.blogspot.com.co/2008/03/el-shell-de-linux-comando-sort.html

11.	ImageMagick v6 Examples -- Cutting and Bordering. http://www.imagemagick.org/Usage/crop/#crop

12. Identify resolution. http://www.imagemagick.org/discourse-server/viewtopic.php?t=17451

13. Convert: https://www.imagemagick.org/script/convert.php

14. Tar. http://www.linfo.org/tar.html

15. Linux find command. http://www.binarytides.com/linux-find-command-examples/

16. How to Sort and Remove Duplicate Photos in Linux. https://www.linux.com/learn/how-sort-and-remove-duplicate-photos-linux
