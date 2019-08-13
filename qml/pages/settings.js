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
