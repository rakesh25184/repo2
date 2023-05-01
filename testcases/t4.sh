# Atmost 3 cabs check

#! /bin/sh
# Alternate interest status test

curl -s http://localhost:8081/reset
curl -s http://localhost:8082/reset

testPassed="yes"

#cab 101 signs in
resp=$(curl -s http://localhost:8080/signIn?cabId=101\&initialPos=0)
if [ "$resp" = "true" ];
then
	echo "Cab 101 signed in"
else
	echo "Cab 101 could not sign in"
	testPassed="no"
fi


#cab 102 signs in
resp=$(curl -s http://localhost:8080/signIn?cabId=102\&initialPos=10)
if [ "$resp" = "true" ];
then
	echo "Cab 102 signed in"
else
	echo "Cab 102 could not sign in"
	testPassed="no"
fi


#cab 102 signs in
resp=$(curl -s http://localhost:8080/signIn?cabId=104\&initialPos=15)
if [ "$resp" = "true" ];
then
	echo "Cab 104 signed in"
else
	echo "Cab 104 could not sign in"
	testPassed="no"
fi



#cab 102 signs in
resp=$(curl -s http://localhost:8080/signIn?cabId=103\&initialPos=20)
if [ "$resp" = "true" ];
then
	echo "Cab 103 signed in"
else
	echo "Cab 103 could not sign in"
	testPassed="no"
fi


#cab 102 signs in
resp=$(curl -s http://localhost:8080/signIn?cabId=106\&initialPos=40)
if [ "$resp" = "true" ];
then
	echo "Cab 106 signed in"
else
	echo "Cab 106 could not sign in"
	testPassed="no"
fi



#cab 102 signs in
resp=$(curl -s http://localhost:8080/signIn?cabId=105\&initialPos=30)
if [ "$resp" = "true" ];
then
	echo "Cab 105 signed in"
else
	echo "Cab 105 could not sign in"
	testPassed="no"
fi




#customer 201 requests a ride
rideId1=$(curl -s http://localhost:8081/requestRide?custId=201\&sourceLoc=2\&destinationLoc=8)
if [ "$rideId1" != "-1" ];
then
	echo "Ride by customer 201 started with rideId" $rideId1
else
	echo "Ride to customer 201 denied"
	testPassed="no"
fi




#customer 201 end ride
rideId=$(curl -s http://localhost:8080/rideEnded?cabId=101\&rideId=$rideId1)
if [ "$rideId" != "false" ];
then
	echo "Ride by cab 101 customer 201 ended"
else
	echo "Ride to cab 101 customer 201 didn't end"
	testPassed="no"
fi



#customer 201 requests a ride
rideId1=$(curl -s http://localhost:8081/requestRide?custId=201\&sourceLoc=2\&destinationLoc=8)
if [ "$rideId1" != "-1" ];
then
	echo "Ride by customer 201 started"
else
	echo "Ride to customer 201 denied"
	testPassed="no"
fi




#customer 201 end ride
rideId2=$(curl -s http://localhost:8080/rideEnded?cabId=102\&rideId=$rideId1)
if [ "$rideId2" != "false" ];
then
	echo "Ride by cab 102 customer 201 ended"
else
	echo "Ride to cab 102 customer 201 didn't end"
	testPassed="no"
fi






#customer 201 requests a ride
rideId2=$(curl -s http://localhost:8081/requestRide?custId=201\&sourceLoc=15\&destinationLoc=10)
if [ "$rideId2" != "-1" ];
then
	echo "Ride by customer 201 started"
	
else
	echo "Ride to customer 201 denied"
	testPassed="no"
fi


#customer 201 requests a ride
rideId2=$(curl -s http://localhost:8081/requestRide?custId=202\&sourceLoc=15\&destinationLoc=10)
if [ "$rideId2" != "-1" ];
then
	echo "Ride by customer 202 started"
	
else
	echo "Ride to customer 202 denied"
	testPassed="no"
fi


#customer 201 requests a ride
rideId2=$(curl -s http://localhost:8081/requestRide?custId=203\&sourceLoc=15\&destinationLoc=10)
if [ "$rideId2" != "-1" ];
then
	echo "Ride by customer 203 started"
	
else
	echo "Ride to customer 203 denied"
	testPassed="no"
fi



#customer 201 requests a ride
rideId2=$(curl -s http://localhost:8081/requestRide?custId=204\&sourceLoc=15\&destinationLoc=10)
if [ "$rideId2" != "-1" ];
then
	echo "Ride by customer 204 started"
	
else
	echo "Ride to customer 204 denied"
	testPassed="no"
fi


resp=$(curl -s http://localhost:8081/getCabStatus?cabId=101)
#echo $resp
if [ "$resp" != "giving-ride 15 203 10" ];
then
	echo "Wrong Status"
	testPassed="no"	
else
	echo "Correct Status"
	
fi


resp=$(curl -s http://localhost:8081/getCabStatus?cabId=102)
echo $resp
if [ "$resp" != "available 8" ];
then
	echo "Wrong Status"
	testPassed="no"	
else
	echo "Correct Status"
	
fi







echo "test testPassed" $testPassed



