# Add this function to your .bash_profile (or start up script appropriate to your shell), 
# then, once you've opened a new tab, you can run the tests for code coverage with just the command `cc` 
# and it: 
# - wont run if you have localhost up otherwise (which is annoying because the coverage doesn't work if it is running) and 
# - will tell you how long it took 
#
function cc {
  SECONDS=0
#  currentDate=`date +%T`
  LOCALHOST_RUNNING=$(lsof -i :2020 | grep LISTEN)
  if [[ ! -z $LOCALHOST_RUNNING ]]; then
     echo "==========================================="
     echo ""
     echo " Localhost is running - kill and try again "
     echo ""
     echo "==========================================="
     return 1
  fi
  if [[ "$PWD" != "/Users/uqldegro/github/homepage-react" ]]; then
    echo "========================================================================"
    echo ""
    echo "  This is a homepage repo command - swap directories and run again"
    echo ""
    echo "========================================================================"
    return 1
  fi

  npm run test:cc

  NUM_FULL_COVERAGE=$(grep -c class=\"strong\"\>100\% coverage/index.html)
  echo ${NUM_FULL_COVERAGE}
  NORMALCOLOR="\e[97m"
  GREEN="\e[32m"
  RED="\e[31m"
  if [[ $NUM_FULL_COVERAGE == 4 ]]; then
      echo "${GREEN}"
      echo "Coverage 100%";
      echo ""
      echo "            ,-""-."
      echo "           :======:"
      echo "           :======:"
      echo "            `-.,-'"
      echo "              ||"
      echo "            _,''--.    _____"
      echo "           (/ __   `._|"
      echo "          ((_/_)\     |"
      echo "           (____)'.___|"
      echo "            (___)____.|_____"
      echo "Human, your code coverage was found to be satisfactory. Great job!"
      echo "${NORMALCOLOR}"
  else
      echo "${RED}"
      echo "                     ____________________"
      echo "                    /                    \ "
      echo "                    |    Coverage NOT    | "
      echo "                    |         100%       | "
      echo "                    \____________________/ "
      echo "                             !  !"
      echo "                             !  !"
      echo "                             L_ !"
      echo "                            / _)!"
      echo "                           / /__L"
      echo "                     _____/ (____)"
      echo "                            (____)"
      echo "                     _____  (____)"
      echo "                          \_(____)"
      echo "                             !  !"
      echo "                             !  !"
      echo "                             \__/"
      echo ""
      echo "            Human, your code coverage was found to be lacking... Do not commit again until it is fixed."
      echo "${NORMALCOLOR}"
      # show actual coverage numbers
      grep -A 2 class=\"strong\"\> coverage/index.html
      echo "Run your tests locally with npm run test:cc then load coverage/index.html to determine where the coverage gaps are"
  fi;
  duration=$SECONDS
  echo "Code coverage tests complete: time taken: $(($duration / 60)) minutes and $(($duration % 60)) seconds."
}
