#------------------------------------------------START--------------------------------------------------
#!/bin/bash

#reads a file that has banner text in it
cat /Desktop/amoogusscript/amoogusart.txt

echo "Made by gramstick and co"
echo "amoogus is divided into 4 phases"
echo "      Phase 1: Updates/User Auditing/Firewall"
echo "      Phase 2: Prohibited Files/Hacking Tools"
echo "      Phase 3: Specific Things"
echo "      Phase 4: Checklist Checks"
echo "Note: amoogus should be run from Desktop and makes a log file in the Desktop of current user"

BRIGHTRED="\e[31;1m"
BRIGHTGREEN="\e[32;1m"
CYAN="\e[36m"
MAGENTABG="\e[45m"
ENDCOLOR="\e[0m"

#creates and sets permissions for a log used later in script for media files
touch log.list
chmod 777 log.list
#------------------------------------------------PHASE 1--------------------------------------------------
echo "PHASE 1"
#------------------------------------------------UPDATE FIREFOX ONLY--------------------------------------------------
while true; do

read -p "Do you want to upgrade firefox specifically? (y/n) " yn

case $yn in
    [yY] ) echo -e "${BRIGHTGREEN}ok champ${ENDCOLOR}";
           apt install --only-upgrade firefox
           echo -e "${MAGENTABG}firefox is newest version${ENDCOLOR}";
        break;;
	[nN] ) echo -e "${BRIGHTRED}kinda small brain maybe...${ENDCOLOR}";
		break;;
	* ) echo invalid response;;
esac
done
#------------------------------------------------UPDATE SYSTEM--------------------------------------------------
clear
while true; do

read -p "Do you want to upgrade the whole system? (y/n) " yn

case $yn in
    [yY] ) echo -e "${BRIGHTGREEN}great${ENDCOLOR}";
           apt upgrade
           echo -e "${MAGENTABG}system is upgraded${ENDCOLOR}";
        break;;
	[nN] ) echo -e "${BRIGHTRED}VERY small brain...oh god!!!! ${ENDCOLOR}";
		break;;
	* ) echo invalid response;;
esac

done
#------------------------------------------------FIREWALL--------------------------------------------------
clear
ufw enable
ufw default allow outgoing
ufw default deny incoming
echo -e "${MAGENTABG}firewall is enabled${ENDCOLOR}";

while true; do

read -p "Do you want to enable firewall logging? (y/n) " yn

case $yn in
    [yY] ) echo -e "${BRIGHTGREEN}ok, putting logging on high${ENDCOLOR}";
           ufw logging on high
        break;;
	[nN] ) echo -e "${BRIGHTRED}big sadge..${ENDCOLOR}";
		break;;
	* ) echo invalid response;;
esac

done
#------------------------------------------------ADDUSER--------------------------------------------------
usersNewLength=${#usersNew[@]}	

clear
echo -e "${MAGENTABG}Type user account names of users you want to add, with a space in between. ${ENDCOLOR}"
read -a usersNew

usersNewLength=${#usersNew[@]}	

for (( i=0;i<$usersNewLength;i++))
do

	clear
	echo ${usersNew[${i}]}
	adduser ${usersNew[${i}]}
    clear
	echo -e "${MAGENTABG}A user account for ${usersNew[${i}]} has been created.${ENDCOLOR}"
    while true; do

    read -p "Make ${usersNew[${i}]} administrator? (y/n) " yn

    case $yn in 
        [yY] ) echo -e "${BRIGHTGREEN}ok great${ENDCOLOR}";
               gpasswd -a ${usersNew[${i}]} sudo
		       gpasswd -a ${usersNew[${i}]} adm
		       gpasswd -a ${usersNew[${i}]} lpadmin
		       gpasswd -a ${usersNew[${i}]} sambashare
               clear
		       echo -e "${MAGENTABG}${usersNew[${i}]} has been made an administrator.${ENDCOLOR}"
            break;;
	    [nN] ) echo -e "${BRIGHTRED}ok...${ENDCOLOR}";
		    break;;
	       * ) echo -e "${BRIGHTRED}invalid response${ENDCOLOR}";;
    esac
    done

done
#------------------------------------------------EXISTINGUSERS--------------------------------------------------
clear
echo Type all user account names, with a space in between
read -a users

usersLength=${#users[@]}

for (( i=0;i<$usersLength;i++))
do
    while true; do
    clear

    echo ${users[${i}]}

    read -p "Delete user ${users[${i}]}? (y/n) " yn
    case $yn in 
        [yY] ) echo -e "${BRIGHTGREEN}ok fantastic${ENDCOLOR}";
               userdel -r ${users[${i}]}
		       echo -e "${MAGENTABG}${users[${i}]} has been deleted.${ENDCOLOR}"
            break;;
	    [nN] ) clear
                echo -e "${BRIGHTRED}ok${ENDCOLOR}";

                while true; do
                read -p "Make ${users[${i}]} administrator? (y/n) " yn
                case $yn in 
                    [yY] ) echo -e "${BRIGHTGREEN}ok making them an admin${ENDCOLOR}";
                           gpasswd -a ${users[${i}]} sudo
			               gpasswd -a ${users[${i}]} adm
			               gpasswd -a ${users[${i}]} lpadmin
			               gpasswd -a ${users[${i}]} sambashare
                           clear
			               echo -e "${MAGENTABG}${users[${i}]} has been made an administrator.${ENDCOLOR}"
                        break;;
	                [nN] ) echo -e "${BRIGHTRED}ok making them a standard user${ENDCOLOR}";
                           gpasswd -d ${users[${i}]} sudo
			               gpasswd -d ${users[${i}]} adm
			               gpasswd -d ${users[${i}]} lpadmin
			               gpasswd -d ${users[${i}]} sambashare
			               gpasswd -d ${users[${i}]} root
                           clear
                           echo -e "${MAGENTABG}${users[${i}]} has been made a standard user.${ENDCOLOR}"
		                break;;
	                * ) echo invalid response;;
                esac
                done
                
                while true; do
                read -p "Make custom password for ${users[${i}]}? (y/n) " yn
                case $yn in 
                    [yY] ) clear
                           echo -e "${BRIGHTGREEN}ok making custom password${ENDCOLOR}";
                           echo Password:
			               read pw
			               echo -e "$pw\n$pw" | passwd ${users[${i}]}
                           clear
			               echo -e "${MAGENTABG}${users[${i}]} has been given the password '$pw'.${ENDCOLOR}"
                        break;;
	                [nN] ) clear
                           echo -e "${BRIGHTRED}hmm i guess${ENDCOLOR}";
                           echo -e "Cyber1!\nCyber1!" | passwd ${users[${i}]}
                           clear
			               echo -e "${MAGENTABG}${users[${i}]} has been given the password 'Cyber1!'. ${ENDCOLOR}"
		                break;;
	                * ) echo invalid response;;
                esac
                done

                passwd -x30 -n3 -w7 ${users[${i}]}
		        echo -e "${MAGENTABG}${users[${i}]}'s password has been given a maximum age of 30 days, minimum of 3 days, and warning of 7 days.${ENDCOLOR}"
		    break;;
	    * ) echo invalid response;;
    esac

    done
done
#------------------------------------------------PHASE 2--------------------------------------------------
echo "${CYAN}PHASE 2${ENDCOLOR}"
#--------------------------------------------------MediaFiles---------------------------------------------------
#creates while do loop thats YN asking if you wanna keep media files, simple. important text is magenta and YN are green and red
echo > log.list
echo This is a log list of media files > log.list
echo > log.list
while true; do

read -p "Do you want to delete media files? (y/n) " yn

case $yn in 
    [yY] ) echo -e "${BRIGHTGREEN}ok, they will be put in a log${ENDCOLOR}";
           find /home -name "*.midi" -type f -print >> log.list
	       find /home -name "*.mid" -type f -print >> log.list
	       find /home -name "*.mod" -type f -print >> log.list
	       find /home -name '*.mp3' -type f -print >> log.list
	       find /home -name "*.mp2" -type f -print >> log.list
	       find /home -name "*.mpa" -type f -print >> log.list
	       find /home -name "*.abs" -type f -print >> log.list
	       find /home -name "*.mpega" -type f -print >> log.list
	       find /home -name "*.au" -type f -print >> log.list
	       find /home -name "*.snd" -type f -print >> log.list
	       find /home -name "*.wav" -type f -print >> log.list
	       find /home -name "*.aiff" -type f -print >> log.list
	       find /home -name "*.aif" -type f -print >> log.list
	       find /home -name "*.sid" -type f -print >> log.list
	       find /home -name "*.flac" -type f -print >> log.list
	       find /home -name "*.ogg" -type f -print >> log.list
	       
	       echo -e "${MAGENTABG}All audio files have been listed.${ENDCOLOR}";

	       find /home -name "*.mpeg" -type f -print >> log.list
	       find /home -name "*.mpg" -type f -print >> log.list
	       find /home -name "*.mpe" -type f -print >> log.list
	       find /home -name "*.dl" -type f -print >> log.list
	       find /home -name "*.movie" -type f -print >> log.list
	       find /home -name "*.movi" -type f -print >> log.list
	       find /home -name "*.mv" -type f -print >> log.list
	       find /home -name "*.iff" -type f -print >> log.list
	       find /home -name "*.anim5" -type f -print >> log.list
	       find /home -name "*.anim3" -type f -print >> log.list
	       find /home -name "*.anim7" -type f -print >> log.list
	       find /home -name "*.avi" -type f -print >> log.list
	       find /home -name "*.vfw" -type f -print >> log.list
	       find /home -name "*.avx" -type f -print >> log.list
	       find /home -name "*.fli" -type f -print >> log.list
	       find /home -name "*.flc" -type f -print >> log.list
	       find /home -name "*.mov" -type f -print >> log.list
	       find /home -name "*.qt" -type f -print >> log.list
	       find /home -name "*.spl" -type f -print >> log.list
	       find /home -name "*.swf" -type f -print >> log.list
	       find /home -name "*.dcr" -type f -print >> log.list
	       find /home -name "*.dir" -type f -print >> log.list
	       find /home -name "*.dxr" -type f -print >> log.list
	       find /home -name "*.rpm" -type f -print >> log.list
	       find /home -name "*.rm" -type f -print >> log.list
	       find /home -name "*.smi" -type f -print >> log.list
	       find /home -name "*.ra" -type f -print >> log.list
	       find /home -name "*.ram" -type f -print >> log.list
	       find /home -name "*.rv" -type f -print >> log.list
	       find /home -name "*.wmv" -type f -print >> log.list
	       find /home -name "*.asf" -type f -print >> log.list
	       find /home -name "*.asx" -type f -print >> log.list
	       find /home -name "*.wma" -type f -print >> log.list
	       find /home -name "*.wax" -type f -print >> log.list
	       find /home -name "*.wmv" -type f -print >> log.list
	       find /home -name "*.wmx" -type f -print >> log.list
	       find /home -name "*.3gp" -type f -print >> log.list
	       find /home -name "*.mov" -type f -print >> log.list
	       find /home -name "*.mp4" -type f -print >> log.list
	       find /home -name "*.avi" -type f -print >> log.list
	       find /home -name "*.swf" -type f -print >> log.list
	       find /home -name "*.flv" -type f -print >> log.list
	       find /home -name "*.m4v" -type f -print >> log.list
	       
	       echo -e "${MAGENTABG}All video files have been listed.${ENDCOLOR}";
	
	       find /home -name "*.tiff" -type f -print >> log.list
	       find /home -name "*.tif" -type f -print >> log.list
	       find /home -name "*.rs" -type f -print >> log.list
	       find /home -name "*.im1" -type f -print >> log.list
	       find /home -name "*.gif" -type f -print >> log.list
	       find /home -name "*.jpeg" -type f -print >> log.list
	       find /home -name "*.jpg" -type f -print >> log.list
	       find /home -name "*.jpe" -type f -print >> log.list
	       find /home -name "*.png" -type f -print >> log.list
	       find /home -name "*.rgb" -type f -print >> log.list
	       find /home -name "*.xwd" -type f -print >> log.list
	       find /home -name "*.xpm" -type f -print >> log.list
	       find /home -name "*.ppm" -type f -print >> log.list
	       find /home -name "*.pbm" -type f -print >> log.list
	       find /home -name "*.pgm" -type f -print >> log.list
	       find /home -name "*.pcx" -type f -print >> log.list
	       find /home -name "*.ico" -type f -print >> log.list
	       find /home -name "*.svg" -type f -print >> log.list
	       find /home -name "*.svgz" -type f -print >> log.list
	       
	       echo -e "${MAGENTABG}All image files have been listed.${ENDCOLOR}";
           echo -e "${MAGENTABG}Media files are complete.${ENDCOLOR}";
        break;;
	[nN] ) echo -e "${BRIGHTRED}stopping...${ENDCOLOR}";
		break;;
	* ) echo invalid response;;
esac

done
#------------------------------------------------HACKING TOOLS--------------------------------------------------
clear
echo > log.list
echo This is a log list of possible hacking tools > log.list
echo > log.list
while true; do

read -p "Remove hacking tools? (y/n) " yn

case $yn in 
    [yY] ) echo -e "${BRIGHTGREEN}ok, removing them now${ENDCOLOR}";
           apt-get purge netcat -y -qq
	       apt-get purge netcat-openbsd -y -qq
	       apt-get purge netcat-traditional -y -qq
	       apt-get purge ncat -y -qq
	       apt-get purge pnetcat -y -qq
	       apt-get purge socat -y -qq
	       apt-get purge sock -y -qq
	       apt-get purge socket -y -qq
	       apt-get purge sbd -y -qq
	       rm /usr/bin/nc
           clear
	       echo -e "${MAGENTABG} Netcat and all other instances have been removed.${ENDCOLOR}";

	       apt-get purge john -y -qq
	       apt-get purge john-data -y -qq
	       clear
	       echo -e "${MAGENTABG} John the Ripper has been removed.${ENDCOLOR}";

	       apt-get purge hydra -y -qq
	       apt-get purge hydra-gtk -y -qq
	       clear
	       echo -e "${MAGENTABG} Hydra has been removed.${ENDCOLOR}";

	       apt-get purge aircrack-ng -y -qq
	       clear
	       echo -e "${MAGENTABG} Aircrack-NG has been removed.${ENDCOLOR}";

	       apt-get purge fcrackzip -y -qq
	       clear
	       echo -e "${MAGENTABG} FCrackZIP has been removed.${ENDCOLOR}";

	       apt-get purge lcrack -y -qq
	       clear
	       echo -e "${MAGENTABG} LCrack has been removed.${ENDCOLOR}";

	       apt-get purge ophcrack -y -qq
	       apt-get purge ophcrack-cli -y -qq
	       clear
	       echo -e "${MAGENTABG} OphCrack has been removed.${ENDCOLOR}";

	       apt-get purge pdfcrack -y -qq
	       clear
	       echo -e "${MAGENTABG} PDFCrack has been removed.${ENDCOLOR}";

	       apt-get purge pyrit -y -qq
	       clear
	       echo -e "${MAGENTABG} Pyrit has been removed.${ENDCOLOR}";

	       apt-get purge rarcrack -y -qq
	       clear
	       echo -e "${MAGENTABG} RARCrack has been removed.${ENDCOLOR}";

	       apt-get purge sipcrack -y -qq
	       clear
	       echo -e "${MAGENTABG} SipCrack has been removed.${ENDCOLOR}";

	       apt-get purge irpas -y -qq
	       clear
	       echo -e "${MAGENTABG} IRPAS has been removed.${ENDCOLOR}";

	       clear
	       echo -e "${MAGENTABG} Are there any hacking tools shown? (not counting libcrack2:amd64 or cracklib-runtime)${ENDCOLOR}";
	       dpkg -l | egrep "crack|hack" >> log.list

	       apt-get purge logkeys -y -qq
	       clear 
	       echo -e "${MAGENTABG} LogKeys has been removed.${ENDCOLOR}";

	       apt-get purge zeitgeist-core -y -qq
	       apt-get purge zeitgeist-datahub -y -qq
	       apt-get purge python-zeitgeist -y -qq
	       apt-get purge rhythmbox-plugin-zeitgeist -y -qq
	       apt-get purge zeitgeist -y -qq
           clear
	       echo -e "${MAGENTABG} Zeitgeist has been removed.${ENDCOLOR}";

	       apt-get purge nfs-kernel-server -y -qq
	       apt-get purge nfs-common -y -qq
	       apt-get purge portmap -y -qq
	       apt-get purge rpcbind -y -qq
	       apt-get purge autofs -y -qq
           clear
	       echo -e "${MAGENTABG} NFS has been removed.${ENDCOLOR}";

	       apt-get purge nginx -y -qq
	       apt-get purge nginx-common -y -qq
           clear
	       echo -e "${MAGENTABG} NGINX has been removed.${ENDCOLOR}";

	       apt-get purge inetd -y -qq
	       apt-get purge openbsd-inetd -y -qq
	       apt-get purge xinetd -y -qq
	       apt-get purge inetutils-ftp -y -qq
	       apt-get purge inetutils-ftpd -y -qq
	       apt-get purge inetutils-inetd -y -qq
	       apt-get purge inetutils-ping -y -qq
	       apt-get purge inetutils-syslogd -y -qq
	       apt-get purge inetutils-talk -y -qq
	       apt-get purge inetutils-talkd -y -qq
	       apt-get purge inetutils-telnet -y -qq
	       apt-get purge inetutils-telnetd -y -qq
	       apt-get purge inetutils-tools -y -qq
	       apt-get purge inetutils-traceroute -y -qq
           clear
	       echo -e "${MAGENTABG} Inetd (super-server) and all inet utilities have been removed.${ENDCOLOR}";

	       clear
	       apt-get purge vnc4server -y -qq
	       apt-get purge vncsnapshot -y -qq
	       apt-get purge vtgrab -y -qq
           clear
	       echo -e "${MAGENTABG} VNC has been removed.${ENDCOLOR}";

	       apt-get purge snmp -y -qq
           clear
	       echo -e "${MAGENTABG} SNMP has been removed.${ENDCOLOR}";
           clear
           echo -e "${MAGENTABG} Hacking tools removed:                                              ${ENDCOLOR}";
           echo -e "${MAGENTABG} (Netcat, John the Ripper, Hydra, Aircrack-NG, FCrackZIP, LCrack,    ${ENDCOLOR}";
           echo -e "${MAGENTABG}  OphCrack, PDFCrack, Pyrit, RARCrack, PDFCrack, Pyrit, RARCrack,    ${ENDCOLOR}";
           echo -e "${MAGENTABG}  SipCrack, IRPAS, LogKeys, Zeitgeist, NFS, NGINX, Inetd, VNC, SNMP) ${ENDCOLOR}";
        break;;
	[nN] ) echo -e "${BRIGHTRED}oh god...${ENDCOLOR}";
		break;;
	* ) echo invalid response;;
esac

done
#------------------------------------------------PHASE 3--------------------------------------------------
echo "${CYAN}PHASE 3${ENDCOLOR}"
#------------------------------------------------PHASE 4--------------------------------------------------
echo "${CYAN}PHASE 4${ENDCOLOR}"
#------------------------------------------------CHECK PROHIBTED SERVICES--------------------------------------------------
while true; do

read -p "Do you want to look at services? (y/n) " yn

case $yn in
    [yY] ) echo -e "${BRIGHTGREEN}ok, pulling up services that are active and running${ENDCOLOR}";
           systemctl list-units --type=service --state=active --state=running
        break;;
	[nN] ) echo -e "${BRIGHTRED}fine then...${ENDCOLOR}";
		break;;
	* ) echo invalid response;;
esac

done


