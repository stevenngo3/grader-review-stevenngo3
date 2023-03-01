CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
if [[ -f ListExamples.java ]]
then echo "ListExamples found"
else echo "need file ListExamples.java"
exit 1
fi

cp ListExamples.java ../
javac -cp ".;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar" *.java
if [[ $? == 0 ]]
then echo "ListExamples compiled"
else echo "ListExamples failed to compile"
exit 1
fi

java -cp ".;../lib/junit-4.13.2.jar;../lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > junitresult.txt
JRESULT=`grep -c Failures: junitresult.txt`
echo $JRESULT
if [[ $JRESULT -ne 0 ]]
then echo "Grade: 0%, there is a test failure"
else echo "Grade: 100%, every test passed"
exit 1
fi


