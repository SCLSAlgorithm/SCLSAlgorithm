#!/bin/bash
 
#PATH=/bin:/sbin:/usr/bin:/usr/sdbin:/usr/local/bin:/usr/local/sbin:~/bin
#export LD_LIBRARY_PATH=/home/XXX/Downloads/gurobi563/linux64/lib:$LD_LIBRARY_PATH
Sample="Sample"
projectName="CSLSAlgorithm"
date=20170917 #$(date +%Y%m%d%H%M%S)


#1.SCLS algorithm 2.cose 3.ksp 4.ILP 5.IQP 
startAlgorithm=1
algorithmNum=5  #8

showAlgorithmNum=5

#cores number
startCoreNum=1
coreNum=8

#repeat times
runTimes=100  #20
mostrunTimes=1000

#set the most time(ms) for executing a sample
timelimit=300000

#sample index
testSampleStartIndex=1   #1
testSampleEndIndex=7   #7




#storage parameter
mkdir -p ./${Sample}/${date}
touch ./${Sample}/${date}/Parameter.txt
rm -f  ./${Sample}/${date}/Parameter.txt
echo $algorithmNum >> ./${Sample}/${date}/Parameter.txt
echo $showAlgorithmNum >> ./${Sample}/${date}/Parameter.txt
echo $coreNum >> ./${Sample}/${date}/Parameter.txt
echo $runTimes >> ./${Sample}/${date}/Parameter.txt
echo $testSampleEndIndex >> ./${Sample}/${date}/Parameter.txt
echo $timelimit >> ./${Sample}/${date}/Parameter.txt


rm -f ./${Sample}/${date}/NodeEdge.txt
touch ./${Sample}/${date}/NodeEdge.txt

for ((currentCoreNum=${startCoreNum};currentCoreNum<=${coreNum};currentCoreNum=currentCoreNum+1))
do
	for ((ithTestSample=${testSampleStartIndex};ithTestSample<=${testSampleEndIndex};ithTestSample=ithTestSample+1))
	do
		test=test${ithTestSample}
		echo "coreNumber: "$currentCoreNum
		echo "test/${test}/topo.csv"
		echo "test/${test}/demand.csv"
		echo "test/${test}/srlg.csv"
		mkdir  -p ${Sample}/${date}/coreNum${currentCoreNum}
		mkdir  -p ${Sample}/${date}/coreNum${currentCoreNum}/${test}
		
		for((j=${startAlgorithm};j<=${algorithmNum};j=j+1))
		do
			echo "algorithm ${j}"
			mkdir  -p ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}
			touch ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/mid.txt
			
			rm -f ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/result.txt
			
			runNum=0
			for ((lthRun=1;lthRun<=${runTimes};))
			do	
taskset -c 0-$((${currentCoreNum} - 1)) ./Debug/${projectName} ${Sample}/${test}/topo.csv ${Sample}/${test}/demand.csv ${Sample}/${test}/srlg.csv ${Sample}/${test}/${result}.csv ${j} >> ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/mid.txt			
				#may be fault segment problem
				answer=$(echo $?)
				echo ${answer}
				((runNum=${runNum}+1))
				if [ "0" == "${answer}" ]; then
					
	
					if [ "${currentCoreNum}" == "${startCoreNum}" ] && [ "${j}" == "${startAlgorithm}" ] && [ "${lthRun}" == "1" ]; then
						echo ${ithTestSample} >> ${Sample}/${date}/NodeEdge.txt
						cat ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/mid.txt | grep 'allsrlg' | cut -d ':' -f2 >> ${Sample}/${date}/NodeEdge.txt
						cat ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/mid.txt | grep 'allnode' | cut -d ':' -f2 >> ${Sample}/${date}/NodeEdge.txt
						cat ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/mid.txt | grep 'alledge' | cut -d ':' -f2 >> ${Sample}/${date}/NodeEdge.txt
					fi
					
					cat ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/mid.txt | grep 'APcost' | cut -d ':' -f2   >>${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/result.txt	
					cat ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/mid.txt | grep 'CostSum' | cut -d ':' -f2   >> ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/result.txt	
					cat ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/mid.txt | grep 'APhop' | cut -d ':' -f2   >>${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/result.txt	
			 		cat ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/mid.txt | grep 'HopSum' | cut -d ':' -f2   >> ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/result.txt	
			 		cat ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/mid.txt | grep 'used' | cut -d ' ' -f5 >> ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/result.txt
					((lthRun=${lthRun}+1))
				fi
				rm ${Sample}/${date}/coreNum${currentCoreNum}/${test}/algorithm${j}/mid.txt
				if [  ${runNum} -ge ${mostrunTimes} ]; then
					break
				fi
			done
		done
	done
done








