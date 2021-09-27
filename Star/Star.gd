extends Area2D

func _ready():
    pass # Replace with function body.



func _on_Star_body_entered(body):
    get_parent().get_star()
    hide()
    call_deferred("queue_free")
