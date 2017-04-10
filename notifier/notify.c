#include <libnotify/notify.h>
#include <getopt.h>
#include <stdlib.h>
#include <errno.h>

static void usage(char *prog_name);
static void parse_args(int argc, char **argv);
static int parse_int(char *str);

#define U_LEVEL 1

static const gint URGENCY[3] = {
	NOTIFY_URGENCY_LOW, NOTIFY_URGENCY_NORMAL, NOTIFY_URGENCY_CRITICAL
};

// help, timeout, message, body, level
static const char *opt_string = "hs:b:t:l:?";
static const struct option long_options[] = {
	{"help", no_argument, 0, 'h'},
	{"message", required_argument, 0 , 'm'},
	{"body", required_argument, 0 , 'b'},
	{"timeout", required_argument, 0 , 't'},
	{"urgency", required_argument, 0 , 'u'},
	{0, 0, 0, 0}
};

typedef struct {
	char *message;
	char *body;
	int timeout;
	int level;
} arguments;

static arguments args;

int main(int argc, char **argv)
{
	args = (arguments) { NULL, NULL, -1, U_LEVEL };
	parse_args(argc, argv);

	NotifyNotification *n = NULL;
	notify_init("n");
	n = notify_notification_new(args.message, args.body, NULL);// null for no icon
    if (args.timeout != -1) {
        notify_notification_set_timeout(n, args.timeout);//ms
    }
	notify_notification_set_urgency(n, URGENCY[args.level]);
	notify_notification_show(n, NULL);
	g_object_unref(G_OBJECT(n));
	notify_uninit();
	return 0;
}

static void usage(char *prog_name)
{
	printf("\n"
	       "Simple notifcation program using libnotify for messaging.\n"
	       "I wrote this program so I could schedule it with at/cron to notify myself\n"
	       "of important events during the day (work tasks/reminders/and errors).\n"
           "That, and I like to dink around.\n"
	       "\n"
	       "\tUsage: %s <required> [options]\n"
	       "\n"
	       "\tRequired:\n"
	       "\t  -m, --message     Notification text\n"
	       "\n"
	       "\tOptions:\n"
	       "\t  -m, --body        Notification body\n"
	       "\t  -t, --timeout     Notification timeout\n"
	       "\t  -u, --urgency     Urgency level\n"
	       "\t\n", prog_name);
	exit(EXIT_SUCCESS);
}

static void parse_args(int argc, char **argv)
{
	int opt;
	int option_index = 0;

	while ((opt = getopt_long(argc, argv, opt_string, long_options, &option_index))) {
		if (opt == -1) {
			break;
		}

		switch (opt) {
		case 'm':
			args.message = optarg;
			break;

		case 'b':
			args.body = optarg;
			break;

		case 't':
			args.timeout = parse_int(optarg);
			break;

		case 'u':
			args.level = parse_int(optarg);
			break;

		case '?':
			exit(EXIT_FAILURE);

		default:
			usage(argv[0]);
		}
	}

    if (args.message == NULL) {
        fprintf(stderr, "Error::Missing Required Argument! message is required.\n");
        usage(argv[0]);
    }
}

static int parse_int(char *str)
{
	char *endptr = NULL;
	errno = 0;    /* To distinguish success/failure after call */
	int val = strtol(str, &endptr, 10); // use base 10

	/* Check for various possible errors */
	if ((errno == ERANGE && (val == LONG_MAX || val == LONG_MIN)) || (errno != 0 && val == 0)) {
		exit(EXIT_FAILURE);
	}

	if (endptr == str) {
		exit(EXIT_FAILURE);
	}

	return val;
}
