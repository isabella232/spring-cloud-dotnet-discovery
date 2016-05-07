#!/bin/bash
source $HOME/.dnx/dnvm/dnvm.sh
dnvm use 1.0.0-rc1-update1 -a x64 -r coreclr
cd src
dnu restore
cd ../test
dnu restore
cd ..
cd src/Pivotal.Extensions.Configuration.ConfigServer
dnu pack --framework dnxcore50 --configuration Release
cd ../..
