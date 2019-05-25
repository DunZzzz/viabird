#!/usr/bin/python
#
# pir.py
#

# Import required Python libraries
import time
import RPi.GPIO as GPIO
import requests
import logging
import signal
import sys
import threading
import subprocess

URL_ZIBASE = 'http://192.168.0.100/cgi-bin/domo.cgi?CMD=LM%2049'
MOTION_ALARM_DELAY =  3

logging.basicConfig(format='%(asctime)s %(levelname)s:%(message)s', filename='/var/log/pir.log',level=logging.DEBUG)

def handler(signum = None, frame = None):
    logging.debug (' Signal handler called with signal '+ str(signum) )
    time.sleep(1)  #here check if process is done
    logging.debug( ' Wait done')
    sys.exit(0)

for sig in [signal.SIGTERM, signal.SIGINT, signal.SIGHUP, signal.SIGQUIT]:
    signal.signal(sig, handler)

# Each request  gets its own thread
class RequestThread(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
    def run(self):
        try:
           result = requests.get(url = URL_ZIBASE)
           logging.debug(" %s -&gt; %s" % (threading.current_thread(), result))
        except requests.ConnectionError, e:
           logging.warning(' %s CONNECTION ERROR %s' % (threading.current_thread(), e) )


# Use BCM GPIO references
# instead of physical pin numbers
GPIO.setmode(GPIO.BCM)

# Define GPIO to use on Pi
GPIO_PIR = 27

logging.info( "PIR Module Holding Time Test (CTRL-C to exit)")

# Set pin as input
GPIO.setup(GPIO_PIR,GPIO.IN)

Current_State  = 0
Previous_State = 0

try:

  logging.info('Waiting for PIR to settle ...')

  # Loop until PIR output is 0
  while GPIO.input(GPIO_PIR)==1:
    Current_State  = 0

  logging.info('  Ready')

  # Loop until users quits with CTRL-C
  while True :

    # Read PIR state
    Current_State = GPIO.input(GPIO_PIR)

    if Current_State==1 and Previous_State==0:
      # PIR is triggered
      start_time=time.time()
      logging.info(' Motion detected!')
      subprocess.call("picture.sh", shell=True)
      Previous_State=1
      RequestThread().start()

    elif Current_State==0 and Previous_State==1:
      # PIR has returned to ready state
      stop_time=time.time()
      elapsed_time=int(stop_time-start_time)
      logging.info(" (Elapsed time : " + str(elapsed_time) + " secs)")
      Previous_State=0
      logging.info(' Going to sleep for %s seconds' % (MOTION_ALARM_DELAY))
      time.sleep(MOTION_ALARM_DELAY)
      logging.info('  Ready')

    time.sleep(1)

finally:
	logging.info( "  Reset GPIO settings &amp; Quit")
	# Reset GPIO settings
	GPIO.cleanup()
