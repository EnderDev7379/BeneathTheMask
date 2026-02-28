using Godot;
using System;

public partial class Player : Sprite2D
{
	int HELTH;
	int V;
	int a;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		HELTH = 100;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
