#!/bin/bash

# ------------notes-----------------
# this script requires pstopdf to be installed
# you can check if you have it with the following command
#        find /usr/local/ -name pstopdf
# if nothing is displayed in the terminal you can run the following command to install ghostscript which carries the current pstopdf program
#        brew install ghostscript
# if you dont have brew installed use the following code
#        ruby -e"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#
#
# --------edit this block ----------

name='William Blake Whitham'
address1='75 Eastmoor Ave'
address2='Daly City, Ca 94015'
phone='925-808-1650'
email='bwhitham77@gmail.com'

time_stamp=`date +%m-%d-%Y`

# edit to change directory the file is saved to [Default is Desktop]
destdir=~/Desktop
# --------Do not edit below----------


while true; do
    read -p "do you know the hiring manager's name?" yn
    case $yn in
        [Yy]* ) echo "please enter the HIRING MANGAGER'S full name";
        read hiring_manager;
        greeting="Dear "${hiring_manager}","
        break;;
        [Nn]* ) greeting="To whom it may concern,";
        break;;
        * ) echo "Please answer yes or no.";
    esac
done
        echo "please enter the name of the COMPANY";
        read company;
        echo "please enter the POSITION you are applying for";
        read position;
        echo "please enter 1/4 VALUE you would bring to the team";
        read criteria1;
        echo "please enter 2/4 VALUE you would bring to the team";
        read criteria2;
        echo "please enter 3/4 VALUE you would bring to the team";
        read criteria3;
        echo "please enter 4/4 VALUE you would bring to the team";
        read criteria4;

#-----------change the paragraph below to personalize------------

cover="
"${name}"

"${address1}"

"${address2}"

"${phone}"

"${email}"




"${time_stamp}"
"${company}"
"${greeting}"

    This letter is to express my interest in the open position at "${company}" for the "${position}" role. As a graduate of the Hack Reactor boot-camp that was hired immediately after graduation to be part of the curriculum team, I am confident that I have the experience and skills to add value to your organization.

    I'm a natural problem solver that enjoys thinking critically and creatively about how to best approach a hurdle. This is put in the spotlight when I'm working on a project with a team that requires me to be outside of my comfort zone thus forcing myself to grow. I used these skills to my benefit to climb up to the position of Lead Software Engineering Immersive Resident at Hack Reactor, and was often commended by my dedication to the project at hand as well as my drive and desire for continual iterative improvement. I am a naturally curious person that wants to understand how and why things work, and then utilize that information to accelarate and improve my abilities.

    The position's listed requirements stuck out to me because they closely embody my strengths. A few aspects that I believe would allow me to add value to your team would be:
      "${criteria1}"
      "${criteria2}"
      "${criteria3}"
      "${criteria4}"

    I've included my resume that details my projects and experience in software engineering. Please give me a ring at "${phone}" anytime, or shoot me an email at "${email}".

  Thank you for taking the time to read this letter. I am excited about the opportunity to speak with you further in regards to this opportunity.


Sincerely,


"${name}"
"
# remove whitespaces from name variable
name="$(echo -e "${name}" | tr -d '[:space:]')"

# create dynamic filename
filename=$name-$company-coverLetter.txt

# write contents to destination
echo "$cover">$destdir/$filename

#use vim to make hardcopy of txt file to a ps file
vim $destdir/$filename -c "wq!";
#format file and write to a new file, because vim overwrites any options when creating a PostScript file
fmt $destdir/$filename > $destdir/$filename.txt;

#Convert formatted doc to a pdf
vim $destdir/$filename.txt -c "
:set printfont=courier:h12 |
:set printheader=\ |
hardcopy > $destdir/$filename |
q!";


#convert the ps file to a pdf
ps2pdf $destdir/$filename $destdir/$filename.pdf

# remove original txt file
rm $destdir/$filename
# remove redundant copy
rm $destdir/$filename.txt