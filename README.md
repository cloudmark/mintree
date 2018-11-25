# Suprnation Open book Exercise

To run the sample run

  > stack build

then

  > cat sample.txt | stack exec -- minpath

Alternatively you can use it as follows


  > cat << EOF | stack exec -- minpath
  7
  6 4
  3 8 5
  11 2 10 9
  EOF
