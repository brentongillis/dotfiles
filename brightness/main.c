/**
 * CLI program to adjust my brightness setting. My Dell XPS 15 has hybrid graphics, so I have
 * to use modesetting (this breaks xbacklight). This programs simply reads the brightness and
 * max_brightness files from /sys/class/backlight/intel_backlight/ and makes adjustments on them.
 *
 * NOTE: for this to work without sudo or root, this has to be a binary, which is why I'm not
 * using plain bash. One should change the binaries owner to root and then set the uid bit.
 * chmod u+s brightness
 *
 * Copyright (C) 2020 Brenton Gillis
 */

#include <stdlib.h>
#include <getopt.h>
#include <limits.h>
#include <stdio.h>
#include <errno.h>

#define VERSION "1.1.0"
#define MAX_BRIGHTNESS "/sys/class/backlight/intel_backlight/max_brightness"
#define BRIGHTNESS "/sys/class/backlight/intel_backlight/brightness"
#define TRUE 1
#define FALSE 0
/* #define STEP 1 */
#define STEP 50

// PROTOTYPES - It is nice to see all functions in one glance
static void parse_args(int argc, char *argv[]);
static int parse_int(char *arg);
static void usage(char *prog_name);
static int read_initial_brightness(int *max, int *old);
static int read_brightness(char *filename);
static void write_brightness(char *filename, int value);

static const char *opt_string = "hvs:idoV?";
static const struct option long_options[] = {
	{"help",	no_argument,		0, 'h'},
	{"version",	no_argument,		0, 'v'},
	{"set",	required_argument,		0, 's'},
	{"inc",		no_argument,		0, 'i'},
	{"dec",		no_argument,		0, 'd'},
	{"off",		no_argument,		0, 'o'},
	{"verbose", no_argument,		0, 'V'},
	{0, 0, 0, 0}
};

static const char *VERSION_MSG = "Copyright (C) 2022 Brenton Gillis\n";

typedef struct {
	int set;
	int inc;
	int dec;
	int off;
	int verbose;
} arguments;

static arguments argp = {-1, FALSE, FALSE, FALSE, FALSE};

int main(int argc, char *argv[])
{
	// brightness values
	int max = 0;
	int old = 0;
	int new = 0;

	parse_args(argc, argv);

	if (read_initial_brightness(&max, &old) == -1) {
		fprintf(stderr, "Failed to get initial brightness values\n");
		exit(EXIT_FAILURE);
	}

	new = old;

	if (argp.inc == TRUE) {
		if (new <= (max - STEP)) {
			new += STEP;
		} else {
			new = max;
		}
	} else if (argp.dec == TRUE) {
		if (new >= STEP) {
			new -= STEP;
		} else {
			new = 0;// turn off display
		}
	} else if (argp.set > -1) {
		if (argp.set <= max || argp.set < 0) {
			new = argp.set;
		} else {
			fprintf(stderr, "Desired brightness '%d' exceeds max/min brightness! Exiting.\n", argp.set);
		}
	} else if (argp.off == TRUE) {
		new = 0;
	} else {
		printf("%d of %d\n", old, max);
		exit(EXIT_SUCCESS);
	}

	write_brightness(BRIGHTNESS, new);

	if (argp.verbose == TRUE) {
		printf("Brightness set to: %d from: %d\n", new, old);
	}

	return 0;
}

static void parse_args(int argc, char *argv[])
{
	int m = 0; // mutually exclusive args check
	int opt;
	int option_index = 0;

	while ((opt = getopt_long(argc, argv, opt_string, long_options, &option_index))) {
		if (opt == -1) {
			break;
		}

		switch (opt) {
		case 'v':
			printf("%s: Version %s\n\n%s\n", argv[0], VERSION, VERSION_MSG);
			exit(EXIT_SUCCESS);

		case 's':
			argp.set = parse_int(optarg);
			m++;
			break;

		case 'i':
			argp.inc = TRUE;
			m++;
			break;

		case 'd':
			argp.dec = TRUE;
			m++;
			break;

		case 'o':
			argp.off = TRUE;
			break;

		case 'V':
			argp.verbose = TRUE;
			break;

		case '?':
			exit(EXIT_FAILURE);

		default:
			usage(argv[0]);
		}
	}

	if (m > 1) {
		fprintf(stderr, "%s\n", "Arguments are mutually exclusive. Exiting.");
		exit(EXIT_FAILURE);
	}

	return;
}

static void usage(char *prog_name)
{
	printf("\n%s\n"
		   "\n"
		   "NOTE: If specifying, incrementing, or decrementing the brightness past\n"
		   "past 0 and the max_brightness display setting, the program exits.\n"
		   "\n"
		   "\tUsage: %s [options]\n\n"
		   "\tOptions:\n"
		   "\t  -v, --version     Print versioning information\n"
		   "\t  -s, --set         Set brightness to specified value\n"
		   "\t  -i, --inc         Increment by value\n"
		   "\t  -d, --dec         Decrement by value\n"
		   "\t  -o, --off         Turn off display by setting brightness to zero\n"
		   "\t  -S, --verbose     Verbose all output (Useful when called from i3 bindings)\n"
		   "\t\n", VERSION_MSG, prog_name);
	exit(EXIT_SUCCESS);
}

static int read_initial_brightness(int *max, int *old)
{
	int mod = 0;

	*max = read_brightness(MAX_BRIGHTNESS);
	*old = read_brightness(BRIGHTNESS);

	if (*max <= 0 || *old < 0) {
		if (argp.verbose == TRUE) {
			fprintf(stderr, "Get brightness failed\n");
		}

		return -1;
	}

	// brightness values load with weird numbers now after an Nvidia driver update.
	// current range is 0 -> 1500, yet on battery the brightness starts at 348.
	// need to normalize the value to an even multiple of STEP, to yield 15
	// brightness settings.
	mod = *old % STEP;
	if (mod != 0) {
		*old -= mod;
	}

	return 0;
}

/**
 * Parse input to an integer.
 * This function was taken from the man page for strtol and modified.
 */
static int parse_int(char *str)
{
	char *endptr = NULL;
	errno = 0;
	long n = strtol(str, &endptr, 10); // use base 10

	/* Check for various possible errors */
	if ((errno == ERANGE && (n == LONG_MAX || n == LONG_MIN)) || (errno != 0 && n == 0)) {
		if (argp.verbose == TRUE) {
			perror("Failed to parse int argument");
		}

		exit(EXIT_FAILURE);
	}

	if (endptr == str) {
		if (argp.verbose == TRUE) {
			fprintf(stderr, "No digits were found\n");
		}

		exit(EXIT_FAILURE);
	}

	return n;
}

static int read_brightness(char *filename)
{
	char *buff = NULL;
	size_t size = 0;
	FILE *file = fopen(filename, "r");

	if (file == NULL) {
		if (argp.verbose == TRUE) {
			perror("Failed to read file!");
		}

		return -1;
	}

	int e = getline(&buff, &size, file);
	int err = errno;

	if (e == -1 || err == EINVAL || err == ENOMEM) {
		if (argp.verbose == TRUE) {
			perror("getline failed!");
		}

		return -1;
	}

	if (buff) {
		int value = atoi(buff);
		free(buff);
		buff = NULL;
		size = 0;
		fclose(file);
		return value;
	}

	fclose(file);
	return -1;
}

static void write_brightness(char *filename, int value)
{
	FILE *file = fopen(filename, "w");

	if (file == NULL) {
		perror("Cannot open file for writting!");
		exit(EXIT_FAILURE);
	}

	if (fprintf(file, "%i\n", value) < 0) {
		perror("Cannot write file!");
		exit(EXIT_FAILURE);
	}
}
