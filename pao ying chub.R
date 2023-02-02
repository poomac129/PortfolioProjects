#Rock Paper Scissors (Pao Ying Chub in Thai) with R

pao_ying_chub <- function() {
  #print game rules
  cat("Game Starts!")
  user_hand <- 0
  user_point <- 0
  while(user_hand != 4) {
    hands <- c("rock","paper","scissors","to end the game")
    user_hand <- as.numeric(readline("Please select hand [1:rock, 2:paper, 3:scissors, 4: end the game]: "))
    verify = is.na(user_hand)
    if(verify==TRUE) {print("Please enter a valid response. (1,2,3,4)")
      user_hand<-0
    } else {
    if(user_hand<4) {
      cat("Player chooses ")
      cat(hands[user_hand])
      cat("\n")
      bot_hand <- sample(hands[1:3],1)
      cat("Bot chooses ")
      cat(bot_hand)
      cat("\n")
      if(user_hand==1 & bot_hand=="rock") {
        cat("TIE\n")
        cat("Your point(s): ")
        cat(user_point)
      }
      else if(user_hand==2 & bot_hand=="paper") {
        cat("TIE\n")
        cat("Your point(s): ")
        cat(user_point)
      }
      else if(user_hand==3 & bot_hand=="scissors") {
        cat("TIE\n")
        cat("Your point(s): ")
        cat(user_point)
      }
      else if(user_hand==1 & bot_hand=="scissors") {
        cat("WIN\n")
        user_point <- user_point + 1
        cat("Your point(s): ")
        cat(user_point)
      }
      else if(user_hand==1 & bot_hand=="paper") {
        cat("LOSE\n")
        cat("Your point(s): ")
        cat(user_point)
      }
      else if(user_hand==2 & bot_hand=="rock") {
        cat("WIN\n")
        user_point <- user_point + 1
        cat("Your point(s): ")
        cat(user_point)
      }
      else if(user_hand==2 & bot_hand=="scissors") {
        cat("LOSE\n")
        cat("Your point(s): ")
        cat(user_point)
      }
      else if(user_hand==3 & bot_hand=="paper") {
        cat("WIN\n")
        user_point <- user_point + 1
        cat("Your point(s): ")
        cat(user_point)
      }
      else if(user_hand==3 & bot_hand=="rock") {
        cat("LOSE\n")
        cat("Your point(s): ")
        cat(user_point)
      }
    }
     #end loop if
    else if(user_hand==4) {cat("See you next time!\n")}
    else {cat("Please enter a valid response. (1,2,3,4)")}
    }
  } #end loop while
  cat("Your point(s): ")
  cat(user_point)
  cat("\nEND")
}
