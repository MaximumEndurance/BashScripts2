1. $ ./myopen.sh test.jpg
     Running this command Should open test.jpg in image viewer("/usr/bin/eog") 

2. The given configuration file has two entries for ".txt" extension and so it must prompt with the following choices and then run the appropriate program:
     $ ./myopen.sh readme.txt	
     	1	/usr/bin/emacs
     	2	/usr/bin/gvim
     	Enter your choice of program:

   The user must enter a number to choose which program to open.

3. $ ./myopen.sh test.png
     Running this command should prompt the user with something similar to this:
	Program not found in Config file
	Enter the Program:
     If the input from user is "/usr/bin/eog", then the file must be opened in the image viewer and the entry
     "png:/usr/bin/eog" should get added to myopen.cfg. The next time the same command is run, the file must
     be opened without any prompt.

4. $ ./myopen.sh
     This should display the correct usage of the command,
     Usage: ./myopen.sh <filetoopen>
     and then exit with an exit value of 1.
     Now, running
   $ echo $?
     should produce an output of 1.
