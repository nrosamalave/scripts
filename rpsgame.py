from getpass import getpass as input

print("""Ready to play rock, paper, scissors?
When playing, please utilize R,P, and S to make it easier!""")

counterP1 = 0
counterP2 = 0
while True:
  player_1 = input("Player 1, do you choose rock, paper, or scissors? ")
  player_2 = input("Player 2, do you choose rock, paper, or scissors? ")

  if player_1 == "r":
    if player_2 == "r":
      print("The game is a tie!")
    elif player_2 == "p":
      counterP2 += 1
      print("Player 2 wins this round!")
    elif player_2 == "s":
      counterP1 += 1
      print("Player 1 wins this round!")
    else:
      print("Player 2 did not provide a valid option...")
  elif player_1 == "p":
    if player_2 == "r":
      counterP1 += 1
      print("Player 1 wins this round!")
    elif player_2 == "p":
      print("The game is a tie!")
    elif player_2 == "s":
      counterP2 += 1
      print("Player 2 wins this round!")
    else:
      print("Player 2 did not provide a valid option...")
  elif player_1 == "s":
    if player_2 == "r":
      counterP2 += 1
      print("Player 2 wins this round!")
    elif player_2 == "p":
      counterP1 += 1
      print("Player 1 wins this round!")
    elif player_2 == "s":
      print("The game is a tie!")
    else:
      print("Player 2 did not provide a valid option...")
  else:
    print("Player 1 did not provide a valid option...")
    continue

  print("Player 1 has", counterP1, "wins")
  print("Player 2 has", counterP2, "wins")

  if counterP1 or counterP2 == 3:
    print("Thanks for playing!")
    exit()
  else:
    continue