# JHUGenTutorial

## Setup of enviornment 

```
git clone https://github.com/Offshell-Workshop-LPC/JHUGenTutorial
cd JHUGenTutorial 
cmsrel CMSSW_13_3_1
cd CMSSW_13_3_1/src
cmsenv
```

## Compilation of MCFM-JHUGen

```
cd JHUGenerator.v7.5.5/MCFM-JHUGen
./Install
# edit the makefile to link lhapdf (optional)
sed -i '/LHAPDFLIB   =/c\LHAPDFLIB   =/cvmfs/cms.cern.ch/el9_amd64_gcc12/external/lhapdf/6.4.0-52852f9a177b8e8b5b72e2ae6b1327b6/lib' makefile
sed -i '/PDFROUTINES =/c\PDFROUTINES = LHAPDF' makefile
make
```

## Compilation of JHUGen for EW production

```
cd JHUGenerator.v7.5.5/JHUGenMELA/
./setup.sh
eval $(./setup.sh env)
cd ../JHUGenerator
sed -i '/linkMELA =/c\linkMELA = Yes' makefile
sed -i '/MELALibDir =/c\  MELALibDir = $(MELADataDir)/$(MELA_ARCH)' makefile
make
```
