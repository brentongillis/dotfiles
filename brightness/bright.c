/**
 * CLI program to adjust my brightness setting. My Dell XPS 15 has hybrid graphics, so I have
 * to use modesetting (this breaks xbacklight). This programs simply reads the brightness and
 * max_brightness files from /sys/class/backlight/intel_backlight/ and makes adjustments on them.
 *
 * NOTE: for this to work, this has to be a binary, which is why I'm not using plain bash.
 * One should change the binaries owner to root and then set the uid bit.
 * chmod u+s brightness
 *
 * Copyright (C) 2017 Brenton Gillis
 */

#include <stdlib.h>
#include <getopt.h>
#include <limits.h>
#include <stdio.h>
#include <errno.h>

#define VERSION "1.0.1"
#define MAX_BRIGHTNESS "/sys/class/backlight/intel_backlight/max_brightness"
#define BRIGHTNESS "/sys/class/backlight/intel_backlight/brightness"
#define TRUE 1
#define FALSE 0

// PROTOTYPES - It is nice to see all functions in one glance
static void parse_args(int argc, char* argv[]);
static int parse_int(char* arg);
static void usage(char* prog_name);
static void check_exclusivity(void);
static int read_brightness(char* filename);
static void write_brightness(char* filename, int value);

static const char* opt_string = "hvs:i:d:V?";
static const struct option long_options[] = {
	{"help", no_argument, 0, 'h'},
	{"version", no_argument, 0, 'v'},
	{"set", required_argument, 0 , 's'},
	{"inc", required_argument, 0 , 'i'},
	{"dec", required_argument, 0 , 'd'},
	{"verbose", no_argument, 0 , 'V'},
	{0, 0, 0, 0}
};

static const char* VERSION_MSG = "Copyright (C) 2017 Brenton Gillis\n";

typedef struct {
	long inc;
	long set;
	long dec;
	int verbose;
} arguments;

static arguments argp;

int main(int argc, char* argv[])
{
	argp = (arguments) {
		-1, -1, -1, FALSE
	};
	parse_args(argc, argv);
	// brightness values
	int max = 0;
	int old = 0;
	int new = 0;
	max = read_brightness(MAX_BRIGHTNESS);
	old = read_brightness(BRIGHTNESS);

	if (max <= 0 || old < 0) {
		if (argp.verbose == TRUE) {
			fprintf(stderr, "Get brightness failed\n");
		}

		exit(EXIT_FAILURE);
	}

	new = old;

	if (argp.inc > 0) {
		new += argp.inc;
	} else if (argp.dec > 0) {
		new -= argp.dec;
	} else if (argp.set > 0) {
		new = argp.set;
	} else {
		printf("%d of %d\n", old, max);
		exit(EXIT_SUCCESS);
	}

	if (new >= 0 && new <= max) {
		write_brightness(BRIGHTNESS, new);

		if (argp.verbose == TRUE) {
			printf("Brightness set to: %d from: %d\n", new, old);
		}
	} else {
		if (argp.verbose == TRUE) {
			fprintf(stderr, "Error! Attempted to set brightness out of bounds.\n");
		}

		exit(EXIT_FAILURE);
	}

	return 0;
}

static void parse_args(int argc, char* argv[])
{
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
			check_exclusivity();
			argp.set = parse_int(optarg);
			break;

		case 'i':
			check_exclusivity();
			argp.inc = parse_int(optarg);
			break;

		case 'd':
			check_exclusivity();
			argp.dec = parse_int(optarg);
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

	return;
}

static void usage(char* prog_name)
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
	       "\t  -S, --verbose     Verbose all output (Useful when called from i3 bindings)\n"
	       "\t\n", VERSION_MSG, prog_name);
	exit(EXIT_SUCCESS);
}

/**
 * Parse input to an integer.
 * This function was taken from the man page for strtol and modified.
 */
static int parse_int(char* str)
{
	char* endptr = NULL;
	errno = 0;    /* To distinguish success/failure after call */
	long val = strtol(str, &endptr, 10); // use base 10

	/* Check for various possible errors */
	if ((errno == ERANGE && (val == LONG_MAX || val == LONG_MIN)) || (errno != 0 && val == 0)) {
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

	return val;
}

/**
 * Checks if more than one argument was set. All arguments are mutually exclusive.
 * Simply wouldn't make sense to increment and decrement the brightness...
 */
static void check_exclusivity(void)
{
	if (argp.inc > -1 || argp.dec > -1 || argp.set > -1) {
		if (argp.verbose == TRUE) {
			fprintf(stderr, "%s\n", "Arguments are mutually exclusive.");
		}

		exit(EXIT_FAILURE);
	}
}

static int read_brightness(char* filename)
{
	char* buff = NULL;
	size_t size = 0;
	FILE* file = fopen(filename, "r");

	if (file == NULL) {
		if (argp.verbose == TRUE) {
			perror("Failed to read file!");
		}

		return -1;
	}

	getline(&buff, &size, file);

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

static void write_brightness(char* filename, int value)
{
	FILE* file = fopen(filename, "w");

	if (file == NULL) {
		perror("Cannot open file for writting!");
		exit(EXIT_FAILURE);
	}

	if (fprintf(file, "%i\n", value) < 0) {
		perror("Cannot write file!");
		exit(EXIT_FAILURE);
	}
}
