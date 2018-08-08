echo "##########################################"
echo "#                                        #"
echo "#          >>> Sudoku checker <<<        #"
echo "#                                        #"
echo "#           Created by: ekulyyev         #"
echo "##########################################\n"

ERR=0
COR=0
FLD_NUM=0
F_NUM=0

RED=$'\e[1;31m'
GREEN=$'\e[1;32m'
YELLOW=$'\e[1;33m'
BLUE=$'\e[1;34m'
MAGENTA=$'\e[1;35m'
CYAN=$'\e[1;36m'
WHITE=$'\033[1;37m'
END=$'\e[0m'

echo "\n==${RED}#####${END}================================="
echo "==${RED}#####${END}=================================="
echo "==${RED}#####${END}======${WHITE}*${END}=${WHITE}*${END}=${WHITE}\\${END}======================="
echo "==${RED}#####${END}======${WHITE}*${END}==${WHITE}//${END}======================="
echo "==${RED}#####${END}====${WHITE}*${END}=${WHITE}*${END}${WHITE}_//${END}======================="
echo "==${RED}#####${END}================================="
echo "==${RED}#####${END}================================"
echo "==${RED}#####${END}================================="
echo "==${RED}#####${END}=================================="
echo "==${RED}#####${END}==================================\n\n"

norminette -R CheckForbiddenSourceHeader ex00/*
sleep 5
echo "Compiling..."
sleep 1
gcc -Wall -Wextra -Werror -o ex00/sudoku ex00/*.c
echo "sudoku ready to serve!"
sleep 1

FLD_NUM=$(($(find TESTS/tests* -maxdepth 1 -type d -print | wc -l | tr -d ' ')-1))
for n in  $(seq -f "%2g" 0 $FLD_NUM)
	do
		echo `cp -rf TESTS/tests_$n/* ./TESTS`
	done
F_NUM=$(ls -l TESTS | grep -a 'test_*' | wc -l | tr -d ' ')

for num in $(seq -f "%2g" 0 $F_NUM)
	do
		echo "\n=========================================="
		echo "========== Testing case $num ==========="
		echo "=========================================="
		RES=$(cat TESTS/test_$num | xargs ex00/sudoku)
		echo "$RES"
		if [ "$RES"  = "Error" ]; then
			ERR=`expr $ERR + 1`
		else
			COR=`expr $COR + 1`
		fi
	done

n=$((F_NUM-COR+1))
echo "\n******************************************"
echo "Done!"
echo "-------------------------------------------"
echo "*** RESULTS ***"
echo "Unsolved: $ERR"
echo "Solved:   $COR"
if [ $n -eq 10 ]; then
	echo "Final score: ${GREEN}PASS${END}"
else
	echo "Final score: ${RED}FAIL${END}"
fi
echo "-------------------------------------------"

rm ex00/sudoku
rm TESTS/test_*
