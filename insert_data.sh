#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi


# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
    TEAM1=$WINNER
    TEAM2=$OPPONENT

    if [[ $TEAM1 != "winner" ]]
    then
       VEC_TEAM1=$($PSQL "select name from teams where name = '$TEAM1'")
       VEC_TEAM2=$($PSQL "select name from teams where name = '$TEAM2'")
       
       if [[ -z $VEC_TEAM1  ]] 
       then
         INSERT_TEAM1=$($PSQL "INSERT INTO teams(name) VALUES ('$TEAM1')")
       else
         echo "existe deja"
       fi

       if [[ -z $VEC_TEAM2  ]] 
       then
         INSERT_TEAM2=$($PSQL "INSERT INTO teams(name) VALUES ('$TEAM2')")
        else
         echo "existe deja"
       fi
       
    fi


done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
        
      if [[ $WINNER != "winner" ]]
      then
        
        W=$($PSQL "select team_id from teams where name = '$WINNER'")
        O=$($PSQL "select team_id from teams where name = '$OPPONENT'")

        INSERT=$($PSQL "INSERT INTO games(year,round,winner_goals,opponent_goals,opponent_id,winner_id) VALUES($YEAR,'$ROUND',$WINNER_GOALS,$OPPONENT_GOALS,$O,$W)")

      fi


done