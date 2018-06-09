# miner

#### Get the tools

Download the and the setup.sh files:

    curl -s https://raw.githubusercontent.com/moomanow/buildMiner/master/setup.sh | bash -s


edit disk size

    First, shut down your VM and increase the disk size.
    Then start your VM and go to the console.
    
    # fdisk -u /dev/sda
    (-u shows sectors instead of cylinders. This is important)
    
    (Make a note of the start sector of the LVM partition)
    Command (m for help): p
    
        Device Boot      Start         End      Blocks   Id  System
    /dev/xvda1   *        2048      499711      248832   83  Linux
    Partition 1 does not end on cylinder boundary.
    /dev/xvda2          501758    16775167     8136705    5  Extended
    /dev/xvda5          501760    16775167     8136704   8e  Linux LVM

    (delete the LVM and/or Extended partition)
    Command (m for help): d
    Partition number (1-5): 2

    (Create a new partition)
    Command (m for help): n
    Command action
       e   extended
       p   primary partition (1-4)
    p (I choose primary but you may choose extended)
    Partition number (1-4): 2 (choose one that's available)
    
    (Fill in the start sector of the LVM partition we deleted above)
    First sector (63-16777215, default 63): 501760
    Last sector, +sectors or +size{K,M,G} (501760-16777215, default 16777215): (Enter)
    
    (change created partition to Linux LVM)
    Command (m for help): t 
    Partition number (1-4): 2
    Hex code (type L to list codes): 8e
    Changed system type of partition 2 to 8e (Linux LVM)
    
    Command (m for help): p
    
        Device Boot      Start         End      Blocks   Id  System
    /dev/xvda1   *        2048      499711      248832   83  Linux
    Partition 1 does not end on cylinder boundary.
    /dev/xvda2          501760    16777215     8137728   8e  Linux LVM
    
    Command (m for help): w (write)
    
    # reboot

    (Resize physical volume)
    # pvresize /dev/xvda2

    (make a note of the VG "Free PE")
    # vgdisplay

    (make a note of the "LV Name" of the LV you want to resize)
    # lvdisplay 

    (Resize LV. Fill in the found "Free PE" and "LV Name" (without the brackets))
    # lvresize -l +[Free PE] [LV Name]
    
    (resize the file system)
    # resize2fs [LV Name] 
    # reboot
    
    
command

    fdisk -u /dev/sda
    Command (m for help): p
    Command (m for help): d
    Partition number (1,2,5, default 5): 2
    Command (m for help): p
    Command (m for help): n
    Select (default p): e
    Partition number (2-4, default 2):{enter}
    First sector (999424-234455039, default 999424): {enter}
    Last sector, +sectors or +size{K,M,G,T,P} (999424-234455039, default 234455039): {enter}
    Command (m for help): n
    First sector (1001472-234455039, default 1001472): {enter}
    Last sector, +sectors or +size{K,M,G,T,P} (1001472-234455039, default 234455039): {enter}
    
    Command (m for help): t
    Partition number (1,2,5, default 5): 
    Partition type (type L to list all types): 8e
    Command (m for help): w (write)
    reboot
    pvresize /dev/sda5
    vgdisplay
    lvdisplay 
    lvresize -l +100%FREE /dev/xserver-vg/root
    resize2fs /dev/xserver-vg/root

    
     
