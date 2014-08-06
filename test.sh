set -e
for file in `ls *Tests.hs`; do runhugs $file; done
