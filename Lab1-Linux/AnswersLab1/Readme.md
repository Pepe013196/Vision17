Fabian Enrique Martinez Solano

Juan Felipe Perez Correa


Laboratorio 1 - Visión por Computador

1. ``Grep`` command: This command searches the named input files for lines containing a match to the given PATTERN. Also, this prints the matching lines in the command line.

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
4. rsync command: I0s the abbreviate of Remote Sync. This command is used for copying and syncghronizing files and directories remotely as well as locally in Linux sistems. It can copy locally, to/from another host over any remote shell, or to/from a remote rsync daemon. This command offers a large number of options that control every aspect of its behavior and permit very flexible specification of the set of files to be copied.

5. ``diff`` command: This command analyzes two files and prints the lines that are different between this files. In addition, the command prints a set of instructions for how to change one file in order to make it identical to the second file; this instructions are numbers (identify the line of the files) and letters (a for add, c for change or d to delete). The command does not change the content of any file.

6. ``tail`` command: Tail is a command which prints the last few number of lines of a certain file then terminates. The number of lines can be specify by the user, but by default prints 10 lines.

7. ``tail -f`` command: Unlike the default behavior which is to end after printing certain number of lines, the -f option “which stands for follow” will keep the stream going. It will start printing extra lines on to console added to the file after it is opened. This command will keep the file open to display updated changes to console until the user breaks the command.

8. ``link`` command: The link command creates a hard link named FILE2 which shares the same index node as the existing file FILE1. Since FILE1 and FILE2 share the same index node, they will point to the same data on the disk, and modifying one will be functionally the same as modifying the other. This command is different to ``ln``, command that creates a link, or a symbolic link, to a file or directory.

  Any changes that occurred with either of these files would affect the other file or link.

9. ``#! /bin/bash``: 

  In Linux system, we have shell which interprets our UNIX commands. Now there are a number of shell in Unix system. Among them, there is a shell called bash which is very common Linux and it has a long history. This is a by default shell in Linux.
  
  When you write a script (collection of unix commands and so on) you have a option to specify which shell it can be used. Generally you can specify which shell it wold be by using Shebang.

  So if you #!/bin/bash in the top of your scripts then you are telling your system to use bash as a default shell.

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



REFERENCES

1.	http://linuxcommand.org/man_pages/grep1.html

2.	http://www.tecmint.com/35-practical-examples-of-linux-find-command/

3.	http://www.computerhope.com/unix/rsync.htm

4.	http://www.computerhope.com/unix/udiff.htm

5.	http://www.linuxnix.com/14-tail-head-commands-linuxunix/

6.	http://www.computerhope.com/unix/link.htm

7.	http://stackoverflow.com/questions/13872048/bash-script-what-does-bin-bash-mean

8.	https://www.cyberciti.biz/faq/linux-list-users-command/

9.	http://unix.stackexchange.com/questions/22729/where-do-i-change-my-shell

10.	https://enavas.blogspot.com.co/2008/03/el-shell-de-linux-comando-sort.html

11.	
