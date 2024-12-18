<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
// Define the database name from the environment variable
//define('DB_NAME', getenv('MYSQL_DATABASE'));
// ** Database settings - You can get this info from your web host ** //

/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'forwordpress' );

/** Database password */
define( 'DB_PASSWORD', '123');

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );


/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '4|UpQ2JV.bQ4S#`IbM[d`Ih*yDJ`;t6!63<;dVL;MS#*crh>g@7~]Tg^4W~mxOUk' );
define( 'SECURE_AUTH_KEY',  'z=1>);5yRoLP4XW%j@,^JtHPl;2PxeBABNn2!k2Ipz#,B#`8eEheFzb_v`W~%|m>' );
define( 'LOGGED_IN_KEY',    'YUskHrX;C~/bV*?C%WaJioeBCZC5sKfS$zdf6mV</9r_Tzv,T6a~`kAd]&?K`gY6' );
define( 'NONCE_KEY',        '2NAso-Q7XN7G/_j_hZkR[wX8*+<D>^W$#B.4Q3Um@K/+X1*_X[Ivgng>|BDB]V@q' );
define( 'AUTH_SALT',        'J8Q<bA}fR=~`]NWwA#xfJTqCK}5:]IJ2<e[j;K]<#1w6pz]>]0ip(MpoN.{/?9q,' );
define( 'SECURE_AUTH_SALT', '*y/.1oF;lS;M9 wybTt+y`?(wEcVO)u7,;Q]k`qUbUF:Zl7>f/2}&c1i;`5`>k5V' );
define( 'LOGGED_IN_SALT',   '.F%sPNb8`>JFhayDfD^!b}E,X{F/$w_r;9d+s8tLIl:2yPTQVXnL_}}l(Ze}/8BB' );
define( 'NONCE_SALT',       '#5.zh{qv}RD56B6?R;6NR>#Mull$$ 9&}^.2?/5 iKG78&fa2VqQH>?jjt4Z/L11' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', true );
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', true);

/* Add any custom values between this line and the "stop editing" line. */

define('WP_CACHE', true);
define('WP_REDIS_CLIENT', 'phpredis'); // or 'predis' (PHP library)
define('WP_REDIS_HOST', 'redis');  // Redis server IP (use localhost if running Redis on the same server)
define('WP_REDIS_PORT', 6379);         // Redis server port
define( 'WP_REDIS_DATABASE', 0 );
define( 'WP_REDIS_PLUGIN_PATH', '/usr/share/nginx/html/wp-content/plugins/redis-cache-2.5.0' );
#define('WP_REDIS_PASSWORD', 'your_secure_password_here');  // If you've set a password

// reasonable connection and read+write timeouts
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
