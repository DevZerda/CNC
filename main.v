import net
import net.http

const (
	Red = '\x1b[31m'
	Yellow = '\x1b[33m'
	Blue = '\x1b[34m'
	Purple = '\x1b[95m'
	Green = '\x1b[32m'
	Cyan = '\x1b[96m'
	Black = '\x1b[30m'
	Grey = '\x1b[90m'
	Reset = '\x1b[39m'
	Background_Red = '\x1b[41m'
	Background_Green = '\x1b[42m'
	Background_Grey = '\x1b[100m'
	Background_Reset = '\x1b[49m'
	Clear = '\033[2J\033[1;1H'
	hostname = '\x1b[96m[\x1b[31mproject\x1b[96m@\x1b[31mvNet\x1b[96m]\x1b[31m#~ '
)

pub fn main() {
    mut sv := net.listen_tcp(345) ?
    println('Listening On Port 1234')
    for {
        mut conn := sv.accept() ?
        conn.write_str('Username: ') ?
        conn.wait_for_read() ?
        usrn := conn.read_line().replace('\r\n', '')
        conn.write_str('Password: ') ?
        conn.wait_for_read() ?
        passwd := conn.read_line().replace('\r\n', '')
        println('$usrn | $passwd')
		conn.write_str('\033[2J\033[1;1H') ?
        conn.write_str(login(usrn, passwd) + '$hostname') ?
        for {
                conn.wait_for_read() ?
                data := conn.read_line()
                if data.contains('geo') {
                    conn.write_str(response.text + '\r\n$hostname ') ?
				} else if data.contains('scan') {
					
                } else {
                        conn.write_str('$hostname') ?
                }
                println('User Info: ' + data.replace('\r\n', ''))
        }
    }
}

fn login(u string, p string) (string) {
	get_user := 
    if u == 'Jeff' && p == 'test123' {
            mottd := motd()
            bnnr := banner()
            return '$mottd $bnnr\r\nsuccessfully loggedin. Welcome: $u \r\n'
    } else {
            return 'wrong info'
    }
}
///////////////////////
//FUNCTIONS FOR TOOLS
///////////////////////

fn GeoIP(ip string) (string) {
	geo_response := http.get('https://CodeTheWorld.xyz/tools/?action=geoip&q=' + ip) or {
		println('Failed to get geo')
	}

	return geo_response
}

////////////////////
//CRUD SECTION
////////////////////

fn get_user(usr string) (string, string, string, string, string, string) {

        mut db_check := false
        mut db_usr := ''
        mut db_ip := ''
        mut db_pw := ''
        mut db_level := ''
        mut db_maxtime := ''
        mut db_admin := ''

        //Grab User from DB!

        read_db := os.read_lines('users.db') or {
                return 'failed', 'failed', 'failed', 'failed', 'failed', 'failed'
        }
        for ussr in read_db {
                if ussr.contains('(\'' + usr + '\',\'') {
                        fix := ussr.replace('(\'', '')
                        fix2 := fix.replace('\')', '')
                        info := fix2.split('\',\'')
                        db_check = true
                        db_usr = info[0]
                        db_ip = info[1]
                        db_pw = info[2]
                        db_level = info[3]
                        db_maxtime = info[4]
                        db_admin = info[5]
                }
        }

        return db_usr, db_ip, db_pw, db_level, db_maxtime, db_admin
}

fn log_session() string {
	w_db := open('db/users.db')

}

////////////////////
//BANNERS
////////////////////

fn motd() (string) {
	mut motd_b := '$Red      ╔═════════════════════════════════════════════════════════════════╗\r\n'
	motd_b += '      ║    $Cyan [MOTD]: $Red                                                    ║\r\n'
	motd_b += '      ╚═════════════════════════════════════════════════════════════════╝\r\n'
	return motd_b
}

fn banner() (string) {
	mut gay := ''
	gay += '$Red                           $Cyan CodeTheWorld.xyz/discord $Red\r\n'
	gay += '                       ╔═══════════════════════════════╗\r\n'
	gay += '   ╔════════════╦══════╣          ╔═╗╔╦╗╦ ╦            ╠══════╦════════════╗\r\n'
	gay += '   ║    eZy     ║      ║          ║   ║ ║║║            ║      ║    Draco   ║\r\n'
	gay += '   ║            ║      ║          ╚═╝ ╩ ╚╩╝      v1.00 ║      ║            ║\r\n'
	gay += '   ║            ║     ═╩═╦══════╦═════════════╦══════╦═╩═     ║            ║\r\n'
	gay += '   ║            ║        ║      ║             ║      ║        ║            ║\r\n'
	gay += '   ║            ╚════════╝      ║             ║      ╚════════╝            ║\r\n'
	gay += '   ║  Discord: eZy [CTW]#9374   ║             ║   Discord: draco#3024      ║\r\n'
	gay += '   ║  Insta: @Prerooted         ║             ║   Insta:  @bizivix         ║\r\n'
	gay += '   ╚════════════════════════════╝             ╚════════════════════════════╝\r\n'
	return gay
}


