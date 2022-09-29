#!/usr/bin/env python3
import socket
import sys
import os
from subprocess import call
from subprocess import PIPE, run

import logging
from logging.config import fileConfig

fileConfig('logging_config.ini')
logger = logging.getLogger('streamthis')

CSV_FILE="/app/channels.csv"
FILE_TO_ENCODE=sys.argv[1]
logger.debug("file to encode: %s", FILE_TO_ENCODE)

def touch(fname, times=None):
    with open(fname, 'a'):
        os.utime(fname, times)

WAV_FILE=os.path.basename(FILE_TO_ENCODE)
logger.debug("WAV_FILE: %s", WAV_FILE)

DIRECTORY=os.path.dirname(FILE_TO_ENCODE)
logger.debug("DIRECTORY: %s", DIRECTORY)

a = WAV_FILE.split('.')
FILENAME = a[0]
logger.debug("FILENAME: %s", FILENAME)

MP3_FILE="{0}/{1}.mp3".format(DIRECTORY, FILENAME)
logger.debug("MP3_FILE: %s", MP3_FILE)

a = FILENAME.split('-')
TALKGROUP = a[0]
logger.debug("TALKGROUP: %s", TALKGROUP)

command = ['/bin/grep', TALKGROUP, CSV_FILE]
result = run(command, stdout=PIPE, stderr=PIPE, universal_newlines=True)
#print(result.returncode, result.stdout, result.stderr)
csvline = result.stdout
logger.debug("csvline: %s", csvline)
a = csvline.split(',')
ALPHA, STREAM_LIST = a[3], a[8]
logger.debug("ALPHA: %s", ALPHA)
logger.debug("STREAM_LIST: %s", STREAM_LIST)

if (STREAM_LIST.strip() == ''):
    logger.info("No Stream for [%s] %s", TALKGROUP, ALPHA)
    quit(0)

logger.debug("Calling: %s %s %s %s %s %s %s", "/usr/bin/lame", "--quiet", "--preset", "voice", "--tt", "\"{0}\"".format(ALPHA), FILE_TO_ENCODE)
call(["/usr/bin/lame", "--quiet", "--preset", "voice", "--tt", "\"{0}\"".format(ALPHA), FILE_TO_ENCODE])

if os.path.exists(FILE_TO_ENCODE):
  os.remove(FILE_TO_ENCODE)

streams = STREAM_LIST.split('|')
servers = []

for stream in streams:
    logger.debug(">>>>> %s, %s is in the list", stream, TALKGROUP)
    touch("/tmp/streamthis-{0}-lastrun".format(stream))

    stream_address = "/app/streams/{0}.sock".format(stream)
    logger.debug("[%s] matched for %s, sending to: %s", TALKGROUP, stream, stream_address)
    servers.append(stream_address)

if len(servers) < 1:
    logger.error("Talkgroup [%s] did not have any streams in the list: %s", TALKGROUP, STREAM_LIST)
    exit(1)

for server_address in servers:
    logger.debug("address: %s", server_address)
    # Create a UDS socket
    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

    try:
        sock.connect(server_address)
    except socket.error as msg:
        sys.exit(1)

    try:
        # Send data
        logger.info('%s %s %s', TALKGROUP, "sending to: ", server_address)
        logger.debug('queue.push {0}\n\r'.format(MP3_FILE))
        message = 'queue.push {0}\n\r'.format(MP3_FILE)
        sock.sendall(message)

        amount_received = 0
        amount_expected = len(message)

        data = sock.recv(16)
        amount_received += len(data)

    finally:
        match = 0
        sock.close()
