Feature: Ruby-Pomodoro should time my event

  As a GTDist
  I want to track my time
  So that I can be more efficient

 Scenario: Starting Pomodoro
  Given that I am starting a new Pomodoro
  When I start a new tomato
  Then I should see "Starting New Pomodoro"
  And I should see "Timer"

  # Scenario: end game
  #  Given that I am playing
  #  When I commit my final roll
  #  Then I should see "This is it mate"
