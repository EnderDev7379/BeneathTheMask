extends ShapeCast2D



@onready var textBox = $"../../CanvasLayer/DialogueBox/Label";
@onready var player: CharacterBody2D = $".."
@onready var raycast: ShapeCast2D = $".";


var interaction_stage = 0;

const dialogues: Array[Array] = [
	[
"Zdravo spasioče,  hvala ti što možeš da nam pomogneš.",
"Zdravo, oćeš na kafu.",
"Šta si došao kod nas? Zar ne znaš da dolazi propast u ovo selo, odlazi odavde!!!"
	],
	[
"Zdrav0 spasioče, hvala ti što možeš da nam pomogneš.",
"Šta si došao u ovo selo da nam daješ lažnu nadu, odlazi odavde!!!",
"Zdravo lepotice, nadam se da si dobro i da uživaš u našem selu pre nego što nestane."
	]
];

const descriptions: Array[Array] = [
	[
"Ovaj čovek je seljak, radi ceo dan u njivi ima ženu i dve mačke. 
Resurs koji donosi su žitarice.",
"Ovaj čovek je žena od seljaka, oni zajedno žive sa dve mačke. Ona takođe zna da kuva.
Resurs koji donosi je spremanje hrane.",
"Ovaj čovek je stara baba koja ima farmu kokoški.
Resurs koji donosi su kokoške i njihova jaja.",
"Ovaj čovek je star, on je bolestan, ali ima bunar vode.
Resurs koji donosi je voda.",
"Ovaj čovek je mlad i ujak mu je Tesla.
Resurs koji donosi je struja.",
"Ovaj čovek je riba. Treba mu voda.",
"Ovaj čovek je ribar, on lovi ribu.
Resurs koji donosi je riba i morski plodovi.",
"Ovaj čovek je voćar, on gaji razno voće i ima sina Janka.
Resurs koji donosi su voće i Janko.",
"Ja sam sin Janko, moji ljubimci su ptice koje lete kroz očev voćnjak.",
"Ovaj čovek je mesar u selu, hrani okolne mačke lutalice.
Resurs koji donosi je meso.",
"Ovaj čovek ima problem jer mu lisica stalno ubija živinu.
Resurs koji donosi je preživela živina.",
"Ovaj čovek ima tiho jezero iza kuće. Kaže da voda pamti sve.",
"Ovaj mladi mehaničar ume da pokrene i pokvareni agregat.
Resurs koji donosi je mogućnost popravljanja pokvarenog.",
"Ovaj čovek je besan pekar jer ljudi ne vole njegovu pekaru.
Resurs koji donosi su peciva iz njegove pekare.",
"Ovaj čovek je žena koja zna da napravi kombinaciju trava, koje kad se zapale opuštaju ljude.
Resurs koji donosi su trave za opuštanje.",
"Ovaj čovek je policajac i on zna ko su dileri u selu.
Resurs koji donosi je red i mir.",
"Ovaj čovek je sveštenik. Očistiće ti dušu od greha sa molitvom.
Resurs koji donosi je vera u Boga i sveće.",
"Ovaj čovek je detektiv koji sumnja na šumara.
Resurs bolji mozak nego ti.",
"Ovaj čovek je trgovac koji prodaje slatkiše.
Resurs koji donosi su slatkiši.",
"Ovaj čovek krade od kleptomanijaka i daje siromašnima.",
"Ovaj čovek nema smisla. On ne zna ništa. Možete da ne izaberite njega.",
	],
	[
"Ovaj čovek je žena od seljaka, oni žive zajedno sa dva psa. Ona takođe zna da kuva.
Resurs koji donosi je spremanje hrane.",

"Ovaj čovek je stari mlekar sa desert krava.
Resurs koji donosi su paradajz i krastavac.",

"Ovaj čovek je kanibal, ali on je doktor.
Resurs koji donosi je da te i leči i jede.",

"Ovaj čovek je star, on nike verovao u fiziku i testirao zakon gravitacije i kao posledica nastradala je od jednog seljaka krava.
Resurs koji donosi je ljubav prema fizici.",

"Ja sam ćerka Janko, mnogo volim svog psa.",

"Ovaj čovek je dobio besnilo od lisice.",

"Ovaj čovek neće da plati pekaru jer je hleb bajat.",

"Ovaj čovek je policajac koji pomaže čoveku sa travama da ih dovede do svojih kupaca.
Resurs koji donosi su red i mir, kontakt od gospodina sa travama.",

"Ovaj čovek je gospodin sa travama koji tačno zna koja ti vrsta trave treba. Njegove trave leče mozak.
Resurs koji donosi su perece.",

"Ovaj čovek je šumar u šumi u kojoj nestaju ljudi, on pokušava da ih nađe.",

"Ovaj čovek je pokeraš koji svoje pare daje u dobrotvorne svrhe.
Resurs koji donosi su pare.",

"Ovaj čovek je banker u selu, ali ne zna gde je banka.
Resurs koji donosi je demencija.",

"Ovaj čovek je gospodin čekanja, verovatno beskoristan.",

"Ovaj čovek kaže da trgovac prodaje otrovane slatkiše.",

"Ovaj čovek je kleptomanijak.
Resurs koji donosi su ukradene životinje. ",

"Ovaj čovek sveštenik koji crta interesantne krogove.
Resurs koji donosi je sveta piće.",

"Ovaj čovek je sedeo sa detektivom u policijskoj stanici.",

"Ovaj čovek je profesor hemije, njegovo ime je Wolter White.",

"Ovaj čovek će ti seen-ovati poruke.",

"Ovaj čovekne voli gospodina Ribu.",

"Ovaj čovek se preselio u selo jer je ubio čoveka.
Resurs koji donosi je mrtvo telo."
	]
];

const dialogues_repeated: Array[String] = [
"Немамо о чему више да причамо.",
"Већ сам све рекао. Приђите другима.",
"Лепо смо разговарали."
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interaction"):
		if (get_tree().paused):
			interaction_stage += 1
			get_tree().paused = false;
		if raycast.is_colliding():
			var collider: Node = raycast.get_collider(0);
			if collider.get_parent() == $"../../Npcs":
				$"../../CanvasLayer/DialogueBox".visible = true;
				if (collider.get_meta("interacted")):
					if (interaction_stage == 0):
						textBox.text = dialogues_repeated[randi_range(0, 2)];
					else:
						interaction_stage = 0;
						$"../../CanvasLayer/DialogueBox".visible = false;
						return;
				else:
					if (interaction_stage == 0):
						textBox.text = dialogues[collider.get_meta("type")][randi_range(0, 2)];
					elif (interaction_stage == 1):
						textBox.text = descriptions[collider.get_meta("type")][collider.get_meta("id")];;
					elif (interaction_stage == 2 && collider.get_meta("type") != 2):
						textBox.text = "Da li da spasiš ovu osobu?\n(E = da, Q = ne)"
					else:
						if (collider.get_meta("type") == 0):
							player.set_meta("good_accepted", player.get_meta("good_accepted") + 1);
						elif (collider.get_meta("type") == 1):
							player.set_meta("bad_accepted", player.get_meta("bad_accepted") + 1);
						interaction_stage = 0;
						collider.set_meta("interacted", true);
						$"../../CanvasLayer/DialogueBox".visible = false;
						return;
				get_tree().paused = true;
	
	if Input.is_action_just_pressed("UnInteraction"):
		if (interaction_stage == 2):
			get_tree().paused = false;
			interaction_stage = 0;
			raycast.get_collider(0).set_meta("interacted", true);
			$"../../CanvasLayer/DialogueBox".visible = false;
			return;
