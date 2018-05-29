#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <X11/Xlib.h>

#define DELAY 5

static const char *UEVENT = "/sys/class/power_supply/BAT0/uevent";
static const char *DELIM = "=";

const char *STATUS = "POWER_SUPPLY_STATUS";
const char *FULL = "POWER_SUPPLY_CHARGE_FULL";
const char *NOW = "POWER_SUPPLY_CHARGE_NOW";

// Battery info from uevent
struct batt_info {
	char status[128];
	int charge_full;
	int charge_now;
};

static Display *dpy;

void setstatus(char *str) {
	XStoreName(dpy, DefaultRootWindow(dpy), str);
	XSync(dpy, False);
}

float battery()
{
	FILE *fd;
	fd = fopen(UEVENT, "r");

	if (fd == NULL) {
		fprintf(stderr, "Error opening capacity.\n");
		return -1;
	}

	struct batt_info b;
	char line[128];
	char *name;
	char *tok;

	while (fgets(line, sizeof line, fd) != NULL) {
		name = strtok(line, DELIM);

		if (strcmp(name, STATUS) == 0) {
			tok = strtok(NULL, DELIM);

			if (tok != NULL) {
				// Remove the newline
				tok[strcspn(tok, "\n")] = 0;
				strcpy(b.status, tok);
			}

		} else if (strcmp(name, FULL) == 0) {
			tok = strtok(NULL, DELIM);

			if (tok != NULL) {
				b.charge_full = atoi(tok);
			}

		} else if (strcmp(name, NOW) == 0) {
			tok = strtok(NULL, DELIM);

			if (tok != NULL) {
				b.charge_now = atoi(tok);
			}
		}
	}

	fclose(fd);
	return (float)b.charge_now / (float)b.charge_full * 100;
}

char *datetime()
{
	char *buf;
	time_t result;
	struct tm *resulttm;

	if((buf = malloc(sizeof(char)*32)) == NULL) {
		fprintf(stderr, "Cannot allocate memory for buf.\n");
		return NULL;
	}
	result = time(NULL);
	resulttm = localtime(&result);
	if(resulttm == NULL) {
		fprintf(stderr, "Error getting localtime.\n");
		return NULL;
	}
	if(!strftime(buf, sizeof(char)*32-1, "%F %H:%M:%S", resulttm)) {
		fprintf(stderr, "strftime is 0.\n");
		return NULL;
	}

	return buf;
}

int main(int argc, char *argv[])
{
	char *status;

	if (!(dpy = XOpenDisplay(NULL))) {
		fprintf(stderr, "Cannot open display.\n");
		return 1;
	}

	if ((status = malloc(200)) == NULL) {
		exit(1);
	}

	for (;;sleep(DELAY)) {
		snprintf(status, 200, "%.2f%% | %s", battery(), datetime());
		setstatus(status);
	}

	free(status);
	XCloseDisplay(dpy);

	return 0;
}
