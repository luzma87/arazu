/**
 * Created by luz on 02/07/15.
 */

var dbName = "arazu";
var dbDesc = "arazu";
var jdb = {};
jdb.db = null;

var jdbTablas = {
    asistencia : {
        id                : "ID",
        fecha             : "DATETIME",
        fechaRegistro     : "DATETIME",
        tipoAsistencia    : "INTEGER",
        horas50           : "INTEGER",
        horas100          : "INTEGER",
        empleado          : "INTEGER",
        registra          : "INTEGER",
        desayuno          : "INTEGER",
        almuerzo          : "INTEGER",
        merienda          : "INTEGER",
        proyecto          : "INTEGER",
        desayunosInvitado : "INTEGER",
        almuerzosInvitado : "INTEGER",
        meriendasInvitado : "INTEGER",
        enviadoServidor   : "INTEGER"
    }
};

jdb.init = function () {
    jdb.open();
    jdb.createTableAsistencia();
};

jdb.open = function () {
    var dbSize = 5 * 1024 * 1024; // 5MB
    jdb.db = openDatabase(dbName, "1.0", dbDesc, dbSize);
};

jdb.createTableAsistencia = function () {
    var db = jdb.db;
    db.transaction(function (tx) {
        $.each(jdbTablas, function (key, value) {
            var i = 0;
            var sql = "";
            sql += "CREATE TABLE IF NOT EXISTS " + key + "(";
            $.each(value, function (ke, va) {
                if (i > 0) {
                    sql += ", ";
                }
                sql += ke;
                if (va == "ID") {
                    sql += " INTEGER PRIMARY KEY ASC";
                } else {
                    sql += " " + va;
                }
                i++;
            });
            sql += ")";
            tx.executeSql("DROP TABLE " + key, []);
            tx.executeSql(sql, []);
        });
        //tx.executeSql("CREATE TABLE IF NOT EXISTS asistencia(ID INTEGER PRIMARY KEY ASC, fecha DATETIME, fechaRegistro DATETIME, tipoAsistencia TEXT, horas50 INTEGER, horas100 INTEGER, empleado INTEGER, registra INTEGER, desayuno TEXT, almuerzo TEXT, merienda TEXT, proyecto INTEGER, desayunosInvitado INTEGER, almuerzosInvitado INTEGER, meriendasInvitado INTEGER, enviadoServidor INTEGER)", []);
    });
};

jdb.onError = function (tx, e) {
    alert("Ha ocurrido un error: " + e.message);
};

jdb.onSuccess = function (tx, r) {
    // re-render the data.
    alert("SUCCESS!!");
};

jdb.addAsistencia = function (idPersona, fecha, asiste) {

};

jdb.addHoraExtra = function (idPersona, fecha, cant50, cant100) {

};

jdb.addComidaPersona = function (idPersona, fecha, comida, comio, idRegistra) {
    var db = jdb.db;
    fecha = fecha.setHours(0, 0, 0);
    db.transaction(function (tx) {
        tx.executeSql("SELECT * FROM asistencia WHERE id=? AND fecha=? ", [idPersona, fecha],
            function (tx, rs) {
                //console.log("OK: ", tx, rs);
                if (rs.rows.length == 0) {
                    db.transaction(function (tx) {
                        tx.executeSql("INSERT INTO asistencia(fecha, fechaRegistro, tipoAsistencia, empleado, registra, almuerzo, enviadoServidor) VALUES (?, ?, ?, ?, ?, ?, ?)",
                            [new Date(), new Date(), "ASTE", idPersona, idRegistra, 1, 0],
                            jdb.onSuccess,
                            jdb.onError);
                    });
                }
            },
            jdb.onError);
    });
};

jdb.addComidaInvitado = function (idProyecto, fecha, comida, cantidad) {

};