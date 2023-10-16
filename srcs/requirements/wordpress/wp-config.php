<?php

/** The name of the database for WordPress */
define('DB_NAME', '$MYSQL_DATABASE');

/** MySQL database username */
define('DB_USER', '$MYSQL_USER');

/** MySQL database password */
define('DB_PASSWORD', '$MYSQL_USER_PASSWD');

/** MySQL hostname */
define('DB_HOST', '$MYSQL_HOST');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

define('AUTH_KEY',         '7;jiiCb0I-NyF%g>/r(e07JgbRpMaGsR_fzk@Meh+:4Tx%d,FJY7fGPWDD{c%BxX');
define('SECURE_AUTH_KEY',  'aC,VN^TZ>kZ=TB|~@K9}rauU?qgd|DTCntV=Z:B-m)F5<)--5E<X|mT>L2)NfT:*');
define('LOGGED_IN_KEY',    'lK|p!sac8lA7<z+61YW346z${|;Crg)T.+u-).U#?2++Sw;K@q1Y|_9jg@-Z,yoI');
define('NONCE_KEY',        ':SL+_:lm}Z|f}>ntz@+4:0%M$+TG,gvBp&Q$zuPTi#v(HeB(Z-q>u[ZgtH74N|*f');
define('AUTH_SALT',        '.#jO36 ~SYcV5Q<qQH2!|+dxcGCH~ /th]QLItx_b5]F.d{&WFZ}-~L,<KU:<46b');
define('SECURE_AUTH_SALT', '?5}8O.wII=xxm;p^+Zsvj}B)m340SU`WK`b+5;Y@--)3F9%VYN=h|GY(U[[TH7z`');
define('LOGGED_IN_SALT',   '?_/Z:V5uOiW7$+VkbNnv%gd+&ljUe&W4yB0FE5} d1~|r9ZQ~+O$@He|IGbBe3[L');
define('NONCE_SALT',       'yk*5gp|Gtp-?EYdpjcke_WsY.cAb_3$e<,fO)3/KA:Q5`:m[IXIS;~t-D+$EsfW-');

$table_prefix  = 'wp_';

define('WP_DEBUG', false);

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
