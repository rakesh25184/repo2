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



#customer 201 requests a ride
rideId1=$(curl -s http://localhost:8081/requestRide?custId=201\&sourceLoc=2\&destinationLoc=10)
if [ "$rideId1" != "-1" ];
then
	echo "Ride by customer 201 started"
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
rideId2=$(curl -s http://localhost:8081/requestRide?custId=201\&sourceLoc=2\&destinationLoc=10)
if [ "$rideId2" != "-1" ];
then
	echo "Ride by customer 201 started"
	testPassed="no"
else
	echo "Ride to customer 201 denied"
	
fi


#customer 201 end ride
rideId=$(curl -s http://localhost:8080/rideEnded?cabId=101\&rideId=$rideId2)
#echo $rideId
if [ "$rideId" != "true" ];
then
	echo "Not an ongoing ride"
	
else
	echo "Ride ended cab 101"
	testPassed="no"
	
fi



#customer 201 requests a ride
rideId3=$(curl -s http://localhost:8081/requestRide?custId=201\&sourceLoc=2\&destinationLoc=10)
if [ "$rideId3" != "-1" ];
then
	echo "Ride by customer 201 started"
else
	echo "Ride to customer 201 denied"
	testPassed="no"
fi


#customer 201 end ride
rideId=$(curl -s http://localhost:8080/rideEnded?cabId=101\&rideId=$rideId3)

if [ "$rideId" != "false" ];
then
	echo "Ride by cab 101 customer 201 ended"
else
	echo "Ride to cab 101 customer 201 didn't end "
	testPassed="no"
fi


echo "test testPassed" $testPassed



