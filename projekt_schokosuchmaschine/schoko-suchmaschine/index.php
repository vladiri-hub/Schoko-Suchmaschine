<?php

# Projekt: Schokoladensuchmaschine

#

# Autor: Vladislav D. Dimitrov

# Stand: 11.04.2024



# Einbindung der Datenbankverbindung 
require 'dbconn.php';

# Variablen 
$schoko_id = @$_GET['schoko_id'];
$firma = filter_input(INPUT_GET, 'firma');

# Firma

if (isset($_POST['firma'])) {

	$firma = substr($_POST['firma'], 0, 50);
} else {

	$firma = '';
}




# Button
if (isset($_POST['button'])) {



	$button = substr($_POST['button'], 0, 50);
} else {

	$button = '';
}


# Suche wird gestertet
if ($button == 'suchen') {
}

?>



<!DOCTYPE html>

<html lang="en">

<head>

	<meta http-equiv="content-type" content="text/html; charset=utf-8">



	<title>Schokoladensuchmaschine</title>



	<style type="text/css">

		html{
			background: url('../schoko-suchmaschine/bilder/schoko_bgrd_3.jpg') no-repeat center center fixed;
			background-size: cover;
			
		}

		body {

			font-size: 1.1em;
			font-family: Palatino, "Palatino Linotype", serif;
			color: #333538;
			margin: 0px;
			padding: 20px;

			/* http://lea.verou.me/css3patterns */





			/* Pattern Ende */

		}

		h1 {
			font-size: 2em;
			font-weight: bold;
		}

		h2 {
			font-size: 1.6em;
			font-weight: bold;
		}

		h3 {
			font-size: 15pt;
			font-weight: bold;
		}

		#header {
			background-color: rgba(255, 211, 155, 0.94);
		}

		#content {
			min-height: 450px;
			background-color: rgba(255, 248, 220, 0.94);
		}

		/*.border { padding: 30px 10px 10px 20px; width: 800px; border: 1px solid rgb(189, 198, 215); border-radius: 6px; box-shadow: 3px 3px rgba(0, 0, 0, 0.1), 0px -2px rgb(229, 239, 248) inset; }*/

		.border {
			margin-left: auto;
			margin-right: auto;
			padding: 35px 40px 15px 40px;
			width: 80%;
			border: 1px solid rgb(189, 198, 215);
			border-radius: 20px;
			min-width: 400px;
			max-width: 900px;
		}

		label {
			display: block;
			width: 300px;
			margin-top: 10px;
		}

		#vorname,
		#nachname,
		#nachricht,
		#tage {
			display: block;
			width: 300px;
		}

		.wichtig {
			color: rgb(255, 85, 0)
		}

		.fett {
			font-weight: bold;
		}
	</style>



</head>

<body>



	<h1 id="header" class="border">Schokoladensuchmaschine</h1>



	<div id="content" class="border">




		<form action="<?php echo $_SERVER['SCRIPT_NAME'] ?>" method="post">
			
			<label for='firma'>Firmen</label>
			<select name='firma' id='firma'>
				<option value=''>Firma auswählen</option>
				<?php
				$sql = "SELECT marke_name FROM tb_marke";
				$result = mysqli_query($mysqli, $sql);
				while ($row = mysqli_fetch_assoc($result)) {
					echo '<option value="' . $row['marke_name'] . '">' . $row['marke_name'] . '</option>';
				}
				?>

			</select><br><br>

			<label class="form_label_checkbox" for='geschmack'>Geschmack</label>
			<?php
			$sql = "SELECT geschmack_id, geschmack FROM tb_geschmacksrichtung";
			$result = mysqli_query($mysqli, $sql);
			while ($row = mysqli_fetch_assoc($result)) {
				echo '<input class="form_checkbox" type="checkbox" name="geschmack_id[]" value="' . $row['geschmack_id'] . '">' . $row['geschmack'] . '<br>';
			}
			?>


			<br>

			<label for='kakaoanteil'>Kakaoanteil in %</label>
			<input type='range' id='kakaoanteil' name='kakaoanteil' min='-1' max='100' value='-1' step='1'>
			<p>Aktueller Wert: <span id="anzeiger"></span></p>



			<br>

			<button type="submit" name="button" value="suchen">Suchen</button>

		</form>
		<?php
		
		##### Informationen aus der DB holen #####


		# Schokoladensorten nach Anbieter durch Dropdown-Liste filtern
		if ($firma) {

			# SQL-Anweisung
			$sql = "SELECT * FROM tb_marke WHERE marke_name = '$firma'";
			$result = mysqli_query($mysqli, $sql);
			$row = mysqli_fetch_assoc($result);
			$marke = $row['marke_id'];
			mysqli_free_result($result);

			$sql = "SELECT DISTINCT schoko_name, links FROM tb_schokolade WHERE marke_id = $marke";

			$result = mysqli_query($mysqli, $sql);

			# Result Zeile für Zeile abrufen
			echo '<h3>Suche nach Firmennamen: '.$firma.'</h3>';
			echo '<ul>';

			while ($row = mysqli_fetch_assoc($result)) {

				echo '<li><a href="' . $row['links'] . '">' . $row['schoko_name'] . '</a></li>';
			}

			echo '</ul>';
		}

		# Schokoladensorten nach Geschmaksrichtungen durch Checkboxes filtern
		if (isset($_POST['geschmack_id'])) {
			
			$ausgewaehlt = implode("','", $_POST['geschmack_id']);
			$ausgewaehlt = "'" . $ausgewaehlt . "'";
			
			# SQL-Anweisung
			$sql = "SELECT DISTINCT tb_schokolade.links, tb_schokolade.schoko_name
				FROM tb_schokolade WHERE geschmack_id IN($ausgewaehlt)";
			$result = mysqli_query($mysqli, $sql);
			
						
			# Result Zeile für Zeile abrufen
			echo '<h3>Suche nach Geschmack:</h3>';
			echo '<ul>';
			while ($row = mysqli_fetch_assoc($result)) {
				echo '<li><a href="' . $row['links'] . '">' . $row['schoko_name'] . '</a></li>';
			}
			echo '</ul>';
			
		}

				
		# Schokoladensorten nach Kakaoanteil durch Slider filtern
		if (isset($_POST['kakaoanteil'])) {

			$kakaoanteil = $_POST['kakaoanteil'];

			#SQL-Anweisung
			$sql = "SELECT DISTINCT schoko_name, links FROM tb_schokolade WHERE kakaoanteil>=0 AND kakaoanteil<=$kakaoanteil";
			$result = mysqli_query($mysqli, $sql);

			# Result Zeile für Zeile abrufen
			if ($kakaoanteil >= 0) {	
			echo '<h3>Suche nach Kakaoaneil: bis zu '. $kakaoanteil . '%</h3>';
			echo '<ul>';
			while ($row = mysqli_fetch_assoc($result)) {
							
					echo '<li><a href="' . $row['links'] . '">' . $row['schoko_name'] . '</a></li>';
				}
			echo '</ul>';
			
			
			mysqli_free_result($result);
			}	
		}
		?>

	</div>

	# JS-Script
	<script>
		var slider = document.getElementById("kakaoanteil")
		var output = document.getElementById("anzeiger")
		if (slider.value < 0) {
			output.innerHTML = '';
		} else {
			output.innerHTML = slider.value;
		}

		slider.oninput = function() {
			output.innerHTML = this.value;
		}
	</script>

</body>

</html>