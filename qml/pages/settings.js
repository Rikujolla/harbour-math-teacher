function saveSettings() {

    var db = LocalStorage.openDatabaseSync("MathDB", "1.0", "Chess database", 1000000);

    db.transaction(
                function(tx) {
                    // Create the table, if not existing
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Settings(name TEXT, subname TEXT, valte TEXT, valre REAL, valint INTEGER)');

                    // player_name
                    var rs = tx.executeSql('SELECT * FROM Settings WHERE name = ?', 'player_name');
                    //if (rs.rows.length > 0) {tx.executeSql('UPDATE Settings SET valte=? WHERE name=?', [player_name, 'player_name'])}
                    if (rs.rows.length > 0) {tx.executeSql('INSERT INTO Settings VALUES(?, ?, ?, ?, ?)', [ 'player_name', '', player_name, '', '' ])}
                    // If no players add active player
                    else {tx.executeSql('INSERT INTO Settings VALUES(?, ?, ?, ?, ?)', [ 'player_name', 'active', player_name, '', '' ])}

                }
                )

}

function deletePlayer(_player) {

    var db = LocalStorage.openDatabaseSync("MathDB", "1.0", "Chess database", 1000000);

    db.transaction(
                function(tx) {
                    // Create the table, if not existing
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Settings(name TEXT, subname TEXT, valte TEXT, valre REAL, valint INTEGER)');
                    var rs = tx.executeSql('SELECT * FROM Settings WHERE name = ? AND subname = ? AND valte = ?', ['player_name', 'active', _player]);
                    if (rs.rows.length > 0) {
                        player_name = "Horse rider";
                        coins = 0;
                        level_points = 0;
                        level = 0;
                        questions_count = 4;
                    }
                    // player_name
                    tx.executeSql('DELETE FROM Settings WHERE subname = ? OR valte = ?', [ _player, _player ])
                }
                )

}
function loadSettings() {

    var db = LocalStorage.openDatabaseSync("MathDB", "1.0", "Chess database", 1000000);

    db.transaction(
                function(tx) {
                    // Create the table, if not existing
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Settings(name TEXT, subname TEXT, valte TEXT, valre REAL, valint INTEGER)');

                    // player_name
                    var rs = tx.executeSql('SELECT * FROM Settings WHERE name = ? AND subname = ?', ['player_name', 'active']);
                    if (rs.rows.length > 0) {player_name = rs.rows.item(0).valte}
                    else {}
                    // coins
                    rs = tx.executeSql('SELECT * FROM Settings WHERE name = ? AND subname = ?', ['coins', player_name]);
                    if (rs.rows.length > 0) {coins = rs.rows.item(0).valint}
                    else {coins = 0}
                    // level_points
                    rs = tx.executeSql('SELECT * FROM Settings WHERE name = ? AND subname = ?', ['level_points', player_name]);
                    if (rs.rows.length > 0) {level_points = rs.rows.item(0).valint}
                    else {level_points = 0}
                    // level
                    rs = tx.executeSql('SELECT * FROM Settings WHERE name = ? AND subname = ?', ['level', player_name]);
                    if (rs.rows.length > 0) {level = rs.rows.item(0).valint}
                    else {level = 0}


                }

                )

}

function loadPlayers() {

    var db = LocalStorage.openDatabaseSync("MathDB", "1.0", "Chess database", 1000000);

    db.transaction(
                function(tx) {
                    // Create the table, if not existing
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Settings(name TEXT, subname TEXT, valte TEXT, valre REAL, valint INTEGER)');

                    // player_name
                    var rs = tx.executeSql('SELECT * FROM Settings WHERE name = ?', ['player_name']);
                    //if (rs.rows.length > 0) {player_name = rs.rows.item(0).valte}
                    //else {}
                    players.clear();
                    for (var i = 0;i < rs.rows.length;i++) {
                        players.set(i,{"player":rs.rows[i].valte})
                    }
                }
                )
}

function updateActivePlayer(_player_ind) {

    var db = LocalStorage.openDatabaseSync("MathDB", "1.0", "Chess database", 1000000);

    db.transaction(
                function(tx) {
                    // Create the table, if not existing
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Settings(name TEXT, subname TEXT, valte TEXT, valre REAL, valint INTEGER)');

                    tx.executeSql('UPDATE Settings SET subname=? WHERE name=?', ['', 'player_name'])
                    tx.executeSql('UPDATE Settings SET subname=? WHERE name=? AND valte = ?', ['active', 'player_name', player_name])
                }
                )
}

function saveCoins() {

    var db = LocalStorage.openDatabaseSync("MathDB", "1.0", "Chess database", 1000000);

    db.transaction(
                function(tx) {
                    // Create the table, if not existing
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Settings(name TEXT, subname TEXT, valte TEXT, valre REAL, valint INTEGER)');
                    var rs = tx.executeSql('SELECT * FROM Settings WHERE name = ? and subname = ?', ['coins', player_name]);
                    if (rs.rows.length > 0) {
                        tx.executeSql('UPDATE Settings SET valint=? WHERE name=? AND subname =?', [coins, 'coins', player_name])
                    }
                    else {
                        tx.executeSql('INSERT INTO Settings VALUES(?, ?, ?, ?, ?)', [ 'coins', player_name, '', '', coins ])
                    }
                }
                )
}

function saveLevelPoints() {

    var db = LocalStorage.openDatabaseSync("MathDB", "1.0", "Chess database", 1000000);

    db.transaction(
                function(tx) {
                    // Create the table, if not existing
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Settings(name TEXT, subname TEXT, valte TEXT, valre REAL, valint INTEGER)');
                    var rs = tx.executeSql('SELECT * FROM Settings WHERE name = ? and subname = ?', ['level_points', player_name]);
                    if (rs.rows.length > 0) {
                        tx.executeSql('UPDATE Settings SET valint=? WHERE name=? AND subname =?', [level_points, 'level_points', player_name])
                    }
                    else {
                        tx.executeSql('INSERT INTO Settings VALUES(?, ?, ?, ?, ?)', [ 'level_points', player_name, '', '', level_points ])
                    }

                    rs = tx.executeSql('SELECT * FROM Settings WHERE name = ? and subname = ?', ['level', player_name]);
                    if (rs.rows.length > 0) {
                        tx.executeSql('UPDATE Settings SET valint=? WHERE name=? AND subname =?', [level, 'level', player_name])
                    }
                    else {
                        tx.executeSql('INSERT INTO Settings VALUES(?, ?, ?, ?, ?)', [ 'level', player_name, '', '', level ])
                    }

                }
                )
}
