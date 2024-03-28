#!/bin/bash

# quick install of CMSSW :)
CMSSW_REL=CMSSW_13_3_1

scramv1 project CMSSW $CMSSW_REL

cd $CMSSW_REL/src/ 
eval `scramv1 runtime -sh`
cd ../../

#Download and unzip JHUGen

wget https://spin.pha.jhu.edu/Generator/JHUGenerator.v7.5.5.tar.gz
tar -xf JHUGenerator.v7.5.5.tar.gz
find "." -name *.gz -type f -delete

# Install MCFM for ggZZ production #

echo "Would you like to forcibly install MCFM Standalone??? (y/n)"
echo "Depending on the pace of this tutorial you may or may not want to do this"

read answer

if [ $answer = "y" ]
then
    cd JHUGenerator.v7.5.5/MCFM-JHUGen
    ./Install
    # edit the makefile to link lhapdf
    sed -i '/LHAPDFLIB   =/c\LHAPDFLIB   =/cvmfs/cms.cern.ch/el9_amd64_gcc12/external/lhapdf/6.4.0-52852f9a177b8e8b5b72e2ae6b1327b6/lib' makefile
    sed -i '/PDFROUTINES =/c\PDFROUTINES = LHAPDF' makefile
    make
else
    echo "Skipping automatic compilation of mcfm!" 
fi

cd ../..

# Install JHUGen for EW off-shell production #

echo "Would you like to forcibly install JHUGen + MELA??? (y/n)"
echo "Depending on the pace of this tutorial you may or may not want to do this"

read answer

if [ $answer = "y" ]
then   
    cd JHUGenerator.v7.5.5/JHUGenMELA/
    ./setup.sh
    eval `./setup.sh env`
    cd ../JHUGenerator
    sed -i '/linkMELA =/c\linkMELA = Yes' makefile
    sed -i '/MELALibDir =/c\  MELALibDir = $(MELADataDir)/$(MELA_ARCH)' makefile
    make
else
    echo "Skipping automatic compilation of JHUGen!" 
fi

echo "Moving grids into the JHUGenerator directory" 

cp -r Grids JHUGenerator.v7.5.5/JHUGenerator/

echo "Done!"