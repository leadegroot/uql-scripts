# Add this function to your .bash_profile (or start up script appropriate to your shell), 
# then, once you've opened a new tab, you can run the tests for code coverage with just the command `cc` 
# and it: 
# - wont run if you have localhost up otherwise (which is annoying because the coverage doesn't work if it is running) and 
# - will tell you how long it took 
#
function cc {
  SECONDS=0

  LOCALHOST_RUNNING=$(lsof -i :2020 | grep LISTEN)
  if [[ ! -z $LOCALHOST_RUNNING ]]; then
     echo "==========================================="
     echo ""
     echo " Localhost is running - kill and try again "
     echo ""
     echo "==========================================="
     return 1
  fi
  
  npm run test:cc

  duration=$SECONDS
  echo "Code coverage tests complete: time taken: $(($duration / 60)) minutes and $(($duration % 60)) seconds."
}
