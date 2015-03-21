<?php
class Castle {
// Class Constructor
public function __construct() {
	$this->gold = 200;
	$this->wood = 500;
	$this->stone = 100;
	$this->i = 1;
$this->player_id = 2;
$this->resGatheredAt = '2014-01-01';
}

public function upd_Res()
{
	$d = new PDO('mysql:host=127.0.0.1;dbname=game', 'db_user', 'db_pass');
	$query='SELECT NOW()';
	$stm=$d->query($query);// Run the query to the database
	$today=$stm->fetch(PDO::FETCH_COLUMN);
	$passed_time_in_seconds=strtotime($today)-(strtotime($this->resGatheredAt));
	$g=1*$passed_time_in_seconds;$w=1*$passed_time_in_seconds;
	$s=1*$passed_time_in_seconds;
	$q='UPDATE castles SET gold = gold + :i_gold, wood = wood + :i_wood; stone = stone + :i_stone WHERE id = ' . $this->i;
	$stm = $d->prepare($q);
	$stm->bindParam('i_gold', $g);
	$stm->bindParam('i_wood', $w);
	$stm->bindParam('i_stone',$s);
	$stm->execute(); // Run update query of the castles
	$this->gold+=$g;
	$this->wood+=$w;
	$this->stone+=$s;

	return true;
}

public function progressCastle($level) {
if ($this->gold > 150 && $this->wood > 100 && $this->stone > 50){
$db = new PDO('mysql:host=127.0.0.1;dbname=game', 'db_user', 'db_pass');
$query='UPDATE castles SET level = :i_level WHERE id = ' . $this->i;
$stm=$d->prepare($query);
$stm->bindParam('i_level', $level);
$stm->execute();

// Increment the player experience
$query = 'UPDATE players SET exp = exp + 1000 WHERE id = ' . $this->player_id;
$stm = $d->query($query);
return true;
}
return false;
}

public function destroy()
{
	$db = new PDO('mysql:host=127.0.0.1;dbname=game', 'db_user', 'db_pass');
	$query = 'DELETE FROM castles WHERE id = '.$this->i;
	$db->query($query);
}
}
