extends CanvasLayer

func update_level_label(level : int):
	$LevelLabel.text = str(level)

func update_score(score : float):
	$ScoreLabel.text = "Score: " + str(int(score))
